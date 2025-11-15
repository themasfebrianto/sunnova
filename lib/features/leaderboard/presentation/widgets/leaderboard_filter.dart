import 'package:flutter/material.dart';
import 'package:sunnova_app/features/leaderboard/presentation/notifiers/leaderboard_notifier.dart';

class LeaderboardFilterWidget extends StatelessWidget {
  final LeaderboardFilter selectedFilter;
  final Function(LeaderboardFilter) onFilterSelected;

  const LeaderboardFilterWidget({
    super.key,
    required this.selectedFilter,
    required this.onFilterSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FilterChip(
            label: const Text('Weekly'),
            selected: selectedFilter == LeaderboardFilter.weekly,
            onSelected: (selected) {
              if (selected) onFilterSelected(LeaderboardFilter.weekly);
            },
          ),
          FilterChip(
            label: const Text('Monthly'),
            selected: selectedFilter == LeaderboardFilter.monthly,
            onSelected: (selected) {
              if (selected) onFilterSelected(LeaderboardFilter.monthly);
            },
          ),
        ],
      ),
    );
  }
}