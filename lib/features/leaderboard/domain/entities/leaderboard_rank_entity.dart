import 'package:equatable/equatable.dart';

class LeaderboardRankEntity extends Equatable {
  final String userId;
  final String userName;
  final String? photoUrl;
  final int xp;
  final int rank;

  const LeaderboardRankEntity({
    required this.userId,
    required this.userName,
    this.photoUrl,
    required this.xp,
    required this.rank,
  });

  @override
  List<Object?> get props => [userId, userName, photoUrl, xp, rank];
}
