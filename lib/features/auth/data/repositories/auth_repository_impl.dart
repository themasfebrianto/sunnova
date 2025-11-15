import 'package:dartz/dartz.dart';
import 'package:sunnova_app/core/error/exceptions.dart';
import 'package:sunnova_app/core/error/failures.dart';
import 'package:sunnova_app/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:sunnova_app/features/auth/data/models/user_model.dart';
import 'package:sunnova_app/features/auth/domain/entities/user_profile_entity.dart';
import 'package:sunnova_app/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, UserProfileEntity>> loginUser(String email, String password) async {
    try {
      final user = await localDataSource.loginUser(email, password);
      return Right(user);
    } on AuthenticationException catch (e) {
      return Left(AuthenticationFailure(e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, UserProfileEntity>> registerUser(String email, String password, String displayName, String gender) async {
    try {
      final user = await localDataSource.registerUser(email, password, displayName, gender);
      return Right(user);
    } on AuthenticationException catch (e) {
      return Left(AuthenticationFailure(e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, UserProfileEntity>> getCurrentUser() async {
    try {
      final user = await localDataSource.getCurrentUser();
      return Right(user);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Unit>> logoutUser() async {
    try {
      await localDataSource.logoutUser();
      return const Right(unit);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }
}
