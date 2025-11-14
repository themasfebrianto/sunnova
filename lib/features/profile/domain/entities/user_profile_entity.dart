import 'package:equatable/equatable.dart';
import 'package:sunnova_app/features/home/domain/entities/user_game_stats_entity.dart'; // Import UserGameStatsEntity

class UserProfileEntity extends Equatable {
  final String uid;
  final String email;
  final String displayName;
  final String? photoURL;
  final String gender;
  final UserGameStatsEntity? gameStats; // Include game stats

  const UserProfileEntity({
    required this.uid,
    required this.email,
    required this.displayName,
    this.photoURL,
    required this.gender,
    this.gameStats,
  });

  @override
  List<Object?> get props => [
    uid,
    email,
    displayName,
    photoURL,
    gender,
    gameStats,
  ];
}
