import 'package:flutter/material.dart';
import 'package:sunnova_app/core/usecases/usecase.dart';
import 'package:sunnova_app/features/home/domain/entities/course_module_entity.dart';
import 'package:sunnova_app/features/home/domain/entities/user_game_stats_entity.dart';
import 'package:sunnova_app/features/home/domain/usecases/get_course_modules.dart';
import 'package:sunnova_app/features/home/domain/usecases/get_user_game_stats.dart';

class HomeState {
  final UserGameStatsEntity? userStats;
  final List<CourseModuleEntity> modules;
  final bool isLoading;
  final String? errorMessage;

  HomeState({
    this.userStats,
    this.modules = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  HomeState copyWith({
    UserGameStatsEntity? userStats,
    List<CourseModuleEntity>? modules,
    bool? isLoading,
    String? errorMessage,
  }) {
    return HomeState(
      userStats: userStats ?? this.userStats,
      modules: modules ?? this.modules,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  factory HomeState.initial() => HomeState();
  HomeState loading() => HomeState(isLoading: true);
  HomeState loaded({UserGameStatsEntity? userStats, List<CourseModuleEntity>? modules}) =>
      HomeState(userStats: userStats, modules: modules ?? const [], isLoading: false);
  HomeState error(String message) => HomeState(errorMessage: message, isLoading: false);
}

class HomeNotifier extends ChangeNotifier {
  final GetUserGameStats getUserGameStats;
  final GetCourseModules getCourseModules;

  HomeNotifier({
    required this.getUserGameStats,
    required this.getCourseModules,
  });

  HomeState _state = HomeState.initial();
  HomeState get state => _state;

  Future<void> fetchUserStats(String userId) async {
    _state = _state.loading();
    notifyListeners();

    final result = await getUserGameStats(GetUserGameStatsParams(userId: userId));

    result.fold(
      (failure) {
        _state = _state.error(failure.message ?? 'Failed to fetch user stats');
        notifyListeners();
      },
      (stats) {
        _state = _state.loaded(userStats: stats, modules: _state.modules);
        notifyListeners();
      },
    );
  }

  Future<void> fetchCourseModules() async {
    _state = _state.loading();
    notifyListeners();

    final result = await getCourseModules(NoParams());

    result.fold(
      (failure) {
        _state = _state.error(failure.message ?? 'Failed to fetch course modules');
        notifyListeners();
      },
      (modules) {
        _state = _state.loaded(modules: modules, userStats: _state.userStats);
        notifyListeners();
      },
    );
  }

  Future<void> checkDailyLogin() async {
    // This method would typically interact with a use case to update streak
    // and potentially award XP for daily login.
    // For now, it's a placeholder.
    // _state = _state.copyWith(isLoading: true);
    // notifyListeners();
    // await Future.delayed(const Duration(seconds: 1));
    // _state = _state.copyWith(isLoading: false);
    // notifyListeners();
  }
}