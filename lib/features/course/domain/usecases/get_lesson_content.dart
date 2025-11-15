import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:sunnova_app/core/error/failures.dart';
import 'package:sunnova_app/core/usecases/usecase.dart';
import 'package:sunnova_app/features/course/domain/entities/lesson_unit_entity.dart';
import 'package:sunnova_app/features/course/domain/repositories/course_repository.dart';

class GetLessonContent extends UseCase<LessonUnitEntity, GetLessonContentParams> {
  final CourseRepository repository;

  GetLessonContent(this.repository);

  @override
  Future<Either<Failure, LessonUnitEntity>> call(GetLessonContentParams params) async {
    return await repository.getLessonContent(params.lessonId);
  }
}

class GetLessonContentParams extends Equatable {
  final String lessonId;

  const GetLessonContentParams({required this.lessonId});

  @override
  List<Object?> get props => [lessonId];
}
