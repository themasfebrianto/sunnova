import 'package:flutter/material.dart';
import 'package:sunnova_app/features/profile/domain/entities/badge_entity.dart';

class BadgeGrid extends StatelessWidget {
  final List<BadgeEntity> badges;

  const BadgeGrid({super.key, required this.badges});

  @override
  Widget build(BuildContext context) {
    if (badges.isEmpty) {
      return const Center(child: Text('No badges earned yet.'));
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.8,
      ),
      itemCount: badges.length,
      itemBuilder: (context, index) {
        final badge = badges[index];
        return Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Placeholder for badge icon
              Icon(
                badge.isUnlocked ? Icons.military_tech : Icons.lock,
                size: 40,
                color: badge.isUnlocked ? Colors.amber : Colors.grey,
              ),
              const SizedBox(height: 8),
              Text(
                badge.title,
                textAlign: TextAlign.center,
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold),
              ),
              if (!badge.isUnlocked)
                Text(
                  'Locked',
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: Colors.red),
                ),
            ],
          ),
        );
      },
    );
  }
}
