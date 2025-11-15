import 'package:dartz/dartz.dart';
import 'package:sunnova_app/core/error/failures.dart';
import 'package:sunnova_app/features/quiz/domain/entities/assessment_question_entity.dart';
import 'package:sunnova_app/features/quiz/domain/entities/user_answer_log_entity.dart';

abstract class QuizRepository {
  Future<Either<Failure, List<AssessmentQuestionEntity>>> getQuizQuestions(String lessonId);
  Future<Either<Failure, void>> submitQuizAnswers(String userId, String lessonId, List<UserAnswerLogEntity> answers);
}
