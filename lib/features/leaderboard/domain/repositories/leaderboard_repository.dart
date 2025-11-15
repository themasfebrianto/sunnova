import 'package:dartz/dartz.dart';
import 'package:sunnova_app/core/error/failures.dart';
import 'package:sunnova_app/features/leaderboard/domain/entities/leaderboard_rank_entity.dart';

abstract class LeaderboardRepository {
  Future<Either<Failure, List<LeaderboardRankEntity>>> getLeaderboard(String rankType);
}
