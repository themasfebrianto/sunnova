import 'package:dartz/dartz.dart';
import 'package:sunnova_app/core/error/failures.dart';
import 'package:sunnova_app/features/auth/domain/entities/user_entity.dart'; // For UserProfileEntity
import 'package:sunnova_app/features/profile/domain/entities/user_achievement_entity.dart';
import 'package:sunnova_app/features/profile/domain/entities/badge_entity.dart';

abstract class ProfileRepository {
  Future<Either<Failure, UserEntity>> getUserProfile(String userId);
  Future<Either<Failure, List<UserAchievementEntity>>> getUserAchievements(String userId);
  Future<Either<Failure, List<BadgeEntity>>> getBadges();
}
