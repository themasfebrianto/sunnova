import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunnova_app/features/home/presentation/notifiers/home_notifier.dart';
import 'package:sunnova_app/features/home/presentation/widgets/course_module_card.dart';
import 'package:sunnova_app/features/home/presentation/widgets/streak_card.dart';
import 'package:sunnova_app/features/home/presentation/widgets/xp_progress_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    // Assuming a user is logged in and we have their ID
    // Replace 'current_user_id' with actual user ID from AuthNotifier or similar
    Provider.of<HomeNotifier>(context, listen: false).fetchUserStats('current_user_id');
    Provider.of<HomeNotifier>(context, listen: false).fetchCourseModules();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sunnova Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Handle notifications
            },
          ),
        ],
      ),
      body: Consumer<HomeNotifier>(
        builder: (context, homeNotifier, child) {
          if (homeNotifier.state.isLoading &&
              homeNotifier.state.userStats == null &&
              homeNotifier.state.modules.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (homeNotifier.state.errorMessage != null) {
            return Center(child: Text('Error: ${homeNotifier.state.errorMessage}'));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome, ${homeNotifier.state.userStats?.userName ?? 'User'}!',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 20),
                if (homeNotifier.state.userStats != null)
                  StreakCard(userStats: homeNotifier.state.userStats!),
                const SizedBox(height: 20),
                if (homeNotifier.state.userStats != null)
                  XPProgressBar(userStats: homeNotifier.state.userStats!),
                const SizedBox(height: 30),
                Text(
                  'Course Modules',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 15),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: homeNotifier.state.modules.length,
                  itemBuilder: (context, index) {
                    final module = homeNotifier.state.modules[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      child: CourseModuleCard(module: module),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}