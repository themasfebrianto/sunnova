import 'package:flutter/material.dart';
import 'package:sunnova_app/features/leaderboard/domain/entities/leaderboard_rank_entity.dart';
import 'package:sunnova_app/features/leaderboard/domain/usecases/get_leaderboard.dart';

enum LeaderboardFilter { weekly, monthly }

class LeaderboardState {
  final List<LeaderboardRankEntity> ranks;
  final LeaderboardFilter selectedFilter;
  final int? currentUserRank;
  final bool isLoading;
  final String? errorMessage;

  LeaderboardState({
    this.ranks = const [],
    this.selectedFilter = LeaderboardFilter.weekly,
    this.currentUserRank,
    this.isLoading = false,
    this.errorMessage,
  });

  LeaderboardState copyWith({
    List<LeaderboardRankEntity>? ranks,
    LeaderboardFilter? selectedFilter,
    int? currentUserRank,
    bool? isLoading,
    String? errorMessage,
  }) {
    return LeaderboardState(
      ranks: ranks ?? this.ranks,
      selectedFilter: selectedFilter ?? this.selectedFilter,
      currentUserRank: currentUserRank ?? this.currentUserRank,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  factory LeaderboardState.initial() => LeaderboardState();
  LeaderboardState loading() => LeaderboardState(isLoading: true);
  LeaderboardState loaded({
    List<LeaderboardRankEntity>? ranks,
    LeaderboardFilter? selectedFilter,
    int? currentUserRank,
  }) =>
      LeaderboardState(
        ranks: ranks ?? this.ranks,
        selectedFilter: selectedFilter ?? this.selectedFilter,
        currentUserRank: currentUserRank ?? this.currentUserRank,
        isLoading: false,
      );
  LeaderboardState error(String message) => LeaderboardState(errorMessage: message, isLoading: false);
}

class LeaderboardNotifier extends ChangeNotifier {
  final GetLeaderboard getLeaderboard;

  LeaderboardNotifier({required this.getLeaderboard});

  LeaderboardState _state = LeaderboardState.initial();
  LeaderboardState get state => _state;

  Future<void> fetchLeaderboard(LeaderboardFilter filter) async {
    _state = _state.loading();
    notifyListeners();

    final result = await getLeaderboard(GetLeaderboardParams(
      rankType: filter.toString().split('.').last, // 'weekly' or 'monthly'
    ));

    result.fold(
      (failure) {
        _state = _state.error(failure.message ?? 'Failed to fetch leaderboard');
        notifyListeners();
      },
      (ranks) {
        // Determine current user's rank
        // int? currentUserRank;
        // final userRankIndex = ranks.indexWhere((rank) => rank.userId == userId);
        // if (userRankIndex != -1) {
        //   currentUserRank = userRankIndex + 1;
        // }

        _state = _state.loaded(
          ranks: ranks,
          selectedFilter: filter,
          // currentUserRank: currentUserRank,
        );
        notifyListeners();
      },
    );
  }

  void switchFilter(LeaderboardFilter filter) {
    if (_state.selectedFilter != filter) {
      fetchLeaderboard(filter);
    }
  }
}