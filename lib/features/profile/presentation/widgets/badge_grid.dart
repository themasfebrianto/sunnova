import 'package:flutter/material.dart';
import 'package:sunnova_app/features/profile/domain/entities/user_achievement_entity.dart'; // Import UserAchievementEntity

class BadgeGrid extends StatelessWidget {
  final List<UserAchievementEntity> achievements;

  const BadgeGrid({super.key, required this.achievements});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4, // 4 badges per row
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.8, // Adjust as needed
      ),
      itemCount: achievements.length,
      itemBuilder: (context, index) {
        final achievement = achievements[index];
        return Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: achievement.isUnlocked
                      ? Theme.of(context).colorScheme.secondaryContainer
                      : Theme.of(context).colorScheme.surfaceContainerHighest,
                  child: Icon(
                    Icons
                        .star, // Placeholder icon, could be dynamic based on achievement
                    size: 30,
                    color: achievement.isUnlocked
                        ? Theme.of(context).colorScheme.secondary
                        : Theme.of(context).colorScheme.onSurface.withAlpha((255 * 0.5).round()),
                  ),
                ),
                if (!achievement.isUnlocked)
                  Icon(
                    Icons.lock,
                    size: 20,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withAlpha((255 * 0.7).round()),
                  ),
              ],
            ),
            const SizedBox(height: 5),
            Text(
              achievement.title,
              style: Theme.of(context).textTheme.labelSmall,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        );
      },
    );
  }
}
