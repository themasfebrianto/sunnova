import 'package:flutter/material.dart';
import 'package:sunnova_app/features/home/domain/entities/course_module_entity.dart';
import 'package:sunnova_app/features/home/domain/entities/user_game_stats_entity.dart';
import 'package:sunnova_app/features/home/domain/usecases/get_user_game_stats.dart';
import 'package:sunnova_app/features/home/domain/usecases/get_course_modules.dart';
import 'package:sunnova_app/core/usecases/usecase.dart'; // Import NoParams

// Define HomeState
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

  // Initial state
  factory HomeState.initial() => HomeState();

  // Loading state
  HomeState loading() => HomeState(isLoading: true);

  // Loaded state
  HomeState loaded({
    UserGameStatsEntity? userStats,
    List<CourseModuleEntity>? modules,
  }) => HomeState(
    userStats: userStats ?? this.userStats,
    modules: modules ?? this.modules,
    isLoading: false,
  );

  // Error state
  HomeState error(String message) =>
      HomeState(errorMessage: message, isLoading: false);
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

  // Placeholder methods
  Future<void> loadUserStats(String userId) async {
    _state = _state.loading();
    notifyListeners();

    final result = await getUserGameStats(GetUserGameStatsParams(userId: userId));

    result.fold(
      (failure) {
        _state = _state.error(failure.message ?? 'An unknown error occurred');
        notifyListeners();
      },
      (stats) {
        _state = _state.loaded(userStats: stats);
        notifyListeners();
      },
    );
  }

  Future<void> loadCourseModules() async {
    _state = _state.loading();
    notifyListeners();

    final result = await getCourseModules(NoParams());

    result.fold(
      (failure) {
        _state = _state.error(failure.message ?? 'An unknown error occurred');
        notifyListeners();
      },
      (modules) {
        _state = _state.loaded(modules: modules);
        notifyListeners();
      },
    );
  }

  Future<void> checkDailyLogin() async {
    // Implement daily login check logic
  }
}
