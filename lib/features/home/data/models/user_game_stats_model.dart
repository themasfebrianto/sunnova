import 'package:sunnova_app/features/home/domain/entities/user_game_stats_entity.dart';

class UserGameStatsModel extends UserGameStatsEntity {
  const UserGameStatsModel({
    required super.userName,
    required super.xp,
    required super.level,
    required super.currentXp,
    required super.xpToNextLevel,
    required super.currentStreak,
    required super.longestStreak,
    required super.lessonsCompleted,
    required super.quizzesPassed,
    required super.totalXp,
  });

  factory UserGameStatsModel.fromJson(Map<String, dynamic> json) {
    return UserGameStatsModel(
      userName: json['userName'] as String,
      xp: json['xp'] as int,
      level: json['level'] as int,
      currentXp: json['currentXp'] as int,
      xpToNextLevel: json['xpToNextLevel'] as int,
      currentStreak: json['currentStreak'] as int,
      longestStreak: json['longestStreak'] as int,
      lessonsCompleted: json['lessonsCompleted'] as int,
      quizzesPassed: json['quizzesPassed'] as int,
      totalXp: json['totalXp'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'xp': xp,
      'level': level,
      'currentXp': currentXp,
      'xpToNextLevel': xpToNextLevel,
      'currentStreak': currentStreak,
      'longestStreak': longestStreak,
      'lessonsCompleted': lessonsCompleted,
      'quizzesPassed': quizzesPassed,
      'totalXp': totalXp,
    };
  }

  factory UserGameStatsModel.fromMap(Map<String, dynamic> map) {
    return UserGameStatsModel(
      userName: map['userName'] as String,
      xp: map['xp'] as int,
      level: map['level'] as int,
      currentXp: map['currentXp'] as int,
      xpToNextLevel: map['xpToNextLevel'] as int,
      currentStreak: map['currentStreak'] as int,
      longestStreak: map['longestStreak'] as int,
      lessonsCompleted: map['lessonsCompleted'] as int,
      quizzesPassed: map['quizzesPassed'] as int,
      totalXp: map['totalXp'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
      'xp': xp,
      'level': level,
      'currentXp': currentXp,
      'xpToNextLevel': xpToNextLevel,
      'currentStreak': currentStreak,
      'longestStreak': longestStreak,
      'lessonsCompleted': lessonsCompleted,
      'quizzesPassed': quizzesPassed,
      'totalXp': totalXp,
    };
  }
}
