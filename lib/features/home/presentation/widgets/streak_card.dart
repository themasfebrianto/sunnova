import 'package:flutter/material.dart';
import 'package:sunnova_app/features/home/domain/entities/user_game_stats_entity.dart';

class StreakCard extends StatelessWidget {
  final UserGameStatsEntity userStats;

  const StreakCard({super.key, required this.userStats});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                const Icon(Icons.local_fire_department, color: Colors.orange, size: 30),
                const SizedBox(height: 8),
                Text(
                  '${userStats.currentStreak}',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                ),
                const Text('Current Streak'),
              ],
            ),
            Column(
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 30),
                const SizedBox(height: 8),
                Text(
                  '${userStats.longestStreak}',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.amber,
                      ),
                ),
                const Text('Longest Streak'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}