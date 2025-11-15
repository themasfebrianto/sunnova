import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sunnova_app/core/error/failures.dart';
import 'package:sunnova_app/core/usecases/usecase.dart';
import 'package:sunnova_app/features/auth/domain/entities/user_entity.dart';
import 'package:sunnova_app/features/auth/domain/usecases/get_user_profile.dart';
import 'package:sunnova_app/features/auth/domain/usecases/login_user.dart';
import 'package:sunnova_app/features/auth/domain/usecases/logout_user.dart';
import 'package:sunnova_app/features/auth/domain/usecases/register_user.dart';
import 'package:sunnova_app/features/auth/presentation/notifiers/auth_notifier.dart';

import 'auth_notifier_test.mocks.dart';

@GenerateMocks([RegisterUser, LoginUser, LogoutUser, GetUserProfile])
void main() {
  late AuthNotifier authNotifier;
  late MockRegisterUser mockRegisterUser;
  late MockLoginUser mockLoginUser;
  late MockLogoutUser mockLogoutUser;
  late MockGetUserProfile mockGetUserProfile;

  setUp(() {
    mockRegisterUser = MockRegisterUser();
    mockLoginUser = MockLoginUser();
    mockLogoutUser = MockLogoutUser();
    mockGetUserProfile = MockGetUserProfile();
    authNotifier = AuthNotifier(
      registerUser: mockRegisterUser,
      loginUser: mockLoginUser,
      logoutUser: mockLogoutUser,
      getUserProfile: mockGetUserProfile,
    );
  });

  final tUser = UserEntity(
    uid: '123',
    email: 'test@example.com',
    displayName: 'Test User',
    gender: 'male',
    isPremium: false,
    createdAt: DateTime.now(),
  );

  group('register', () {
    const tName = 'Test User';
    const tEmail = 'test@example.com';
    const tPassword = 'password123';
    const tGender = 'male';

    test(
      'should set state to loading and then authenticated with user on successful registration',
      () async {
        // arrange
        when(mockRegisterUser(any)).thenAnswer((_) async => Right(tUser));
        // act
        await authNotifier.register(tName, tEmail, tPassword, tGender);
        // assert
        expect(authNotifier.state.status, AuthStatus.authenticated);
        expect(authNotifier.state.user, tUser);
        expect(authNotifier.state.errorMessage, null);
        verify(mockRegisterUser(RegisterUserParams(
            name: tName, email: tEmail, password: tPassword, gender: tGender)));
        verifyNoMoreInteractions(mockRegisterUser);
      },
    );

    test(
      'should set state to loading and then error on failed registration',
      () async {
        // arrange
        when(mockRegisterUser(any))
            .thenAnswer((_) async => Left(DatabaseFailure('Error')));
        // act
        await authNotifier.register(tName, tEmail, tPassword, tGender);
        // assert
        expect(authNotifier.state.status, AuthStatus.error);
        expect(authNotifier.state.user, null);
        expect(authNotifier.state.errorMessage, 'Database Error');
        verify(mockRegisterUser(RegisterUserParams(
            name: tName, email: tEmail, password: tPassword, gender: tGender)));
        verifyNoMoreInteractions(mockRegisterUser);
      },
    );
  });

  group('login', () {
    const tEmail = 'test@example.com';
    const tPassword = 'password123';

    test(
      'should set state to loading and then authenticated with user on successful login',
      () async {
        // arrange
        when(mockLoginUser(any)).thenAnswer((_) async => Right(tUser));
        // act
        await authNotifier.login(tEmail, tPassword);
        // assert
        expect(authNotifier.state.status, AuthStatus.authenticated);
        expect(authNotifier.state.user, tUser);
        expect(authNotifier.state.errorMessage, null);
        verify(mockLoginUser(LoginUserParams(email: tEmail, password: tPassword)));
        verifyNoMoreInteractions(mockLoginUser);
      },
    );

    test(
      'should set state to loading and then error on failed login',
      () async {
        // arrange
        when(mockLoginUser(any))
            .thenAnswer((_) async => Left(DatabaseFailure('Error')));
        // act
        await authNotifier.login(tEmail, tPassword);
        // assert
        expect(authNotifier.state.status, AuthStatus.error);
        expect(authNotifier.state.user, null);
        expect(authNotifier.state.errorMessage, 'Database Error');
        verify(mockLoginUser(LoginUserParams(email: tEmail, password: tPassword)));
        verifyNoMoreInteractions(mockLoginUser);
      },
    );
  });

  group('logout', () {
    test(
      'should set state to loading and then unauthenticated on successful logout',
      () async {
        // arrange
        when(mockLogoutUser(any)).thenAnswer((_) async => const Right(null));
        // act
        await authNotifier.logout();
        // assert
        expect(authNotifier.state.status, AuthStatus.unauthenticated);
        expect(authNotifier.state.user, null);
        expect(authNotifier.state.errorMessage, null);
        verify(mockLogoutUser(NoParams()));
        verifyNoMoreInteractions(mockLogoutUser);
      },
    );

    test(
      'should set state to loading and then error on failed logout',
      () async {
        // arrange
        when(mockLogoutUser(any))
            .thenAnswer((_) async => Left(DatabaseFailure('Error')));
        // act
        await authNotifier.logout();
        // assert
        expect(authNotifier.state.status, AuthStatus.error);
        expect(authNotifier.state.user, null);
        expect(authNotifier.state.errorMessage, 'Database Error');
        verify(mockLogoutUser(NoParams()));
        verifyNoMoreInteractions(mockLogoutUser);
      },
    );
  });

  group('checkUserProfile', () {
    const tUid = '123';

    test(
      'should set state to loading and then authenticated with user on successful check',
      () async {
        // arrange
        when(mockGetUserProfile(any)).thenAnswer((_) async => Right(tUser));
        // act
        await authNotifier.checkUserProfile(tUid);
        // assert
        expect(authNotifier.state.status, AuthStatus.authenticated);
        expect(authNotifier.state.user, tUser);
        expect(authNotifier.state.errorMessage, null);
        verify(mockGetUserProfile(GetUserProfileParams(id: tUid)));
        verifyNoMoreInteractions(mockGetUserProfile);
      },
    );

    test(
      'should set state to loading and then unauthenticated on failed check',
      () async {
        // arrange
        when(mockGetUserProfile(any))
            .thenAnswer((_) async => Left(DatabaseFailure('Error')));
        // act
        await authNotifier.checkUserProfile(tUid);
        // assert
        expect(authNotifier.state.status, AuthStatus.unauthenticated);
        expect(authNotifier.state.user, null);
        expect(authNotifier.state.errorMessage, 'Database Error');
        verify(mockGetUserProfile(GetUserProfileParams(id: tUid)));
        verifyNoMoreInteractions(mockGetUserProfile);
      },
    );
  });
}
