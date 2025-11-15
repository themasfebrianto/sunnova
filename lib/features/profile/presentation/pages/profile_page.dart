import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunnova_app/features/auth/presentation/pages/login_page.dart';
import 'package:sunnova_app/features/profile/presentation/notifiers/profile_notifier.dart';
import 'package:sunnova_app/features/profile/presentation/widgets/achievement_item.dart';
import 'package:sunnova_app/features/profile/presentation/widgets/badge_grid.dart';
import 'package:sunnova_app/features/profile/presentation/widgets/stats_card.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    // Assuming a user is logged in and we have their ID
    // Replace 'current_user_id' with actual user ID from AuthNotifier or similar
    Provider.of<ProfileNotifier>(context, listen: false)
        .loadProfileData('current_user_id');
  }

  void _logout() async {
    await Provider.of<ProfileNotifier>(context, listen: false).logout();
    if (!mounted) return;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const LoginPage()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      body: Consumer<ProfileNotifier>(
        builder: (context, profileNotifier, child) {
          if (profileNotifier.state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (profileNotifier.state.errorMessage != null) {
            return Center(
                child: Text('Error: ${profileNotifier.state.errorMessage}'));
          }

          final user = profileNotifier.state.user;
          final stats = profileNotifier.state.stats;
          final achievements = profileNotifier.state.achievements;

          if (user == null) {
            return const Center(child: Text('User profile not found.'));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundImage:
                      AssetImage('assets/images/default_avatar.png'), // Placeholder
                ),
                const SizedBox(height: 10),
                Text(
                  user.displayName ?? 'No Name',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Text(
                  user.email ?? 'No Email',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 20),
                if (stats != null) StatsCard(stats: stats),
                const SizedBox(height: 30),
                Text(
                  'Achievements',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 15),
                if (achievements.isEmpty)
                  const Text('No achievements yet.')
                else
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: achievements.length,
                    itemBuilder: (context, index) {
                      return AchievementItem(achievement: achievements[index]);
                    },
                  ),
                const SizedBox(height: 30),
                Text(
                  'Badges',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 15),
                // Placeholder for BadgeGrid, assuming badges are part of achievements or a separate list
                BadgeGrid(badges: []), // Pass actual badges here
              ],
            ),
          );
        },
      ),
    );
  }
}