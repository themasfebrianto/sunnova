import 'package:equatable/equatable.dart';

class UserGameStatsEntity extends Equatable {
  final int xp;
  final int level;
  final int currentStreak;
  final int longestStreak;
  final int lessonsCompleted;
  final int quizzesPassed;

  const UserGameStatsEntity({
    required this.xp,
    required this.level,
    required this.currentStreak,
    required this.longestStreak,
    required this.lessonsCompleted,
    required this.quizzesPassed,
  });

  @override
  List<Object?> get props => [
        xp,
        level,
        currentStreak,
        longestStreak,
        lessonsCompleted,
        quizzesPassed,
      ];
}
