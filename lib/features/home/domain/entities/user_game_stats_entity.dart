import 'package:equatable/equatable.dart';

class UserGameStatsEntity extends Equatable {
  final String userName;
  final int xp;
  final int level;
  final int currentXp;
  final int xpToNextLevel;
  final int currentStreak;
  final int longestStreak;
  final int lessonsCompleted;
  final int quizzesPassed;
  final int totalXp;

  const UserGameStatsEntity({
    required this.userName,
    required this.xp,
    required this.level,
    required this.currentXp,
    required this.xpToNextLevel,
    required this.currentStreak,
    required this.longestStreak,
    required this.lessonsCompleted,
    required this.quizzesPassed,
    required this.totalXp,
  });

  @override
  List<Object?> get props => [
    userName,
    xp,
    level,
    currentXp,
    xpToNextLevel,
    currentStreak,
    longestStreak,
    lessonsCompleted,
    quizzesPassed,
    totalXp,
  ];
}
