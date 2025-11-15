import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:sunnova_app/core/error/failures.dart';
import 'package:sunnova_app/core/usecases/usecase.dart';
import 'package:sunnova_app/features/quiz/domain/entities/user_answer_log_entity.dart';
import 'package:sunnova_app/features/quiz/domain/repositories/quiz_repository.dart';

class SubmitQuizAnswers extends UseCase<void, SubmitQuizAnswersParams> {
  final QuizRepository repository;

  SubmitQuizAnswers(this.repository);

  @override
  Future<Either<Failure, void>> call(SubmitQuizAnswersParams params) async {
    return await repository.submitQuizAnswers(
        params.userId, params.lessonId, params.answers);
  }
}

class SubmitQuizAnswersParams extends Equatable {
  final String userId;
  final String lessonId;
  final List<UserAnswerLogEntity> answers;

  const SubmitQuizAnswersParams({
    required this.userId,
    required this.lessonId,
    required this.answers,
  });

  @override
  List<Object?> get props => [userId, lessonId, answers];
}
