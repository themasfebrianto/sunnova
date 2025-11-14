import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:sunnova_app/core/error/failures.dart';
import 'package:sunnova_app/core/usecases/usecase.dart';
import 'package:sunnova_app/features/auth/domain/entities/user_entity.dart';
import 'package:sunnova_app/features/auth/domain/usecases/get_user_profile.dart';
import 'package:sunnova_app/features/auth/domain/usecases/login_user.dart';
import 'package:sunnova_app/features/auth/domain/usecases/logout_user.dart';
import 'package:sunnova_app/features/auth/domain/usecases/register_user.dart';

enum AuthStatus { initial, loading, authenticated, unauthenticated, error }

class _AuthState extends Equatable {
  final AuthStatus status;
  final UserEntity? user;
  final String? errorMessage;

  const _AuthState({
    this.status = AuthStatus.initial,
    this.user,
    this.errorMessage,
  });

  _AuthState copyWith({
    AuthStatus? status,
    UserEntity? user,
    String? errorMessage,
  }) {
    return _AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, user, errorMessage];
}

class AuthNotifier extends ChangeNotifier {
  final LoginUser loginUser;
  final RegisterUser registerUser;
  final LogoutUser logoutUser;
  final GetUserProfile getUserProfile;

  AuthNotifier({
    required this.loginUser,
    required this.registerUser,
    required this.logoutUser,
    required this.getUserProfile,
  });

  _AuthState _state = const _AuthState();
  _AuthState get state => _state;

  Future<void> login(String email, String password) async {
    _state = _state.copyWith(status: AuthStatus.loading);
    notifyListeners();

    final result = await loginUser(
      LoginUserParams(email: email, password: password),
    );

    result.fold(
      (failure) {
        _state = _state.copyWith(
          status: AuthStatus.error,
          errorMessage: _mapFailureToMessage(failure),
        );
        notifyListeners();
      },
      (user) {
        _state = _state.copyWith(status: AuthStatus.authenticated, user: user);
        notifyListeners();
      },
    );
  }

  Future<void> register(
    String name,
    String email,
    String password,
    String gender,
  ) async {
    _state = _state.copyWith(status: AuthStatus.loading);
    notifyListeners();

    final result = await registerUser(
      RegisterUserParams(
        name: name,
        email: email,
        password: password,
        gender: gender,
      ),
    );

    result.fold(
      (failure) {
        _state = _state.copyWith(
          status: AuthStatus.error,
          errorMessage: _mapFailureToMessage(failure),
        );
        notifyListeners();
      },
      (user) {
        _state = _state.copyWith(status: AuthStatus.authenticated, user: user);
        notifyListeners();
      },
    );
  }

  Future<void> logout() async {
    _state = _state.copyWith(status: AuthStatus.loading);
    notifyListeners();

    final result = await logoutUser(NoParams());

    result.fold(
      (failure) {
        _state = _state.copyWith(
          status: AuthStatus.error,
          errorMessage: _mapFailureToMessage(failure),
        );
        notifyListeners();
      },
      (_) {
        _state = _state.copyWith(
          status: AuthStatus.unauthenticated,
          user: null,
        );
        notifyListeners();
      },
    );
  }

  Future<void> checkUserProfile(String uid) async {
    _state = _state.copyWith(status: AuthStatus.loading);
    notifyListeners();

    final result = await getUserProfile(GetUserProfileParams(id: uid));

    result.fold(
      (failure) {
        _state = _state.copyWith(
          status: AuthStatus.unauthenticated,
          errorMessage: _mapFailureToMessage(failure),
        );
        notifyListeners();
      },
      (user) {
        _state = _state.copyWith(status: AuthStatus.authenticated, user: user);
        notifyListeners();
      },
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Server Error';
      case CacheFailure:
        return 'Cache Error';
      case DatabaseFailure:
        return 'Database Error';
      case NetworkFailure:
        return 'Network Error';
      default:
        return 'Unexpected Error';
    }
  }
}
