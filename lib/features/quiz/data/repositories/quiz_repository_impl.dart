import 'package:dartz/dartz.dart';
import 'package:sunnova_app/core/error/exceptions.dart';
import 'package:sunnova_app/core/error/failures.dart';
import 'package:sunnova_app/features/quiz/data/datasources/quiz_local_data_source.dart';
import 'package:sunnova_app/features/quiz/data/models/user_answer_log_model.dart';
import 'package:sunnova_app/features/quiz/domain/entities/assessment_question_entity.dart';
import 'package:sunnova_app/features/quiz/domain/entities/user_answer_log_entity.dart';
import 'package:sunnova_app/features/quiz/domain/repositories/quiz_repository.dart';

class QuizRepositoryImpl implements QuizRepository {
  final QuizLocalDataSource localDataSource;

  QuizRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<AssessmentQuestionEntity>>> getQuizQuestions(String lessonId) async {
    try {
      final quizQuestions = await localDataSource.getQuizQuestions(lessonId);
      return Right(quizQuestions);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> submitQuizAnswers(String userId, String lessonId, List<UserAnswerLogEntity> answers) async {
    try {
      // Convert entities to models for the data source
      final answerModels = answers.map((e) => UserAnswerLogModel(
        id: e.id,
        userId: e.userId,
        questionId: e.questionId,
        selectedAnswerIndex: e.selectedAnswerIndex,
        isCorrect: e.isCorrect,
        isHintUsed: e.isHintUsed,
        attemptedAt: e.attemptedAt,
      )).toList();
      await localDataSource.submitQuizAnswers(userId, lessonId, answerModels);
      return const Right(null);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }
}
