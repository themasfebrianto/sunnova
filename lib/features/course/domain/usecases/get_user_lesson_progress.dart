import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:sunnova_app/core/error/failures.dart';
import 'package:sunnova_app/core/usecases/usecase.dart';
import 'package:sunnova_app/features/course/domain/entities/user_lesson_progress_entity.dart';
import 'package:sunnova_app/features/course/domain/repositories/course_repository.dart';

class GetUserLessonProgress
    extends UseCase<UserLessonProgressEntity, GetUserLessonProgressParams> {
  final CourseRepository repository;

  GetUserLessonProgress(this.repository);

  @override
  Future<Either<Failure, UserLessonProgressEntity>> call(
    GetUserLessonProgressParams params,
  ) async {
    return await repository.getUserLessonProgress(
      params.userId,
      params.lessonId,
    );
  }
}

class GetUserLessonProgressParams extends Equatable {
  final String userId;
  final String lessonId;

  const GetUserLessonProgressParams({
    required this.userId,
    required this.lessonId,
  });

  @override
  List<Object?> get props => [userId, lessonId];
}
