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
  String _selectedFilter = 'WEEKLY'; // Default filter

  void _onFilterChanged(String newFilter) {
    setState(() {
      _selectedFilter = newFilter;
      // In a real app, you would call leaderboardNotifier.fetchLeaderboard(newFilter);
    });
  }

  @override
  Widget build(BuildContext context) {
    // final leaderboardNotifier = Provider.of<LeaderboardNotifier>(context); // Use if LeaderboardNotifier had data

    return Scaffold(
      appBar: AppBar(
        title: const Text('Leaderboard'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: LeaderboardFilter(
              selectedFilter: _selectedFilter,
              onFilterChanged: _onFilterChanged,
            ),
          ),
          const SizedBox(height: 20),
          // Current user rank card (placeholder)
          Card(
            color: Colors.blue.shade100,
            margin: const EdgeInsets.symmetric(horizontal: 16.0),
            child: const Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: [
                  CircleAvatar(
                    child: Text('Me'),
                  ),
                  SizedBox(width: 10),
                  Text('Your Rank: #5 - 1200 XP'), // Placeholder
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: 10, // Placeholder for number of ranks
              itemBuilder: (context, index) {
                return RankItem(); // Placeholder for actual rank data
              },
            ),
          ),
        ],
      ),
    );
  }
}
