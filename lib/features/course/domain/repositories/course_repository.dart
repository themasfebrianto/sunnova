import 'package:dartz/dartz.dart';
import 'package:sunnova_app/core/error/failures.dart';
import 'package:sunnova_app/features/course/domain/entities/content_lesson_entity.dart';
import 'package:sunnova_app/features/course/domain/entities/user_lesson_progress_entity.dart';
import 'package:sunnova_app/features/home/domain/entities/course_module_entity.dart'; // For CourseModuleEntity
import 'package:sunnova_app/features/course/domain/entities/lesson_unit_entity.dart'; // For LessonUnitEntity
// For UserLessonProgressEntity

abstract class CourseRepository {
  Future<Either<Failure, CourseModuleEntity>> getCourseDetail(String moduleId);
  Future<Either<Failure, List<LessonUnitEntity>>> getLessonUnits(
    String moduleId,
    String userId,
  );
  Future<Either<Failure, UserLessonProgressEntity>> getUserLessonProgress(
    String userId,
    String lessonId,
  );
  Future<Either<Failure, void>> markLessonAsCompleted(
    String userId,
    String lessonId,
  );
  Future<Either<Failure, ContentLessonEntity>> getLessonContent(String lessonId);
}
