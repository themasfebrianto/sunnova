import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunnova_app/features/leaderboard/domain/entities/leaderboard_rank_entity.dart';
import 'package:sunnova_app/features/leaderboard/presentation/notifiers/leaderboard_notifier.dart'; // Import LeaderboardNotifier
import 'package:sunnova_app/features/leaderboard/presentation/widgets/rank_item.dart'; // Import RankItem
import 'package:sunnova_app/features/leaderboard/presentation/widgets/leaderboard_filter.dart'; // Import LeaderboardFilter

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({super.key});

  @override
  State<LeaderboardPage> createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final leaderboardNotifier = Provider.of<LeaderboardNotifier>(
        context,
        listen: false,
      );
      leaderboardNotifier.loadLeaderboard('WEEKLY'); // Fetch initial data
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Leaderboard',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Consumer<LeaderboardNotifier>(
        builder: (context, leaderboardNotifier, child) {
          if (leaderboardNotifier.state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (leaderboardNotifier.state.errorMessage != null) {
            return Center(
              child: Text('Error: ${leaderboardNotifier.state.errorMessage}'),
            );
          }

          final ranks = leaderboardNotifier.state.selectedFilter == 'WEEKLY'
              ? leaderboardNotifier.state.weeklyRanks
              : leaderboardNotifier.state.monthlyRanks;

          // Find current user's rank to display in the highlighted card
          LeaderboardRankEntity currentUserRankItem;
          try {
            currentUserRankItem = ranks.firstWhere(
              (rank) => rank.userId == 'current_user_id',
            );
          } catch (e) {
            currentUserRankItem = LeaderboardRankEntity(
              userId: 'current_user_id',
              userName: 'You',
              scoreValue: 0,
              rank: leaderboardNotifier.state.currentUserRank ?? 0,
              userPhotoUrl: 'https://via.placeholder.com/50',
              rankType: leaderboardNotifier.state.selectedFilter,
            );
          }

          return Column(
            children: [
              LeaderboardFilter(
                selectedFilter: leaderboardNotifier.state.selectedFilter,
                onFilterSelected: (filter) {
                  leaderboardNotifier.switchFilter(filter);
                },
              ),
              const SizedBox(height: 16),
              // Current user rank card (highlighted)
              if (leaderboardNotifier.state.currentUserRank != null)
                Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  color: Theme.of(context).colorScheme.primaryContainer,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Text(
                          '#${currentUserRankItem.rank}',
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onPrimaryContainer,
                              ),
                        ),
                        const SizedBox(width: 16),
                        CircleAvatar(
                          backgroundImage: currentUserRankItem.userPhotoUrl != null
                              ? NetworkImage(currentUserRankItem.userPhotoUrl!)
                              : const AssetImage('assets/images/default_avatar.png') as ImageProvider, // Provide a default asset image
                          backgroundColor: Theme.of(
                            context,
                          ).colorScheme.primary,
                          child: currentUserRankItem.userPhotoUrl == null
                              ? const Icon(
                                  Icons.person,
                                  color: Colors.white,
                                )
                              : null,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            currentUserRankItem.userName,
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onPrimaryContainer,
                                ),
                          ),
                        ),
                        Text(
                          '${currentUserRankItem.scoreValue} XP',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onPrimaryContainer,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: ranks.length,
                  itemBuilder: (context, index) {
                    final rankItem = ranks[index];
                    return RankItem(
                      rank: rankItem,
                      isCurrentUser: rankItem.userId == 'current_user_id',
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
