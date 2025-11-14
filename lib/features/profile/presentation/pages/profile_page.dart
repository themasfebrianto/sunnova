import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunnova_app/features/profile/presentation/notifiers/profile_notifier.dart';
import 'package:sunnova_app/features/profile/presentation/widgets/stats_card.dart';
import 'package:sunnova_app/features/profile/presentation/widgets/badge_grid.dart';
import 'package:sunnova_app/features/profile/presentation/widgets/achievement_item.dart';

class ProfilePage extends StatefulWidget {
  // Changed to StatefulWidget
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final profileNotifier = Provider.of<ProfileNotifier>(
        context,
        listen: false,
      );
      profileNotifier.fetchUserProfile(
        'current_user_id',
      ); // Replace with actual user ID
      profileNotifier.fetchUserStats(
        'current_user_id',
      ); // Replace with actual user ID
      profileNotifier.fetchUserAchievements(
        'current_user_id',
      ); // Replace with actual user ID
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile', style: Theme.of(context).textTheme.titleLarge),
      ),
      body: Consumer<ProfileNotifier>(
        builder: (context, profileNotifier, child) {
          if (profileNotifier.state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (profileNotifier.state.errorMessage != null) {
            return Center(
              child: Text('Error: ${profileNotifier.state.errorMessage}'),
            );
          }

          final user = profileNotifier.state.user;
          final stats = profileNotifier.state.stats;
          final achievements = profileNotifier.state.achievements;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Theme.of(
                          context,
                        ).colorScheme.primary, // Use theme color
                        child: Icon(
                          Icons.person, // Generic person icon
                          size: 60,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        user?.displayName ??
                            'Guest User', // Display actual user name
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      Text(
                        'Level ${stats?.level ?? 0}', // Display actual level
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  'Statistics',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 10),
                StatsCard(userStats: stats), // Pass actual stats
                const SizedBox(height: 30),
                Text(
                  'Badges',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 150, // Adjust height as needed
                  child: BadgeGrid(
                    achievements: achievements,
                  ), // Pass actual achievements
                ),
                const SizedBox(height: 30),
                Text(
                  'Achievements',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 10),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: achievements.length,
                  itemBuilder: (context, index) {
                    final achievement = achievements[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: AchievementItem(
                        achievement: achievement,
                      ), // Pass actual achievement
                    );
                  },
                ),
              ],
            ),
          );
        }, // Closing brace for builder
      ),
    );
  }
}
