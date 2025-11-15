import 'package:flutter/material.dart';
import 'package:sunnova_app/features/leaderboard/domain/entities/leaderboard_rank_entity.dart';

class RankItem extends StatelessWidget {
  final LeaderboardRankEntity rank;
  final int index;

  const RankItem({super.key, required this.rank, required this.index});

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
            Text(
              '#${index + 1}',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: index < 3 ? Colors.amber : Colors.grey,
                  ),
            ),
            const SizedBox(width: 16),
            CircleAvatar(
              backgroundImage: rank.userPhotoUrl != null ? NetworkImage(rank.userPhotoUrl!) : null,
              child: rank.userPhotoUrl == null ? const Icon(Icons.person) : null,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                rank.userName,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Text(
              '${rank.scoreValue} XP',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            if (index < 3)
              const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Icon(Icons.emoji_events, color: Colors.amber),
              ),
          ],
        ),
      ),
    );
  }
}