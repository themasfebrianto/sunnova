import 'package:flutter/material.dart';
import 'package:sunnova_app/features/profile/domain/entities/user_profile_entity.dart';
import 'package:sunnova_app/features/profile/domain/entities/user_achievement_entity.dart';
import 'package:sunnova_app/features/home/domain/entities/user_game_stats_entity.dart'; // Import UserGameStatsEntity

// Define ProfileState
class ProfileState {
  final UserProfileEntity? user;
  final UserGameStatsEntity? stats;
  final List<UserAchievementEntity> achievements;
  final bool isLoading;
  final String? errorMessage;

  ProfileState({
    this.user,
    this.stats,
    this.achievements = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  // Initial state
  factory ProfileState.initial() => ProfileState();

  // Loading state
  ProfileState loading() => ProfileState(isLoading: true);

  // Loaded state
  ProfileState loaded({
    UserProfileEntity? user,
    UserGameStatsEntity? stats,
    List<UserAchievementEntity>? achievements,
  }) => ProfileState(
    user: user ?? this.user,
    stats: stats ?? this.stats,
    achievements: achievements ?? this.achievements,
    isLoading: false,
  );

  // Error state
  ProfileState error(String message) =>
      ProfileState(errorMessage: message, isLoading: false);
}

class ProfileNotifier extends ChangeNotifier {
  ProfileState _state = ProfileState.initial();
  ProfileState get state => _state;

  // Placeholder methods
  Future<void> fetchUserProfile(String userId) async {
    _state = _state.loading();
    notifyListeners();
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));
    _state = _state.loaded(
      user: UserProfileEntity(
        uid: userId,
        email: 'john.doe@example.com',
        displayName: 'John Doe',
        gender: 'male',
        photoURL: null,
        gameStats: UserGameStatsEntity(
          xp: 1500,
          level: 6,
          currentStreak: 10,
          longestStreak: 20,
          lessonsCompleted: 30,
          quizzesPassed: 12,
        ),
      ),
    );
    notifyListeners();
  }

  Future<void> fetchUserStats(String userId) async {
    _state = _state.loading();
    notifyListeners();
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));
    _state = _state.loaded(
      stats: UserGameStatsEntity(
        xp: 1500,
        level: 6,
        currentStreak: 10,
        longestStreak: 20,
        lessonsCompleted: 30,
        quizzesPassed: 12,
      ),
    );
    notifyListeners();
  }

  Future<void> fetchUserAchievements(String userId) async {
    _state = _state.loading();
    notifyListeners();
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));
    _state = _state.loaded(
      achievements: [
        UserAchievementEntity(
          id: 'ach1',
          title: 'First Lesson',
          description: 'Completed your first lesson.',
          iconUrl: 'https://via.placeholder.com/50',
          unlockedAt: DateTime.now().subtract(const Duration(days: 5)),
          isUnlocked: true,
        ),
        UserAchievementEntity(
          id: 'ach2',
          title: 'Quiz Master',
          description: 'Passed 10 quizzes.',
          iconUrl: 'https://via.placeholder.com/50',
          unlockedAt: DateTime.now().subtract(const Duration(days: 2)),
          isUnlocked: true,
        ),
        UserAchievementEntity(
          id: 'ach3',
          title: 'Streak Enthusiast',
          description: 'Maintained a 7-day streak.',
          iconUrl: 'https://via.placeholder.com/50',
          unlockedAt: DateTime.now().subtract(const Duration(days: 1)),
          isUnlocked: true,
        ),
        UserAchievementEntity(
          id: 'ach4',
          title: 'Level 10',
          description: 'Reached level 10.',
          iconUrl: 'https://via.placeholder.com/50',
          unlockedAt: DateTime.now().add(
            const Duration(days: 10),
          ), // Future date for locked
          isUnlocked: false,
        ),
      ],
    );
    notifyListeners();
  }

  void logout() {
    // Implement logout logic
    _state = ProfileState.initial();
    notifyListeners();
  }
}
