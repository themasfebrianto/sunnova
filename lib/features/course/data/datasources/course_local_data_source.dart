import 'package:sunnova_app/core/error/exceptions.dart';
import 'package:sunnova_app/features/home/data/models/course_module_model.dart';
import 'package:sunnova_app/features/course/data/models/lesson_unit_model.dart';
import 'package:sunnova_app/features/course/data/models/user_lesson_progress_model.dart';
import 'package:sunnova_app/core/db/database_helper.dart'; // Import DatabaseHelper

abstract class CourseLocalDataSource {
  Future<CourseModuleModel> getCourseDetail(String moduleId);
  Future<List<LessonUnitModel>> getLessonUnits(String moduleId, String userId);
  Future<UserLessonProgressModel> getUserLessonProgress(String userId, String lessonId);
  Future<void> markLessonAsCompleted(String userId, String lessonId);
  Future<LessonUnitModel> getLessonContent(String lessonId);
}

class CourseLocalDataSourceImpl implements CourseLocalDataSource {
  final DatabaseHelper databaseHelper;

  CourseLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<CourseModuleModel> getCourseDetail(String moduleId) async {
    try {
      final moduleMap = await databaseHelper.getCourseModule(moduleId);
      if (moduleMap != null) {
        return CourseModuleModel.fromMap(moduleMap);
      }
      throw DatabaseException('Course module not found for id: $moduleId');
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<List<LessonUnitModel>> getLessonUnits(String moduleId, String userId) async {
    try {
      final lessonMaps = await databaseHelper.getLessonUnitsByModuleId(moduleId, userId);
      return lessonMaps.map((map) => LessonUnitModel.fromMap(map)).toList();
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<UserLessonProgressModel> getUserLessonProgress(String userId, String lessonId) async {
    try {
      final progressMap = await databaseHelper.getUserLessonProgress(userId, lessonId);
      if (progressMap != null) {
        return UserLessonProgressModel.fromMap(progressMap);
      }
      // If no progress found, return a default uncompleted state
      return UserLessonProgressModel(
        userId: userId,
        lessonId: lessonId,
        isCompleted: false,
        completedAt: null,
      );
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<void> markLessonAsCompleted(String userId, String lessonId) async {
    try {
      final progress = UserLessonProgressModel(
        userId: userId,
        lessonId: lessonId,
        isCompleted: true,
        completedAt: DateTime.now(),
      );
      await databaseHelper.insertUserLessonProgress(progress.toMap());
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<LessonUnitModel> getLessonContent(String lessonId) async {
    try {
      final lessonMap = await databaseHelper.getLessonUnit(lessonId);
      if (lessonMap != null) {
        return LessonUnitModel.fromMap(lessonMap);
      }
      throw DatabaseException('Lesson unit not found for id: $lessonId');
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }
}
