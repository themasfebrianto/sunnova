import 'package:dartz/dartz.dart';
import 'package:sunnova_app/core/error/failures.dart';
import 'package:sunnova_app/features/auth/domain/entities/user_profile_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserProfileEntity>> loginUser(String email, String password);
  Future<Either<Failure, UserProfileEntity>> registerUser(String email, String password, String displayName, String gender);
  Future<Either<Failure, UserProfileEntity>> getCurrentUser();
  Future<Either<Failure, Unit>> logoutUser();
}
