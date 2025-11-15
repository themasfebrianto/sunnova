import 'package:flutter/material.dart';
import 'package:sunnova_app/features/profile/domain/entities/user_achievement_entity.dart';
import 'package:intl/intl.dart';

class AchievementItem extends StatelessWidget {
  final UserAchievementEntity achievement;

  const AchievementItem({super.key, required this.achievement});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(
              achievement.isUnlocked ? Icons.star : Icons.star_border,
              color: achievement.isUnlocked ? Colors.amber : Colors.grey,
              size: 30,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    achievement.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    achievement.description,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  if (achievement.isUnlocked && achievement.unlockedAt != null)
                    Text(
                      'Unlocked: ${DateFormat.yMMMd().format(achievement.unlockedAt!)}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.grey,
                          ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}