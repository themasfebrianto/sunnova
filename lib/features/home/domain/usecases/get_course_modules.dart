import 'package:dartz/dartz.dart';
import 'package:sunnova_app/core/error/failures.dart';
import 'package:sunnova_app/core/usecases/usecase.dart';
import 'package:sunnova_app/features/home/domain/entities/course_module_entity.dart';
import 'package:sunnova_app/features/home/domain/repositories/home_repository.dart';

class GetCourseModules extends UseCase<List<CourseModuleEntity>, NoParams> {
  final HomeRepository repository;

  GetCourseModules(this.repository);

  @override
  Future<Either<Failure, List<CourseModuleEntity>>> call(NoParams params) async {
    return await repository.getCourseModules();
  }
}
