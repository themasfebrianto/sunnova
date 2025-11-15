import 'package:sunnova_app/core/error/exceptions.dart';
import 'package:sunnova_app/features/leaderboard/data/models/leaderboard_rank_model.dart';
import 'package:sunnova_app/core/db/database_helper.dart'; // Import DatabaseHelper

abstract class LeaderboardLocalDataSource {
  Future<List<LeaderboardRankModel>> getLeaderboard(String rankType);
}

class LeaderboardLocalDataSourceImpl implements LeaderboardLocalDataSource {
  final DatabaseHelper databaseHelper;

  LeaderboardLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<List<LeaderboardRankModel>> getLeaderboard(String rankType) async {
    try {
      final rankMaps = await databaseHelper.getLeaderboardRanks();
      final List<LeaderboardRankModel> ranks = [];
      for (int i = 0; i < rankMaps.length; i++) {
        final map = rankMaps[i];
        ranks.add(LeaderboardRankModel(
          userId: map['uid'] as String,
          userName: map['displayName'] as String,
          userPhotoUrl: map['photoURL'] as String?,
          scoreValue: map['xp'] as int,
          rank: i + 1, // Rank is 1-based index
          rankType: rankType,
        ));
      }
      return ranks;
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }
}
