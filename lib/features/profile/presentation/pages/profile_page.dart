import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunnova_app/features/profile/presentation/notifiers/profile_notifier.dart';
import 'package:sunnova_app/features/profile/presentation/widgets/stats_card.dart';
import 'package:sunnova_app/features/profile/presentation/widgets/badge_grid.dart';
import 'package:sunnova_app/features/profile/presentation/widgets/achievement_item.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // final profileNotifier = Provider.of<ProfileNotifier>(context); // Use if ProfileNotifier had data

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Theme.of(context).primaryColor, // Use theme color
                    child: Icon(
                      Icons.person, // Generic person icon
                      size: 60,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'John Doe', // Placeholder name
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'Level 10', // Placeholder level
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'Statistics',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            StatsCard(),
            const SizedBox(height: 30),
            const Text(
              'Badges',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 150, // Adjust height as needed
              child: BadgeGrid(),
            ),
            const SizedBox(height: 30),
            const Text(
              'Achievements',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            // Placeholder for list of AchievementItem
            AchievementItem(),
            AchievementItem(),
            AchievementItem(),
          ],
        ),
      ),
    );
  }
}
