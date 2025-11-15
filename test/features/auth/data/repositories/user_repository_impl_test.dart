import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sunnova_app/core/error/exceptions.dart';
import 'package:sunnova_app/core/error/failures.dart';
import 'package:sunnova_app/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:sunnova_app/features/auth/data/models/user_model.dart';
import 'package:sunnova_app/features/auth/data/repositories/user_repository_impl.dart';
import 'package:sunnova_app/features/auth/domain/entities/user_entity.dart';

import 'user_repository_impl_test.mocks.dart';

@GenerateMocks([AuthLocalDataSource])
void main() {
  late UserRepositoryImpl repository;
  late MockAuthLocalDataSource mockAuthLocalDataSource;

  setUp(() {
    mockAuthLocalDataSource = MockAuthLocalDataSource();
    repository = UserRepositoryImpl(
      localDataSource: mockAuthLocalDataSource,
    );
  });

  group('registerUser', () {
    const tName = 'Test User';
    const tEmail = 'test@example.com';
    const tPassword = 'password123';
    const tGender = 'male';
    final tUserModel = UserModel(
      uid: 'some_uid',
      email: tEmail,
      displayName: tName,
      gender: tGender,
      isPremium: false,
      createdAt: DateTime.now(),
      password: tPassword,
    );
    final UserEntity tUserEntity = tUserModel;

    test(
      'should return user entity when the call to local data source is successful',
      () async {
        // arrange
        when(mockAuthLocalDataSource.registerUser(
                tName, tEmail, tPassword, tGender))
            .thenAnswer((_) async => tUserModel);
        // act
        final result = await repository.registerUser(
            tName, tEmail, tPassword, tGender);
        // assert
        expect(result, Right(tUserEntity));
        verify(mockAuthLocalDataSource.registerUser(
            tName, tEmail, tPassword, tGender));
      },
    );

    test(
      'should return DatabaseFailure when the call to local data source is unsuccessful',
      () async {
        // arrange
        when(mockAuthLocalDataSource.registerUser(
                tName, tEmail, tPassword, tGender))
            .thenThrow(const DatabaseException('Test Exception'));
        // act
        final result = await repository.registerUser(
            tName, tEmail, tPassword, tGender);
        // assert
        expect(result, Left(DatabaseFailure('Test Exception')));
        verify(mockAuthLocalDataSource.registerUser(
            tName, tEmail, tPassword, tGender));
      },
    );
  });

  group('loginUser', () {
    const tEmail = 'test@example.com';
    const tPassword = 'password123';
    final tUserModel = UserModel(
      uid: 'some_uid',
      email: tEmail,
      displayName: 'Test User',
      gender: 'male',
      isPremium: false,
      createdAt: DateTime.now(),
      password: tPassword,
    );
    final UserEntity tUserEntity = tUserModel;

    test(
      'should return user entity when the call to local data source is successful',
      () async {
        // arrange
        when(mockAuthLocalDataSource.loginUser(tEmail, tPassword))
            .thenAnswer((_) async => tUserModel);
        // act
        final result = await repository.loginUser(tEmail, tPassword);
        // assert
        expect(result, Right(tUserEntity));
        verify(mockAuthLocalDataSource.loginUser(tEmail, tPassword));
      },
    );

    test(
      'should return DatabaseFailure when the call to local data source is unsuccessful',
      () async {
        // arrange
        when(mockAuthLocalDataSource.loginUser(tEmail, tPassword))
            .thenThrow(const DatabaseException('Test Exception'));
        // act
        final result = await repository.loginUser(tEmail, tPassword);
        // assert
        expect(result, Left(DatabaseFailure('Test Exception')));
        verify(mockAuthLocalDataSource.loginUser(tEmail, tPassword));
      },
    );
  });

  group('logoutUser', () {
    test(
      'should return void when the call to local data source is successful',
      () async {
        // arrange
        when(mockAuthLocalDataSource.logoutUser())
            .thenAnswer((_) async => Future.value());
        // act
        final result = await repository.logoutUser();
        // assert
        expect(result, const Right(null));
        verify(mockAuthLocalDataSource.logoutUser());
      },
    );

    test(
      'should return DatabaseFailure when the call to local data source is unsuccessful',
      () async {
        // arrange
        when(mockAuthLocalDataSource.logoutUser())
            .thenThrow(const DatabaseException('Test Exception'));
        // act
        final result = await repository.logoutUser();
        // assert
        expect(result, Left(DatabaseFailure('Test Exception')));
        verify(mockAuthLocalDataSource.logoutUser());
      },
    );
  });

  group('getUserProfile', () {
    const tUid = 'some_uid';
    final tUserModel = UserModel(
      uid: tUid,
      email: 'test@example.com',
      displayName: 'Test User',
      gender: 'male',
      isPremium: false,
      createdAt: DateTime.now(),
      password: 'password123',
    );
    final UserEntity tUserEntity = tUserModel;

    test(
      'should return user entity when the call to local data source is successful',
      () async {
        // arrange
        when(mockAuthLocalDataSource.getUserProfile(tUid))
            .thenAnswer((_) async => tUserModel);
        // act
        final result = await repository.getUserProfile(tUid);
        // assert
        expect(result, Right(tUserEntity));
        verify(mockAuthLocalDataSource.getUserProfile(tUid));
      },
    );

    test(
      'should return DatabaseFailure when the call to local data source is unsuccessful',
      () async {
        // arrange
        when(mockAuthLocalDataSource.getUserProfile(tUid))
            .thenThrow(const DatabaseException('Test Exception'));
        // act
        final result = await repository.getUserProfile(tUid);
        // assert
        expect(result, Left(DatabaseFailure('Test Exception')));
        verify(mockAuthLocalDataSource.getUserProfile(tUid));
      },
    );
  });
}
