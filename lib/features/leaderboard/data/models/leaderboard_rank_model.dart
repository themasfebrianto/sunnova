import 'package:sunnova_app/features/leaderboard/domain/entities/leaderboard_rank_entity.dart';

class LeaderboardRankModel extends LeaderboardRankEntity {
  const LeaderboardRankModel({
    required super.userId,
    required super.userName,
    super.userPhotoUrl, // Make it nullable
    required super.scoreValue,
    required super.rank,
    required super.rankType,
  });

  factory LeaderboardRankModel.fromJson(Map<String, dynamic> json) {
    return LeaderboardRankModel(
      userId: json['userId'] as String,
      userName: json['userName'] as String,
      userPhotoUrl: json['userPhotoUrl'] as String?, // Make it nullable
      scoreValue: json['scoreValue'] as int,
      rank: json['rank'] as int,
      rankType: json['rankType'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'userName': userName,
      'userPhotoUrl': userPhotoUrl,
      'scoreValue': scoreValue,
      'rank': rank,
      'rankType': rankType,
    };
  }

  factory LeaderboardRankModel.fromMap(Map<String, dynamic> map) {
    return LeaderboardRankModel(
      userId: map['userId'] as String,
      userName: map['userName'] as String,
      userPhotoUrl: map['userPhotoUrl'] as String?, // Make it nullable
      scoreValue: map['scoreValue'] as int,
      rank: map['rank'] as int,
      rankType: map['rankType'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'userName': userName,
      'userPhotoUrl': userPhotoUrl,
      'scoreValue': scoreValue,
      'rank': rank,
      'rankType': rankType,
    };
  }
}
