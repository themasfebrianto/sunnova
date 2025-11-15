import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:sunnova_app/core/error/failures.dart';
import 'package:sunnova_app/core/usecases/usecase.dart';
import 'package:sunnova_app/features/leaderboard/domain/entities/leaderboard_rank_entity.dart';
import 'package:sunnova_app/features/leaderboard/domain/repositories/leaderboard_repository.dart';

class GetLeaderboard extends UseCase<List<LeaderboardRankEntity>, GetLeaderboardParams> {
  final LeaderboardRepository repository;

  GetLeaderboard(this.repository);

  @override
  Future<Either<Failure, List<LeaderboardRankEntity>>> call(GetLeaderboardParams params) async {
    return await repository.getLeaderboard(params.rankType);
  }
}

class GetLeaderboardParams extends Equatable {
  final String rankType; // 'WEEKLY' or 'MONTHLY'

  const GetLeaderboardParams({required this.rankType});

  @override
  List<Object?> get props => [rankType];
}
