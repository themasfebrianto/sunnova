import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunnova_app/features/home/presentation/notifiers/home_notifier.dart';
import 'package:sunnova_app/features/home/presentation/widgets/streak_card.dart';
import 'package:sunnova_app/features/home/presentation/widgets/xp_progress_bar.dart';
import 'package:sunnova_app/features/home/presentation/widgets/course_module_card.dart';
import 'package:sunnova_app/features/profile/presentation/pages/profile_page.dart'; // Import ProfilePage
import 'package:sunnova_app/features/leaderboard/presentation/pages/leaderboard_page.dart'; // Import LeaderboardPage
import 'package:sunnova_app/features/course/presentation/pages/course_detail_page.dart'; // Import CourseDetailPage

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    _HomeContent(), // Content for the Home tab
    const ProfilePage(), // Content for the Profile tab
    const LeaderboardPage(), // Content for the Leaderboard tab
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sunnova App'),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_events),
            label: 'Leaderboard',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        onTap: _onItemTapped,
      ),
    );
  }
}

class _HomeContent extends StatefulWidget { // Changed to StatefulWidget to use initState
  @override
  State<_HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<_HomeContent> {
  @override
  void initState() {
    super.initState();
    // Fetch data when the widget is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final homeNotifier = Provider.of<HomeNotifier>(context, listen: false);
      homeNotifier.fetchUserStats('current_user_id'); // Replace with actual user ID
      homeNotifier.fetchCourseModules();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeNotifier>(
      builder: (context, homeNotifier, child) {
        // Placeholder for loading and error states
        if (homeNotifier.state.isLoading) {
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
                'Welcome, User!', // Placeholder for user name
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 20),
              // Placeholder for StreakCard
              StreakCard(userStats: homeNotifier.state.userStats), // Pass userStats
              const SizedBox(height: 20),
              // Placeholder for XPProgressBar
              XPProgressBar(userStats: homeNotifier.state.userStats), // Pass userStats
              const SizedBox(height: 20),
              Text(
                'Course Modules',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 10),
              // Placeholder for CourseModuleCard list
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: homeNotifier.state.modules.length, // Use actual module count
                itemBuilder: (context, index) {
                  final module = homeNotifier.state.modules[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: GestureDetector( // Wrap with GestureDetector for tap
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => CourseDetailPage(courseModuleId: module.id),
                          ),
                        );
                      },
                      child: CourseModuleCard(courseModule: module), // Pass courseModule
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}