import 'package:dartz/dartz.dart';
import 'package:sunnova_app/core/error/exceptions.dart';
import 'package:sunnova_app/core/error/failures.dart';
import 'package:sunnova_app/features/leaderboard/data/datasources/leaderboard_local_data_source.dart';
import 'package:sunnova_app/features/leaderboard/domain/entities/leaderboard_rank_entity.dart';
import 'package:sunnova_app/features/leaderboard/domain/repositories/leaderboard_repository.dart';

class LeaderboardRepositoryImpl implements LeaderboardRepository {
  final LeaderboardLocalDataSource localDataSource;

  LeaderboardRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<LeaderboardRankEntity>>> getLeaderboard(String rankType) async {
    try {
      final leaderboardRanks = await localDataSource.getLeaderboard(rankType);
      return Right(leaderboardRanks);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }
}
