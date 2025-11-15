import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunnova_app/features/leaderboard/presentation/notifiers/leaderboard_notifier.dart';
import 'package:sunnova_app/features/leaderboard/presentation/widgets/leaderboard_filter.dart';
import 'package:sunnova_app/features/leaderboard/presentation/widgets/rank_item.dart';

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({super.key});

  @override
  State<LeaderboardPage> createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  @override
  void initState() {
    super.initState();
    // Assuming a user is logged in and we have their ID
    // Replace 'current_user_id' with actual user ID from AuthNotifier or similar
    Provider.of<LeaderboardNotifier>(context, listen: false)
        .fetchLeaderboard(LeaderboardFilter.weekly);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leaderboard'),
      ),
      body: Consumer<LeaderboardNotifier>(
        builder: (context, leaderboardNotifier, child) {
          if (leaderboardNotifier.state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (leaderboardNotifier.state.errorMessage != null) {
            return Center(
                child: Text('Error: ${leaderboardNotifier.state.errorMessage}'));
          }

          return Column(
            children: [
              LeaderboardFilterWidget(
                selectedFilter: leaderboardNotifier.state.selectedFilter,
                onFilterSelected: (filter) {
                  leaderboardNotifier.switchFilter(filter);
                },
              ),
              const SizedBox(height: 10),
              if (leaderboardNotifier.state.currentUserRank != null)
                Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  color: Colors.blue.shade100,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        Text(
                          '#${leaderboardNotifier.state.currentUserRank}',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue.shade800,
                              ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            'You', // Replace with actual user name
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                        Text(
                          '${leaderboardNotifier.state.ranks.firstWhere((rank) => rank.userId == 'current_user_id', orElse: () => leaderboardNotifier.state.ranks.first).scoreValue} XP', // This is a placeholder, needs actual user score
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                  ),
                ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: leaderboardNotifier.state.ranks.length,
                  itemBuilder: (context, index) {
                    final rank = leaderboardNotifier.state.ranks[index];
                    return RankItem(rank: rank, index: index);
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