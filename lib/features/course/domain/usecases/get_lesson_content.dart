import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:sunnova_app/core/error/failures.dart';
import 'package:sunnova_app/core/usecases/usecase.dart';
import 'package:sunnova_app/features/course/domain/entities/content_lesson_entity.dart';
import 'package:sunnova_app/features/course/domain/repositories/course_repository.dart';

class GetLessonContent implements UseCase<ContentLessonEntity, LessonContentParams> {
  final CourseRepository repository;

  GetLessonContent(this.repository);

  @override
  Future<Either<Failure, ContentLessonEntity>> call(LessonContentParams params) async {
    return await repository.getLessonContent(params.lessonId);
  }
}

class LessonContentParams extends Equatable {
  final String lessonId;

  const LessonContentParams({required this.lessonId});

  @override
  List<Object?> get props => [lessonId];
}