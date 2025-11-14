import 'package:flutter/material.dart';
import 'package:sunnova_app/features/home/domain/entities/course_module_entity.dart';
import 'package:sunnova_app/features/home/domain/entities/user_game_stats_entity.dart';

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
  }) =>
      HomeState(
        userStats: userStats ?? this.userStats,
        modules: modules ?? this.modules,
        isLoading: false,
      );

  // Error state
  HomeState error(String message) => HomeState(
        errorMessage: message,
        isLoading: false,
      );
}

class HomeNotifier extends ChangeNotifier {
  HomeState _state = HomeState.initial();
  HomeState get state => _state;

  // Placeholder methods
  Future<void> fetchUserStats(String userId) async {
    _state = _state.loading();
    notifyListeners();
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));
    _state = _state.loaded(
      userStats: UserGameStatsEntity(
        xp: 1200,
        level: 5,
        currentStreak: 7,
        longestStreak: 15,
        lessonsCompleted: 25,
        quizzesPassed: 10,
      ),
    );
    notifyListeners();
  }

  Future<void> fetchCourseModules() async {
    _state = _state.loading();
    notifyListeners();
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));
    _state = _state.loaded(
      modules: [
        CourseModuleEntity(
          id: '1',
          title: 'Tajwid Basic',
          description: 'Learn the basics of Tajwid.',
          imageUrl: 'https://via.placeholder.com/150',
          requiredXpToUnlock: 0,
          isLocked: false,
          totalLessons: 10,
          completedLessons: 3,
        ),
        CourseModuleEntity(
          id: '2',
          title: 'Fiqh Fundamentals',
          description: 'Understand the fundamentals of Fiqh.',
          imageUrl: 'https://via.placeholder.com/150',
          requiredXpToUnlock: 500,
          isLocked: true,
          totalLessons: 12,
          completedLessons: 0,
        ),
      ],
    );
    notifyListeners();
  }

  Future<void> checkDailyLogin() async {
    // Implement daily login check logic
  }
}