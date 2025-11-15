import 'package:dartz/dartz.dart';
import 'package:sunnova_app/core/error/exceptions.dart';
import 'package:sunnova_app/core/error/failures.dart';
import 'package:sunnova_app/features/auth/domain/entities/user_entity.dart'; // For UserEntity
import 'package:sunnova_app/features/profile/data/datasources/profile_local_data_source.dart';
import 'package:sunnova_app/features/profile/domain/entities/user_achievement_entity.dart';
import 'package:sunnova_app/features/profile/domain/entities/badge_entity.dart';
import 'package:sunnova_app/features/profile/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileLocalDataSource localDataSource;

  ProfileRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, UserEntity>> getUserProfile(String userId) async {
    try {
      final userModel = await localDataSource.getUserProfile(userId);
      return Right(userModel);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<UserAchievementEntity>>> getUserAchievements(String userId) async {
    try {
      final userAchievementModels = await localDataSource.getUserAchievements(userId);
      return Right(userAchievementModels);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<BadgeEntity>>> getBadges() async {
    try {
      final badgeModels = await localDataSource.getBadges();
      return Right(badgeModels);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }
}
