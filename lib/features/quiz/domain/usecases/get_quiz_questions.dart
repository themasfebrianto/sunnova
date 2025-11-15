import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:sunnova_app/core/error/failures.dart';
import 'package:sunnova_app/core/usecases/usecase.dart';
import 'package:sunnova_app/features/quiz/domain/entities/assessment_question_entity.dart';
import 'package:sunnova_app/features/quiz/domain/repositories/quiz_repository.dart';

class GetQuizQuestions extends UseCase<List<AssessmentQuestionEntity>, GetQuizQuestionsParams> {
  final QuizRepository repository;

  GetQuizQuestions(this.repository);

  @override
  Future<Either<Failure, List<AssessmentQuestionEntity>>> call(GetQuizQuestionsParams params) async {
    return await repository.getQuizQuestions(params.lessonId);
  }
}

class GetQuizQuestionsParams extends Equatable {
  final String lessonId;

  const GetQuizQuestionsParams({required this.lessonId});

  @override
  List<Object?> get props => [lessonId];
}
