import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sunnova_app/core/error/failures.dart';
import 'package:sunnova_app/core/usecases/usecase.dart';
import 'package:sunnova_app/features/auth/domain/entities/user_entity.dart';
import 'package:sunnova_app/features/auth/domain/repositories/user_repository.dart';
import 'package:sunnova_app/features/auth/domain/usecases/get_user_profile.dart';
import 'package:sunnova_app/features/auth/domain/usecases/login_user.dart';
import 'package:sunnova_app/features/auth/domain/usecases/logout_user.dart';
import 'package:sunnova_app/features/auth/domain/usecases/register_user.dart';

import 'auth_usecases_test.mocks.dart';

@GenerateMocks([UserRepository])
void main() {
  late RegisterUser registerUser;
  late LoginUser loginUser;
  late LogoutUser logoutUser;
  late GetUserProfile getUserProfile;
  late MockUserRepository mockUserRepository;

  setUp(() {
    mockUserRepository = MockUserRepository();
    registerUser = RegisterUser(mockUserRepository);
    loginUser = LoginUser(mockUserRepository);
    logoutUser = LogoutUser(mockUserRepository);
    getUserProfile = GetUserProfile(mockUserRepository);
  });

  final tUser = UserEntity(
    uid: '123',
    email: 'test@example.com',
    displayName: 'Test User',
    gender: 'male',
    isPremium: false,
    createdAt: DateTime.now(),
  );

  group('RegisterUser', () {
    const tName = 'Test User';
    const tEmail = 'test@example.com';
    const tPassword = 'password123';
    const tGender = 'male';

    test(
      'should register user from the repository',
      () async {
        // arrange
        when(mockUserRepository.registerUser(
                tName, tEmail, tPassword, tGender))
            .thenAnswer((_) async => Right(tUser));
        // act
        final result = await registerUser(RegisterUserParams(
            name: tName, email: tEmail, password: tPassword, gender: tGender));
        // assert
        expect(result, Right(tUser));
        verify(mockUserRepository.registerUser(
            tName, tEmail, tPassword, tGender));
        verifyNoMoreInteractions(mockUserRepository);
      },
    );

    test(
      'should return failure when registration is unsuccessful',
      () async {
        // arrange
        when(mockUserRepository.registerUser(
                tName, tEmail, tPassword, tGender))
            .thenAnswer((_) async => Left(DatabaseFailure('Error')));
        // act
        final result = await registerUser(RegisterUserParams(
            name: tName, email: tEmail, password: tPassword, gender: tGender));
        // assert
        expect(result, Left(DatabaseFailure('Error')));
        verify(mockUserRepository.registerUser(
            tName, tEmail, tPassword, tGender));
        verifyNoMoreInteractions(mockUserRepository);
      },
    );
  });

  group('LoginUser', () {
    const tEmail = 'test@example.com';
    const tPassword = 'password123';

    test(
      'should login user from the repository',
      () async {
        // arrange
        when(mockUserRepository.loginUser(tEmail, tPassword))
            .thenAnswer((_) async => Right(tUser));
        // act
        final result =
            await loginUser(LoginUserParams(email: tEmail, password: tPassword));
        // assert
        expect(result, Right(tUser));
        verify(mockUserRepository.loginUser(tEmail, tPassword));
        verifyNoMoreInteractions(mockUserRepository);
      },
    );

    test(
      'should return failure when login is unsuccessful',
      () async {
        // arrange
        when(mockUserRepository.loginUser(tEmail, tPassword))
            .thenAnswer((_) async => Left(DatabaseFailure('Error')));
        // act
        final result =
            await loginUser(LoginUserParams(email: tEmail, password: tPassword));
        // assert
        expect(result, Left(DatabaseFailure('Error')));
        verify(mockUserRepository.loginUser(tEmail, tPassword));
        verifyNoMoreInteractions(mockUserRepository);
      },
    );
  });

  group('LogoutUser', () {
    test(
      'should logout user from the repository',
      () async {
        // arrange
        when(mockUserRepository.logoutUser())
            .thenAnswer((_) async => const Right(null));
        // act
        final result = await logoutUser(NoParams());
        // assert
        expect(result, const Right(null));
        verify(mockUserRepository.logoutUser());
        verifyNoMoreInteractions(mockUserRepository);
      },
    );

    test(
      'should return failure when logout is unsuccessful',
      () async {
        // arrange
        when(mockUserRepository.logoutUser())
            .thenAnswer((_) async => Left(DatabaseFailure('Error')));
        // act
        final result = await logoutUser(NoParams());
        // assert
        expect(result, Left(DatabaseFailure('Error')));
        verify(mockUserRepository.logoutUser());
        verifyNoMoreInteractions(mockUserRepository);
      },
    );
  });

  group('GetUserProfile', () {
    const tUid = '123';

    test(
      'should get user profile from the repository',
      () async {
        // arrange
        when(mockUserRepository.getUserProfile(tUid))
            .thenAnswer((_) async => Right(tUser));
        // act
        final result = await getUserProfile(GetUserProfileParams(id: tUid));
        // assert
        expect(result, Right(tUser));
        verify(mockUserRepository.getUserProfile(tUid));
        verifyNoMoreInteractions(mockUserRepository);
      },
    );

    test(
      'should return failure when getting user profile is unsuccessful',
      () async {
        // arrange
        when(mockUserRepository.getUserProfile(tUid))
            .thenAnswer((_) async => Left(DatabaseFailure('Error')));
        // act
        final result = await getUserProfile(GetUserProfileParams(id: tUid));
        // assert
        expect(result, Left(DatabaseFailure('Error')));
        verify(mockUserRepository.getUserProfile(tUid));
        verifyNoMoreInteractions(mockUserRepository);
      },
    );
  });
}
