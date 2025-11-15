import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:sunnova_app/core/error/failures.dart';
import 'package:sunnova_app/core/usecases/usecase.dart';
import 'package:sunnova_app/features/home/domain/entities/course_module_entity.dart';
import 'package:sunnova_app/features/course/domain/repositories/course_repository.dart';

class GetCourseDetail extends UseCase<CourseModuleEntity, GetCourseDetailParams> {
  final CourseRepository repository;

  GetCourseDetail(this.repository);

  @override
  Future<Either<Failure, CourseModuleEntity>> call(GetCourseDetailParams params) async {
    return await repository.getCourseDetail(params.moduleId);
  }
}

class GetCourseDetailParams extends Equatable {
  final String moduleId;

  const GetCourseDetailParams({required this.moduleId});

  @override
  List<Object?> get props => [moduleId];
}
