import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sunnova_app/core/db/database_helper.dart';
import 'package:sunnova_app/core/error/exceptions.dart' as app_exceptions; // Alias our custom exception
import 'package:sunnova_app/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:sunnova_app/features/auth/data/models/user_model.dart';

import 'auth_local_data_source_test.mocks.dart';

@GenerateMocks([DatabaseHelper, SharedPreferences])
void main() {
  late AuthLocalDataSourceImpl dataSource;
  late MockDatabaseHelper mockDatabaseHelper;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    sqfliteFfiInit();
    mockDatabaseHelper = MockDatabaseHelper();
    mockSharedPreferences = MockSharedPreferences();
    dataSource = AuthLocalDataSourceImpl(
      databaseHelper: mockDatabaseHelper,
      sharedPreferences: mockSharedPreferences,
    );
  });

  group('registerUser', () {
    const tName = 'Test User';
    const tEmail = 'test@example.com';
    const tPassword = 'password123';
    const tGender = 'male';

    test(
      'should return UserModel when registration is successful',
      () async {
        // arrange
        when(mockDatabaseHelper.insertUser(any)).thenAnswer((_) async => 1);
        // act
        final result = await dataSource.registerUser(
            tName, tEmail, tPassword, tGender);
        // assert
        expect(result, isA<UserModel>());
        verify(mockDatabaseHelper.insertUser(any));
      },
    );

    test(
      'should throw app_exceptions.DatabaseException when registration fails',
      () async {
        // arrange
        when(mockDatabaseHelper.insertUser(any)).thenThrow(Exception());
        // act
        final call = dataSource.registerUser;
        // assert
        expect(
          () => call(tName, tEmail, tPassword, tGender),
          throwsA(isA<app_exceptions.DatabaseException>()),
        );
        verify(mockDatabaseHelper.insertUser(any));
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

    test(
      'should return UserModel when login is successful',
      () async {
        // arrange
        when(mockDatabaseHelper.getUserByEmail(tEmail))
            .thenAnswer((_) async => tUserModel.toMap());
        // act
        final result = await dataSource.loginUser(tEmail, tPassword);
        // assert
        expect(result, tUserModel);
        verify(mockDatabaseHelper.getUserByEmail(tEmail));
      },
    );

    test(
      'should throw app_exceptions.DatabaseException when login fails due to invalid credentials',
      () async {
        // arrange
        when(mockDatabaseHelper.getUserByEmail(tEmail))
            .thenAnswer((_) async => tUserModel.toMap());
        // act
        final call = dataSource.loginUser;
        // assert
        expect(
          () => call(tEmail, 'wrong_password'),
          throwsA(isA<app_exceptions.DatabaseException>()),
        );
        verify(mockDatabaseHelper.getUserByEmail(tEmail));
      },
    );

    test(
      'should throw app_exceptions.DatabaseException when user not found',
      () async {
        // arrange
        when(mockDatabaseHelper.getUserByEmail(tEmail))
            .thenAnswer((_) async => null);
        // act
        final call = dataSource.loginUser;
        // assert
        expect(
          () => call(tEmail, tPassword),
          throwsA(isA<app_exceptions.DatabaseException>()),
        );
        verify(mockDatabaseHelper.getUserByEmail(tEmail));
      },
    );

    test(
      'should throw app_exceptions.DatabaseException when database operation fails',
      () async {
        // arrange
        when(mockDatabaseHelper.getUserByEmail(tEmail)).thenThrow(Exception());
        // act
        final call = dataSource.loginUser;
        // assert
        expect(
          () => call(tEmail, tPassword),
          throwsA(isA<app_exceptions.DatabaseException>()),
        );
        verify(mockDatabaseHelper.getUserByEmail(tEmail));
      },
    );
  });

  group('logoutUser', () {
    test(
      'should complete successfully when logout is successful',
      () async {
        // act
        await dataSource.logoutUser();
        // assert
        // No explicit return value to check, just ensure no error is thrown
        expect(true, true); // Placeholder assertion
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

    test(
      'should return UserModel when user profile is found',
      () async {
        // arrange
        when(mockDatabaseHelper.getUser(tUid))
            .thenAnswer((_) async => tUserModel.toMap());
        // act
        final result = await dataSource.getUserProfile(tUid);
        // assert
        expect(result, tUserModel);
        verify(mockDatabaseHelper.getUser(tUid));
      },
    );

    test(
      'should throw app_exceptions.DatabaseException when user profile not found',
      () async {
        // arrange
        when(mockDatabaseHelper.getUser(tUid))
            .thenAnswer((_) async => null);
        // act
        final call = dataSource.getUserProfile;
        // assert
        expect(
          () => call(tUid),
          throwsA(isA<app_exceptions.DatabaseException>()),
        );
        verify(mockDatabaseHelper.getUser(tUid));
      },
    );

    test(
      'should throw app_exceptions.DatabaseException when database operation fails',
      () async {
        // arrange
        when(mockDatabaseHelper.getUser(tUid)).thenThrow(Exception());
        // act
        final call = dataSource.getUserProfile;
        // assert
        expect(
          () => call(tUid),
          throwsA(isA<app_exceptions.DatabaseException>()),
        );
        verify(mockDatabaseHelper.getUser(tUid));
      },
    );
  });
}
