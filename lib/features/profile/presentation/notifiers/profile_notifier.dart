import 'package:flutter/material.dart';
import 'package:sunnova_app/core/usecases/usecase.dart';
import 'package:sunnova_app/features/auth/domain/entities/user_profile_entity.dart';
import 'package:sunnova_app/features/auth/domain/usecases/logout_user.dart';
import 'package:sunnova_app/features/home/domain/entities/user_game_stats_entity.dart';
import 'package:sunnova_app/features/home/domain/usecases/get_user_game_stats.dart';
import 'package:sunnova_app/features/profile/domain/entities/user_achievement_entity.dart';
import 'package:sunnova_app/features/profile/domain/usecases/get_user_achievements.dart';
import 'package:sunnova_app/features/profile/domain/usecases/get_user_profile.dart';

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

  ProfileState copyWith({
    UserProfileEntity? user,
    UserGameStatsEntity? stats,
    List<UserAchievementEntity>? achievements,
    bool? isLoading,
    String? errorMessage,
  }) {
    return ProfileState(
      user: user ?? this.user,
      stats: stats ?? this.stats,
      achievements: achievements ?? this.achievements,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  factory ProfileState.initial() => ProfileState();
  ProfileState loading() => ProfileState(isLoading: true);
  ProfileState loaded({
    UserProfileEntity? user,
    UserGameStatsEntity? stats,
    List<UserAchievementEntity>? achievements,
  }) =>
      ProfileState(
        user: user ?? this.user,
        stats: stats ?? this.stats,
        achievements: achievements ?? this.achievements,
        isLoading: false,
      );
  ProfileState error(String message) => ProfileState(errorMessage: message, isLoading: false);
}

class ProfileNotifier extends ChangeNotifier {
  final GetUserProfile fetchUserProfile;
  final GetUserGameStats fetchUserStats;
  final GetUserAchievements fetchUserAchievements;
  final LogoutUser logoutUser;

  ProfileNotifier({
    required this.fetchUserProfile,
    required this.fetchUserStats,
    required this.fetchUserAchievements,
    required this.logoutUser,
  });

  ProfileState _state = ProfileState.initial();
  ProfileState get state => _state;

  Future<void> loadProfileData(String userId) async {
    _state = _state.loading();
    notifyListeners();

    final userResult = await fetchUserProfile(GetUserProfileParams(id: userId));
    final statsResult = await fetchUserStats(GetUserGameStatsParams(userId: userId));
    final achievementsResult = await fetchUserAchievements(GetUserAchievementsParams(userId: userId));

    UserProfileEntity? user;
    UserGameStatsEntity? stats;
    List<UserAchievementEntity> achievements = [];
    String? errorMsg;

    userResult.fold(
      (failure) => errorMsg = failure.message,
      (data) => user = data,
    );
    statsResult.fold(
      (failure) => errorMsg = errorMsg ?? failure.message,
      (data) => stats = data,
    );
    achievementsResult.fold(
      (failure) => errorMsg = errorMsg ?? failure.message,
      (data) => achievements = data,
    );

    if (errorMsg != null) {
      _state = _state.error(errorMsg!);
    } else {
      _state = _state.loaded(user: user, stats: stats, achievements: achievements);
    }
    notifyListeners();
  }

  Future<void> logout() async {
    await logoutUser(NoParams());
    _state = ProfileState.initial(); // Reset state on logout
    notifyListeners();
  }
}