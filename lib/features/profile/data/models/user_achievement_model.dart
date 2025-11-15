import 'package:sunnova_app/features/profile/domain/entities/user_achievement_entity.dart';

class UserAchievementModel extends UserAchievementEntity {
  const UserAchievementModel({
    required super.id,
    required super.userId,
    required super.badgeId,
    required super.unlockedAt,
    required super.isNew,
  });

  factory UserAchievementModel.fromJson(Map<String, dynamic> json) {
    return UserAchievementModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      badgeId: json['badgeId'] as String,
      unlockedAt: DateTime.parse(json['unlockedAt'] as String),
      isNew: json['isNew'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'badgeId': badgeId,
      'unlockedAt': unlockedAt.toIso8601String(),
      'isNew': isNew,
    };
  }

  factory UserAchievementModel.fromMap(Map<String, dynamic> map) {
    return UserAchievementModel(
      id: map['id'] as String,
      userId: map['userId'] as String,
      badgeId: map['badgeId'] as String,
      unlockedAt: DateTime.parse(map['unlockedAt'] as String),
      isNew: (map['isNew'] as int) == 1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'badgeId': badgeId,
      'unlockedAt': unlockedAt.toIso8601String(),
      'isNew': isNew ? 1 : 0,
    };
  }
}
