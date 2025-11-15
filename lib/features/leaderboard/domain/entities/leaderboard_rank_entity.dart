import 'package:equatable/equatable.dart';

class LeaderboardRankEntity extends Equatable {
  final String userId;
  final String userName;
  final String? userPhotoUrl;
  final int scoreValue;
  final int rank;
  final String rankType; // WEEKLY / MONTHLY

  const LeaderboardRankEntity({
    required this.userId,
    required this.userName,
    required this.userPhotoUrl,
    required this.scoreValue,
    required this.rank,
    required this.rankType,
  });

  @override
  List<Object?> get props => [userId, userName, userPhotoUrl, scoreValue, rank, rankType];
}