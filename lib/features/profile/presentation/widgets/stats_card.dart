import 'package:flutter/material.dart';
import 'package:sunnova_app/features/home/domain/entities/user_game_stats_entity.dart';

class StatsCard extends StatelessWidget {
  final UserGameStatsEntity stats;

  const StatsCard({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          childAspectRatio: 2.5,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          children: [
            _buildStatItem(context, 'Total XP', stats.totalXp.toString()),
            _buildStatItem(context, 'Level', stats.level.toString()),
            _buildStatItem(context, 'Current Streak', stats.currentStreak.toString()),
            _buildStatItem(context, 'Longest Streak', stats.longestStreak.toString()),
            _buildStatItem(context, 'Lessons Completed', stats.lessonsCompleted.toString()),
            _buildStatItem(context, 'Quizzes Passed', stats.quizzesPassed.toString()),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(BuildContext context, String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }
}