import 'package:sunnova_app/core/error/exceptions.dart';
import 'package:sunnova_app/features/auth/data/models/user_model.dart'; // For UserModel
import 'package:sunnova_app/features/profile/data/models/user_achievement_model.dart';
import 'package:sunnova_app/features/profile/data/models/badge_model.dart';
import 'package:sunnova_app/core/db/database_helper.dart'; // Import DatabaseHelper

abstract class ProfileLocalDataSource {
  Future<UserModel> getUserProfile(String userId);
  Future<List<UserAchievementModel>> getUserAchievements(String userId);
  Future<List<BadgeModel>> getBadges();
}

class ProfileLocalDataSourceImpl implements ProfileLocalDataSource {
  final DatabaseHelper databaseHelper;

  ProfileLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<UserModel> getUserProfile(String userId) async {
    try {
      final userMap = await databaseHelper.getUser(userId);
      if (userMap != null) {
        return UserModel.fromMap(userMap);
      }
      throw DatabaseException('User not found for id: $userId');
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<List<UserAchievementModel>> getUserAchievements(String userId) async {
    try {
      final achievementMaps = await databaseHelper.getUserAchievements(userId);
      return achievementMaps.map((map) => UserAchievementModel.fromMap(map)).toList();
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<List<BadgeModel>> getBadges() async {
    try {
      final badgeMaps = await databaseHelper.getAllBadges();
      return badgeMaps.map((map) => BadgeModel.fromMap(map)).toList();
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }
}
