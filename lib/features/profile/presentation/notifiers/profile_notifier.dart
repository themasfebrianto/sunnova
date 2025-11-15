import 'package:flutter/material.dart';
import 'package:sunnova_app/features/auth/domain/entities/user_entity.dart';
import 'package:sunnova_app/features/profile/domain/entities/user_achievement_entity.dart';
import 'package:sunnova_app/features/home/domain/entities/user_game_stats_entity.dart';
import 'package:sunnova_app/features/profile/domain/entities/badge_entity.dart'; // Import BadgeEntity
import 'package:sunnova_app/features/profile/domain/usecases/get_user_profile.dart';
import 'package:sunnova_app/features/home/domain/usecases/get_user_game_stats.dart';
import 'package:sunnova_app/features/profile/domain/usecases/get_user_achievements.dart';
import 'package:sunnova_app/features/profile/domain/usecases/get_badges.dart';
import 'package:sunnova_app/features/auth/domain/usecases/logout_user.dart';
import 'package:sunnova_app/core/usecases/usecase.dart'; // Import NoParams

// Define ProfileState
class ProfileState {
  final UserEntity? user;
  final UserGameStatsEntity? stats;
  final List<UserAchievementEntity> achievements;
  final List<BadgeEntity> badges; // Add badges list
  final bool isLoading;
  final String? errorMessage;

  ProfileState({
    this.user,
    this.stats,
    this.achievements = const [],
    this.badges = const [], // Initialize badges
    this.isLoading = false,
    this.errorMessage,
  });

  // Initial state
  factory ProfileState.initial() => ProfileState();

  // Loading state
  ProfileState loading() => ProfileState(isLoading: true);

  // Loaded state
  ProfileState loaded({
    UserEntity? user,
    UserGameStatsEntity? stats,
    List<UserAchievementEntity>? achievements,
    List<BadgeEntity>? badges, // Add badges to loaded state
  }) => ProfileState(
    user: user ?? this.user,
    stats: stats ?? this.stats,
    achievements: achievements ?? this.achievements,
    badges: badges ?? this.badges, // Update badges
    isLoading: false,
  );

  // Error state
  ProfileState error(String message) =>
      ProfileState(errorMessage: message, isLoading: false);
}

class ProfileNotifier extends ChangeNotifier {
  final GetUserProfile fetchUserProfile;
  final GetUserGameStats fetchUserStats;
  final GetUserAchievements fetchUserAchievements;
  final GetBadges fetchBadges;
  final LogoutUser logout;

  ProfileNotifier({
    required this.fetchUserProfile,
    required this.fetchUserStats,
    required this.fetchUserAchievements,
    required this.fetchBadges,
    required this.logout,
  });

  ProfileState _state = ProfileState.initial();
  ProfileState get state => _state;

  // Placeholder methods
  Future<void> loadUserProfile(String userId) async {
    _state = _state.loading();
    notifyListeners();
    final result = await fetchUserProfile(GetUserProfileParams(userId: userId));
    result.fold(
      (failure) => _state = _state.error(failure.message ?? 'An unknown error occurred'),
      (user) => _state = _state.loaded(user: user),
    );
    notifyListeners();
  }

  Future<void> loadUserStats(String userId) async {
    _state = _state.loading();
    notifyListeners();
    final result = await fetchUserStats(GetUserGameStatsParams(userId: userId));
    result.fold(
      (failure) => _state = _state.error(failure.message ?? 'An unknown error occurred'),
      (stats) => _state = _state.loaded(stats: stats),
    );
    notifyListeners();
  }

  Future<void> loadUserAchievements(String userId) async {
    _state = _state.loading();
    notifyListeners();
    final result = await fetchUserAchievements(GetUserAchievementsParams(userId: userId));
    result.fold(
      (failure) => _state = _state.error(failure.message ?? 'An unknown error occurred'),
      (achievements) => _state = _state.loaded(achievements: achievements),
    );
    notifyListeners();
  }

  Future<void> loadBadges() async {
    _state = _state.loading();
    notifyListeners();
    final result = await fetchBadges(NoParams());
    result.fold(
      (failure) => _state = _state.error(failure.message ?? 'An unknown error occurred'),
      (badges) => _state = _state.loaded(badges: badges),
    );
    notifyListeners();
  }

  void performLogout() async {
    _state = _state.loading();
    notifyListeners();
    final result = await logout(NoParams());
    result.fold(
      (failure) => _state = _state.error(failure.message ?? 'An unknown error occurred'),
      (_) => _state = ProfileState.initial(),
    );
    notifyListeners();
  }
}
