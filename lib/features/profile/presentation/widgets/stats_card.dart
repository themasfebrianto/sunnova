import 'package:flutter/material.dart';
import 'package:sunnova_app/features/home/domain/entities/user_game_stats_entity.dart'; // Import UserGameStatsEntity

class StatsCard extends StatelessWidget {
  final UserGameStatsEntity? userStats;

  const StatsCard({super.key, this.userStats});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          childAspectRatio: 2.5, // Adjust as needed
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          children: [
            _buildStatItem(context, 'Total XP', '${userStats?.xp ?? 0}'),
            _buildStatItem(context, 'Level', '${userStats?.level ?? 0}'),
            _buildStatItem(
              context,
              'Current Streak',
              '${userStats?.currentStreak ?? 0} Days',
            ),
            _buildStatItem(
              context,
              'Longest Streak',
              '${userStats?.longestStreak ?? 0} Days',
            ),
            _buildStatItem(
              context,
              'Lessons Completed',
              '${userStats?.lessonsCompleted ?? 0}',
            ),
            _buildStatItem(
              context,
              'Quizzes Passed',
              '${userStats?.quizzesPassed ?? 0}',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(BuildContext context, String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.labelMedium),
        Text(value, style: Theme.of(context).textTheme.titleMedium),
      ],
    );
  }
}
