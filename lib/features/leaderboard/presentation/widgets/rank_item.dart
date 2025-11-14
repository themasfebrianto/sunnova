import 'package:flutter/material.dart';
import 'package:sunnova_app/features/leaderboard/domain/entities/leaderboard_rank_entity.dart'; // Import LeaderboardRankEntity

class RankItem extends StatelessWidget {
  final LeaderboardRankEntity rank;
  final bool isCurrentUser;

  const RankItem({super.key, required this.rank, this.isCurrentUser = false});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      color: isCurrentUser
          ? Theme.of(context).colorScheme.secondaryContainer
          : Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Text(
              '#${rank.rank}',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: isCurrentUser
                    ? Theme.of(context).colorScheme.onSecondaryContainer
                    : Theme.of(context).colorScheme.onSurface,
              ),
            ),
            const SizedBox(width: 16),
            CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: Icon(
                Icons.person,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                rank.userName,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: isCurrentUser
                      ? Theme.of(context).colorScheme.onSecondaryContainer
                      : Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
            if (rank.rank <= 3)
              Icon(
                Icons.emoji_events,
                color: Theme.of(
                  context,
                ).colorScheme.tertiary, // Use tertiary for crown
                size: 24,
              ),
            const SizedBox(width: 8),
            Text(
              '${rank.xp} XP',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: isCurrentUser
                    ? Theme.of(context).colorScheme.onSecondaryContainer
                    : Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
