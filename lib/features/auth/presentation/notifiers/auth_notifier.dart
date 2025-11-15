import 'package:flutter/material.dart';
import 'package:sunnova_app/features/auth/domain/entities/user_entity.dart';
import 'package:sunnova_app/features/auth/domain/usecases/login_user.dart';
import 'package:sunnova_app/features/auth/domain/usecases/register_user.dart';

enum AuthStatus { initial, loading, authenticated, unauthenticated, error }

class AuthState {
  final AuthStatus status;
  final UserEntity? user;
  final String? errorMessage;

  AuthState({
    this.status = AuthStatus.initial,
    this.user,
    this.errorMessage,
  });

  AuthState copyWith({
    AuthStatus? status,
    UserEntity? user,
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
  final RegisterUser registerUserUseCase;
  final LoginUser loginUserUseCase;

  AuthNotifier({
    required this.registerUserUseCase,
    required this.loginUserUseCase,
  });

  AuthState _state = AuthState();
  AuthState get state => _state;

  Future<void> register(
      String name, String email, String password, String gender) async {
    _state = _state.copyWith(status: AuthStatus.loading);
    notifyListeners();

    final result = await registerUserUseCase(
        RegisterUserParams(name: name, email: email, password: password, gender: gender));

    result.fold(
      (failure) {
        _state = _state.copyWith(
            status: AuthStatus.error, errorMessage: failure.message);
        notifyListeners();
      },
      (user) {
        _state = _state.copyWith(status: AuthStatus.authenticated, user: user);
        notifyListeners();
      },
    );
  }

  Future<void> login(String email, String password) async {
    _state = _state.copyWith(status: AuthStatus.loading);
    notifyListeners();

    final result = await loginUserUseCase(
        LoginUserParams(email: email, password: password));

    result.fold(
      (failure) {
        _state = _state.copyWith(
            status: AuthStatus.error, errorMessage: failure.message);
        notifyListeners();
      },
      (user) {
        _state = _state.copyWith(status: AuthStatus.authenticated, user: user);
        notifyListeners();
      },
    );
  }

  void setUserAuthenticated(UserEntity user) {
    _state = _state.copyWith(status: AuthStatus.authenticated, user: user);
    notifyListeners();
  }

  void logout() {
    _state = AuthState(status: AuthStatus.unauthenticated);
    notifyListeners();
  }
}