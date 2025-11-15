import 'package:flutter/material.dart';
import 'package:sunnova_app/features/profile/domain/entities/user_achievement_entity.dart'; // Import UserAchievementEntity
import 'package:sunnova_app/features/profile/domain/entities/badge_entity.dart'; // Import BadgeEntity

class BadgeGrid extends StatelessWidget {
  final List<UserAchievementEntity> achievements;
  final List<BadgeEntity> badges;

  const BadgeGrid({super.key, required this.achievements, required this.badges});

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
      itemCount: badges.length, // Use badges length
      itemBuilder: (context, index) {
        final badge = badges[index];
        final userAchievement = achievements.firstWhere(
          (ach) => ach.badgeId == badge.id,
          orElse: () => UserAchievementEntity(
            id: '',
            userId: '',
            badgeId: badge.id,
            unlockedAt: DateTime.now().add(const Duration(days: 365)), // Future date for locked
            isNew: false,
          ),
        );
        final bool isUnlocked = userAchievement.unlockedAt.isBefore(DateTime.now());

        return Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: isUnlocked
                      ? Theme.of(context).colorScheme.secondaryContainer
                      : Theme.of(context).colorScheme.surfaceContainerHighest,
                  child: Icon(
                    Icons.star, // Placeholder icon, could be dynamic based on badge.icon
                    size: 30,
                    color: isUnlocked
                        ? Theme.of(context).colorScheme.secondary
                        : Theme.of(context).colorScheme.onSurface.withAlpha((255 * 0.5).round()),
                  ),
                ),
                if (!isUnlocked)
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
              badge.title,
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
