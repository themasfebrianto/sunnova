import 'package:flutter/material.dart';
import 'package:sunnova_app/features/leaderboard/domain/entities/leaderboard_rank_entity.dart'; // Import LeaderboardRankEntity
import 'package:sunnova_app/features/leaderboard/domain/usecases/get_leaderboard.dart';

// Define LeaderboardState
class LeaderboardState {
  final List<LeaderboardRankEntity> weeklyRanks;
  final List<LeaderboardRankEntity> monthlyRanks;
  final String selectedFilter; // 'WEEKLY' or 'MONTHLY'
  final int? currentUserRank;
  final bool isLoading;
  final String? errorMessage;

  LeaderboardState({
    this.weeklyRanks = const [],
    this.monthlyRanks = const [],
    this.selectedFilter = 'WEEKLY',
    this.currentUserRank,
    this.isLoading = false,
    this.errorMessage,
  });

  // Initial state
  factory LeaderboardState.initial() => LeaderboardState();

  // Loading state
  LeaderboardState loading() => LeaderboardState(isLoading: true);

  // Loaded state
  LeaderboardState loaded({
    List<LeaderboardRankEntity>? weeklyRanks,
    List<LeaderboardRankEntity>? monthlyRanks,
    String? selectedFilter,
    int? currentUserRank,
  }) => LeaderboardState(
    weeklyRanks: weeklyRanks ?? this.weeklyRanks,
    monthlyRanks: monthlyRanks ?? this.monthlyRanks,
    selectedFilter: selectedFilter ?? this.selectedFilter,
    currentUserRank: currentUserRank ?? this.currentUserRank,
    isLoading: false,
  );

  // Error state
  LeaderboardState error(String message) =>
      LeaderboardState(errorMessage: message, isLoading: false);
}

class LeaderboardNotifier extends ChangeNotifier {
  final GetLeaderboard getLeaderboard;

  LeaderboardNotifier({
    required this.getLeaderboard,
  });

  LeaderboardState _state = LeaderboardState.initial();
  LeaderboardState get state => _state;

  // Placeholder methods
  Future<void> loadLeaderboard(String rankType) async {
    _state = _state.loading();
    notifyListeners();
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    final List<LeaderboardRankEntity> fetchedRanks = [
      const LeaderboardRankEntity(
        userId: 'user1',
        userName: 'Alice',
        scoreValue: 1500,
        rank: 1,
        userPhotoUrl: 'https://via.placeholder.com/50',
        rankType: 'WEEKLY',
      ),
      const LeaderboardRankEntity(
        userId: 'user2',
        userName: 'Bob',
        scoreValue: 1400,
        rank: 2,
        userPhotoUrl: 'https://via.placeholder.com/50',
        rankType: 'WEEKLY',
      ),
      const LeaderboardRankEntity(
        userId: 'user3',
        userName: 'Charlie',
        scoreValue: 1300,
        rank: 3,
        userPhotoUrl: 'https://via.placeholder.com/50',
        rankType: 'WEEKLY',
      ),
      const LeaderboardRankEntity(
        userId: 'current_user_id',
        userName: 'You',
        scoreValue: 1200,
        rank: 4,
        userPhotoUrl: 'https://via.placeholder.com/50',
        rankType: 'WEEKLY',
      ),
      const LeaderboardRankEntity(
        userId: 'user4',
        userName: 'David',
        scoreValue: 1100,
        rank: 5,
        userPhotoUrl: 'https://via.placeholder.com/50',
        rankType: 'WEEKLY',
      ),
    ];

    if (rankType == 'WEEKLY') {
      _state = _state.loaded(weeklyRanks: fetchedRanks, currentUserRank: 4);
    } else {
      _state = _state.loaded(monthlyRanks: fetchedRanks, currentUserRank: 4);
    }
    notifyListeners();
  }

  void switchFilter(String filter) {
    _state = _state.loaded(selectedFilter: filter);
    loadLeaderboard(filter); // Fetch data for the new filter
  }
}
