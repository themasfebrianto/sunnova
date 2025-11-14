import 'package:flutter/material.dart';
import 'package:sunnova_app/features/home/domain/entities/user_game_stats_entity.dart'; // Import UserGameStatsEntity

class StreakCard extends StatelessWidget {
  final UserGameStatsEntity? userStats; // Accept userStats as parameter

  const StreakCard({super.key, this.userStats});

  @override
  Widget build(BuildContext context) {
    final int currentStreak = userStats?.currentStreak ?? 0;
    final int longestStreak = userStats?.longestStreak ?? 0;

    return Card(
      margin: EdgeInsets.zero,
      // Card theme is applied globally in main.dart
      child: Padding(
        padding: const EdgeInsets.all(16.0), // Use spacing constants if defined globally
        child: Row(
          children: [
            Icon(
              Icons.local_fire_department,
              color: Theme.of(context).colorScheme.secondary, // Use theme color
              size: 40, // Use icon size constants if defined globally
            ),
            const SizedBox(width: 10), // Use spacing constants
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Current Streak',
                  style: Theme.of(context).textTheme.labelMedium, // Use theme typography
                ),
                Text(
                  '$currentStreak Days 🔥', // Display actual current streak
                  style: Theme.of(context).textTheme.headlineSmall, // Use theme typography
                ),
              ],
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Longest Streak',
                  style: Theme.of(context).textTheme.labelSmall, // Use theme typography
                ),
                Text(
                  '$longestStreak Days', // Display actual longest streak
                  style: Theme.of(context).textTheme.titleSmall, // Use theme typography
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}