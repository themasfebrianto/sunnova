import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:sunnova_app/core/error/failures.dart';
import 'package:sunnova_app/core/usecases/usecase.dart';
import 'package:sunnova_app/features/home/domain/entities/user_game_stats_entity.dart';
import 'package:sunnova_app/features/home/domain/repositories/home_repository.dart';

class GetUserGameStats extends UseCase<UserGameStatsEntity, GetUserGameStatsParams> {
  final HomeRepository repository;

  GetUserGameStats(this.repository);

  @override
  Future<Either<Failure, UserGameStatsEntity>> call(GetUserGameStatsParams params) async {
    return await repository.getUserGameStats(params.userId);
  }
}

class GetUserGameStatsParams extends Equatable {
  final String userId;

  const GetUserGameStatsParams({required this.userId});

  @override
  List<Object?> get props => [userId];
}
