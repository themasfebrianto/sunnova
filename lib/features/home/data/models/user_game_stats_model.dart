import 'package:sunnova_app/features/home/domain/entities/user_game_stats_entity.dart';

class UserGameStatsModel extends UserGameStatsEntity {
  const UserGameStatsModel({
    required super.xp,
    required super.level,
    required super.currentStreak,
    required super.longestStreak,
    required super.lessonsCompleted,
    required super.quizzesPassed,
  });

  factory UserGameStatsModel.fromJson(Map<String, dynamic> json) {
    return UserGameStatsModel(
      xp: json['xp'] as int,
      level: json['level'] as int,
      currentStreak: json['currentStreak'] as int,
      longestStreak: json['longestStreak'] as int,
      lessonsCompleted: json['lessonsCompleted'] as int,
      quizzesPassed: json['quizzesPassed'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'xp': xp,
      'level': level,
      'currentStreak': currentStreak,
      'longestStreak': longestStreak,
      'lessonsCompleted': lessonsCompleted,
      'quizzesPassed': quizzesPassed,
    };
  }

  factory UserGameStatsModel.fromMap(Map<String, dynamic> map) {
    return UserGameStatsModel(
      xp: map['xp'] as int,
      level: map['level'] as int,
      currentStreak: map['currentStreak'] as int,
      longestStreak: map['longestStreak'] as int,
      lessonsCompleted: map['lessonsCompleted'] as int,
      quizzesPassed: map['quizzesPassed'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'xp': xp,
      'level': level,
      'currentStreak': currentStreak,
      'longestStreak': longestStreak,
      'lessonsCompleted': lessonsCompleted,
      'quizzesPassed': quizzesPassed,
    };
  }
}
