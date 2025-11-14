import 'package:flutter/material.dart';
import 'package:sunnova_app/features/home/domain/entities/user_game_stats_entity.dart'; // Import UserGameStatsEntity

class XPProgressBar extends StatelessWidget {
  final UserGameStatsEntity? userStats; // Accept userStats as parameter

  const XPProgressBar({super.key, this.userStats});

  @override
  Widget build(BuildContext context) {
    final int currentXp = userStats?.xp ?? 0;
    final int level = userStats?.level ?? 0;
    // Assuming a simple XP calculation for next level, e.g., 1000 XP per level
    final int xpForNextLevel = (level + 1) * 1000;
    final double progress = currentXp / xpForNextLevel;

    // Accessing the xpGradient from the theme (assuming it's defined in main.dart)
    // If not directly accessible, we might need to pass it or define it here.
    // Based on GEMINI.md, xpGradient is defined as:
    const LinearGradient xpGradient = LinearGradient(
      colors: [Color(0xFF74B9FF), Color(0xFF5F9FE8)],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    );

    return Card(
      margin: EdgeInsets.zero,
      // Card theme is applied globally in main.dart
      child: Padding(
        padding: const EdgeInsets.all(16.0), // Use spacing constants if defined globally
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Level $level - $currentXp/$xpForNextLevel XP', // Display actual XP progress
              style: Theme.of(context).textTheme.titleSmall, // Use theme typography
            ),
            const SizedBox(height: 10), // Use spacing constants
            ClipRRect(
              borderRadius: BorderRadius.circular(5), // Use radius constants if defined globally
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
                valueColor: AlwaysStoppedAnimation<Color>(xpGradient.colors.first), // Use first color of gradient for now
                minHeight: 10,
                // LinearProgressIndicator does not directly support gradients.
                // A custom painter or a ShaderMask might be needed for a true gradient.
                // For simplicity, using the first color of the gradient.
                // If a true gradient is required, a custom widget would be needed.
              ),
            ),
          ],
        ),
      ),
    );
  }
}