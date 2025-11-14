import 'package:flutter/material.dart';
import 'package:sunnova_app/features/leaderboard/domain/entities/leaderboard_rank_entity.dart'; // Import LeaderboardRankEntity

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
  LeaderboardState _state = LeaderboardState.initial();
  LeaderboardState get state => _state;

  // Placeholder methods
  Future<void> fetchLeaderboard(String rankType) async {
    _state = _state.loading();
    notifyListeners();
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    final List<LeaderboardRankEntity> fetchedRanks = [
      LeaderboardRankEntity(
        userId: 'user1',
        userName: 'Alice',
        xp: 1500,
        rank: 1,
      ),
      LeaderboardRankEntity(
        userId: 'user2',
        userName: 'Bob',
        xp: 1400,
        rank: 2,
      ),
      LeaderboardRankEntity(
        userId: 'user3',
        userName: 'Charlie',
        xp: 1300,
        rank: 3,
      ),
      LeaderboardRankEntity(
        userId: 'current_user_id',
        userName: 'You',
        xp: 1200,
        rank: 4,
      ),
      LeaderboardRankEntity(
        userId: 'user4',
        userName: 'David',
        xp: 1100,
        rank: 5,
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
    fetchLeaderboard(filter); // Fetch data for the new filter
  }
}
