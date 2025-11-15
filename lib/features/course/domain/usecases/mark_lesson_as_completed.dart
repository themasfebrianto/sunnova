import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:sunnova_app/core/error/failures.dart';
import 'package:sunnova_app/core/usecases/usecase.dart';
import 'package:sunnova_app/features/course/domain/repositories/course_repository.dart';

class MarkLessonAsCompleted extends UseCase<void, MarkLessonAsCompletedParams> {
  final CourseRepository repository;

  MarkLessonAsCompleted(this.repository);

  @override
  Future<Either<Failure, void>> call(MarkLessonAsCompletedParams params) async {
    return await repository.markLessonAsCompleted(params.userId, params.lessonId);
  }
}

class MarkLessonAsCompletedParams extends Equatable {
  final String userId;
  final String lessonId;

  const MarkLessonAsCompletedParams({required this.userId, required this.lessonId});

  @override
  List<Object?> get props => [userId, lessonId];
}
