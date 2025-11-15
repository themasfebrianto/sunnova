import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:sunnova_app/core/error/failures.dart';
import 'package:sunnova_app/core/usecases/usecase.dart';
import 'package:sunnova_app/features/course/domain/entities/lesson_unit_entity.dart';
import 'package:sunnova_app/features/course/domain/repositories/course_repository.dart';

class GetLessonUnits
    extends UseCase<List<LessonUnitEntity>, GetLessonUnitsParams> {
  final CourseRepository repository;

  GetLessonUnits(this.repository);

  @override
  Future<Either<Failure, List<LessonUnitEntity>>> call(
    GetLessonUnitsParams params,
  ) async {
    return await repository.getLessonUnits(params.moduleId, params.userId);
  }
}

class GetLessonUnitsParams extends Equatable {
  final String moduleId;
  final String userId;

  const GetLessonUnitsParams({required this.moduleId, required this.userId});

  @override
  List<Object?> get props => [moduleId];
}
