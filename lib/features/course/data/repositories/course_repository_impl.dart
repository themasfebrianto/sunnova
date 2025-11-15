import 'package:dartz/dartz.dart';
import 'package:sunnova_app/core/error/exceptions.dart';
import 'package:sunnova_app/core/error/failures.dart';
import 'package:sunnova_app/features/home/domain/entities/course_module_entity.dart';
import 'package:sunnova_app/features/course/data/datasources/course_local_data_source.dart';
import 'package:sunnova_app/features/course/domain/entities/content_lesson_entity.dart';
import 'package:sunnova_app/features/course/domain/entities/lesson_unit_entity.dart';
import 'package:sunnova_app/features/course/domain/entities/user_lesson_progress_entity.dart';
import 'package:sunnova_app/features/course/domain/repositories/course_repository.dart';

class CourseRepositoryImpl implements CourseRepository {
  final CourseLocalDataSource localDataSource;

  CourseRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, CourseModuleEntity>> getCourseDetail(String moduleId) async {
    try {
      final courseModuleModel = await localDataSource.getCourseDetail(moduleId);
      return Right(courseModuleModel);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<LessonUnitEntity>>> getLessonUnits(String moduleId, String userId) async {
    try {
      final lessonUnitModels = await localDataSource.getLessonUnits(moduleId, userId);
      return Right(lessonUnitModels);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, UserLessonProgressEntity>> getUserLessonProgress(String userId, String lessonId) async {
    try {
      final userLessonProgressModel = await localDataSource.getUserLessonProgress(userId, lessonId);
      return Right(userLessonProgressModel);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> markLessonAsCompleted(String userId, String lessonId) async {
    try {
      await localDataSource.markLessonAsCompleted(userId, lessonId);
      return const Right(null);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, ContentLessonEntity>> getLessonContent(String lessonId) async {
    try {
      final contentLessonModel = await localDataSource.getLessonContent(lessonId);
      return Right(contentLessonModel);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }
}
