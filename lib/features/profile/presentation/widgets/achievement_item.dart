import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import for date formatting
import 'package:sunnova_app/features/profile/domain/entities/user_achievement_entity.dart'; // Import UserAchievementEntity
import 'package:sunnova_app/features/profile/domain/entities/badge_entity.dart'; // Import BadgeEntity

class AchievementItem extends StatelessWidget {
  final UserAchievementEntity achievement;
  final BadgeEntity badge;

  const AchievementItem({super.key, required this.achievement, required this.badge});

  @override
  Widget build(BuildContext context) {
    final bool isUnlocked = achievement.unlockedAt.isBefore(DateTime.now());

    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: isUnlocked
                  ? Theme.of(context).colorScheme.primaryContainer
                  : Theme.of(context).colorScheme.surfaceContainerHighest,
              child: Icon(
                Icons.emoji_events, // Placeholder icon, could be dynamic
                color: isUnlocked
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.onSurface.withAlpha((255 * 0.5).round()),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    badge.title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    badge.description,
                    style: Theme.of(context).textTheme.bodySmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            if (isUnlocked)
              Text(
                DateFormat('MMM d, yyyy').format(achievement.unlockedAt),
                style: Theme.of(context).textTheme.labelSmall,
              )
            else
              Icon(
                Icons.lock,
                color: Theme.of(context).colorScheme.onSurface.withAlpha((255 * 0.5).round()),
              ),
          ],
        ),
      ),
    );
  }
}
