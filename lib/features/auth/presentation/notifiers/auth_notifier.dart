import 'package:flutter/material.dart';
import 'package:sunnova_app/core/error/failures.dart';
import 'package:sunnova_app/core/usecases/usecase.dart';
import 'package:sunnova_app/features/auth/domain/entities/user_profile_entity.dart';
import 'package:sunnova_app/features/auth/domain/usecases/login_user.dart';
import 'package:sunnova_app/features/auth/domain/usecases/register_user.dart';
import 'package:sunnova_app/features/auth/domain/usecases/get_current_user.dart';
import 'package:sunnova_app/features/auth/domain/usecases/logout_user.dart';

enum AuthStatus {
  uninitialized,
  authenticated,
  unauthenticated,
  authenticating,
  registering,
}

class AuthState {
  final AuthStatus status;
  final UserProfileEntity? user;
  final String? errorMessage;

  AuthState({
    required this.status,
    this.user,
    this.errorMessage,
  });

  factory AuthState.uninitialized() => AuthState(status: AuthStatus.uninitialized);
  factory AuthState.authenticated(UserProfileEntity user) => AuthState(status: AuthStatus.authenticated, user: user);
  factory AuthState.unauthenticated() => AuthState(status: AuthStatus.unauthenticated);
  factory AuthState.authenticating() => AuthState(status: AuthStatus.authenticating);
  factory AuthState.registering() => AuthState(status: AuthStatus.registering);
  factory AuthState.error(String message) => AuthState(status: AuthStatus.unauthenticated, errorMessage: message);

  AuthState copyWith({
    AuthStatus? status,
    UserProfileEntity? user,
    String? errorMessage,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class AuthNotifier extends ChangeNotifier {
  AuthState _state = AuthState.uninitialized();
  AuthState get state => _state;

  final LoginUser _loginUser;
  final RegisterUser _registerUser;
  final GetCurrentUser _getCurrentUser;
  final LogoutUser _logoutUser;

  AuthNotifier({
    required LoginUser loginUser,
    required RegisterUser registerUser,
    required GetCurrentUser getCurrentUser,
    required LogoutUser logoutUser,
  })  : _loginUser = loginUser,
        _registerUser = registerUser,
        _getCurrentUser = getCurrentUser,
        _logoutUser = logoutUser {
    _checkInitialLogin();
  }

  Future<void> _checkInitialLogin() async {
    _state = AuthState.uninitialized();
    notifyListeners();

    final result = await _getCurrentUser(NoParams());
    result.fold(
      (failure) {
        _state = AuthState.unauthenticated();
        notifyListeners();
      },
      (user) {
        _state = AuthState.authenticated(user);
        notifyListeners();
      },
    );
  }

  Future<void> login(String email, String password) async {
    _state = AuthState.authenticating();
    notifyListeners();

    final result = await _loginUser(LoginParams(email: email, password: password));
    result.fold(
      (failure) {
        _state = AuthState.error(_mapFailureToMessage(failure));
        notifyListeners();
      },
      (user) {
        _state = AuthState.authenticated(user);
        notifyListeners();
      },
    );
  }

  Future<void> register(String email, String password, String displayName, String gender) async {
    _state = AuthState.registering();
    notifyListeners();

    final result = await _registerUser(RegisterParams(
      email: email,
      password: password,
      displayName: displayName,
      gender: gender,
    ));
    result.fold(
      (failure) {
        _state = AuthState.error(_mapFailureToMessage(failure));
        notifyListeners();
      },
      (user) {
        _state = AuthState.authenticated(user);
        notifyListeners();
      },
    );
  }

  Future<void> logout() async {
    final result = await _logoutUser(NoParams());
    result.fold(
      (failure) {
        // Handle logout failure if necessary, though usually not critical
        _state = AuthState.error(_mapFailureToMessage(failure));
        notifyListeners();
      },
      (_) {
        _state = AuthState.unauthenticated();
        notifyListeners();
      },
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return failure.message ?? 'Server Failure';
      case CacheFailure:
        return failure.message ?? 'Cache Failure';
      case AuthenticationFailure:
        return failure.message ?? 'Authentication Failure';
      default:
        return 'Unexpected Error';
    }
  }
}
