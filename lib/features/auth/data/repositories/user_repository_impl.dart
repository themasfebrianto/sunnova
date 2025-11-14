import 'package:dartz/dartz.dart';
import 'package:sunnova_app/core/error/exceptions.dart';
import 'package:sunnova_app/core/error/failures.dart';
import 'package:sunnova_app/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:sunnova_app/features/auth/data/models/user_model.dart';
import 'package:sunnova_app/features/auth/domain/entities/user_entity.dart';
import 'package:sunnova_app/features/auth/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final AuthLocalDataSource localDataSource;

  UserRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, UserEntity>> getUser(String id) async {
    try {
      final userModel = await localDataSource.getUser(id);
      return Right(userModel);
    } on DatabaseException {
      return Left(DatabaseFailure('Failed to get user from local database.'));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> loginUser(
    String email,
    String password,
  ) async {
    try {
      final userModel = await localDataSource.loginUser(email, password);
      return Right(userModel);
    } on DatabaseException {
      return Left(DatabaseFailure('Invalid credentials or user not found.'));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> registerUser(
    String name,
    String email,
    String password,
    String gender,
  ) async {
    try {
      // For now, generate a dummy UID. In a real app, this would come from an auth service.
      final newUser = UserModel(
        uid: DateTime.now().toIso8601String(), // Dummy UID
        email: email,
        displayName: name,
        gender: gender,
        isPremium: false,
        createdAt: DateTime.now(),
        lastLoginAt: DateTime.now(),
      );
      await localDataSource.registerUser(newUser);
      return Right(newUser);
    } on DatabaseException {
      return Left(DatabaseFailure('Failed to register user.'));
    }
  }

  @override
  Future<Either<Failure, void>> logoutUser() async {
    try {
      await localDataSource.logoutUser();
      return const Right(null);
    } on DatabaseException {
      return Left(DatabaseFailure('Failed to logout user.'));
    }
  }
}
