import 'package:sunnova_app/core/error/exceptions.dart';
import 'package:sunnova_app/features/home/data/models/user_game_stats_model.dart';
import 'package:sunnova_app/features/home/data/models/course_module_model.dart';
import 'package:sunnova_app/core/db/database_helper.dart'; // Import DatabaseHelper

abstract class HomeLocalDataSource {
  Future<UserGameStatsModel> getUserGameStats(String userId);
  Future<List<CourseModuleModel>> getCourseModules();
  Future<void> saveUserGameStats(UserGameStatsModel stats);
  Future<void> saveCourseModules(List<CourseModuleModel> modules);
}

class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  final DatabaseHelper databaseHelper;

  HomeLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<UserGameStatsModel> getUserGameStats(String userId) async {
    try {
      final statsMap = await databaseHelper.getUserGameStats(userId);
      if (statsMap != null) {
        return UserGameStatsModel.fromMap(statsMap);
      }
      throw DatabaseException('User game stats not found for userId: $userId');
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<List<CourseModuleModel>> getCourseModules() async {
    try {
      final moduleMaps = await databaseHelper.getAllCourseModules();
      return moduleMaps.map((map) => CourseModuleModel.fromMap(map)).toList();
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<void> saveUserGameStats(UserGameStatsModel stats) async {
    try {
      await databaseHelper.insertUserGameStats(stats.toMap());
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<void> saveCourseModules(List<CourseModuleModel> modules) async {
    try {
      for (var module in modules) {
        await databaseHelper.insertCourseModule(module.toMap());
      }
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }
}
