import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:sunnova_app/core/error/failures.dart';
import 'package:sunnova_app/core/usecases/usecase.dart';
import 'package:sunnova_app/features/profile/domain/entities/user_achievement_entity.dart';
import 'package:sunnova_app/features/profile/domain/repositories/profile_repository.dart';

class GetUserAchievements extends UseCase<List<UserAchievementEntity>, GetUserAchievementsParams> {
  final ProfileRepository repository;

  GetUserAchievements(this.repository);

  @override
  Future<Either<Failure, List<UserAchievementEntity>>> call(GetUserAchievementsParams params) async {
    return await repository.getUserAchievements(params.userId);
  }
}

class GetUserAchievementsParams extends Equatable {
  final String userId;

  const GetUserAchievementsParams({required this.userId});

  @override
  List<Object?> get props => [userId];
}
