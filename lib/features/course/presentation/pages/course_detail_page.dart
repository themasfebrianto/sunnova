import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunnova_app/features/course/presentation/notifiers/course_notifier.dart';
import 'package:sunnova_app/features/course/presentation/widgets/lesson_unit_card.dart'; // Import LessonUnitCard
import 'package:sunnova_app/features/course/presentation/pages/lesson_content_page.dart'; // Import LessonContentPage

class CourseDetailPage extends StatefulWidget {
  final String courseModuleId; // ID of the course module to display

  const CourseDetailPage({super.key, required this.courseModuleId});

  @override
  State<CourseDetailPage> createState() => _CourseDetailPageState();
}

class _CourseDetailPageState extends State<CourseDetailPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final courseNotifier = Provider.of<CourseNotifier>(
        context,
        listen: false,
      );
      courseNotifier.fetchCourseDetail(widget.courseModuleId);
      courseNotifier.fetchLessonUnits(widget.courseModuleId);
      // Assuming a user ID is available globally or passed
      courseNotifier.fetchUserProgress(
        'current_user_id',
        widget.courseModuleId,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Course Detail',
          style: Theme.of(context).textTheme.titleLarge, // Use theme typography
        ),
      ),
      body: Consumer<CourseNotifier>(
        builder: (context, courseNotifier, child) {
          if (courseNotifier.state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (courseNotifier.state.errorMessage != null) {
            return Center(
              child: Text('Error: ${courseNotifier.state.errorMessage}'),
            );
          }

          final courseModule = courseNotifier.state.selectedModule;
          if (courseModule == null) {
            return const Center(child: Text('Course module not found.'));
          }

          // Calculate progress
          final int completedLessons = courseNotifier.state.units
              .where(
                (unit) =>
                    courseNotifier.state.progressMap[unit.id]?.isCompleted ==
                    true,
              )
              .length;
          final int totalLessons = courseNotifier.state.units.length;

          return Stack(
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header with icon, title, description
                    Row(
                      children: [
                        Icon(
                          Icons.book, // Placeholder icon
                          size: 60,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                courseModule.title,
                                style: Theme.of(
                                  context,
                                ).textTheme.headlineSmall,
                              ),
                              Text(
                                courseModule.description,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    // Progress overview
                    Text(
                      '$completedLessons/$totalLessons Lessons Completed',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 16),
                    // List of LessonUnitCard
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: courseNotifier.state.units.length,
                      itemBuilder: (context, index) {
                        final lessonUnit = courseNotifier.state.units[index];
                        final isCompleted =
                            courseNotifier
                                .state
                                .progressMap[lessonUnit.id]
                                ?.isCompleted ??
                            false;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: LessonUnitCard(
                            lessonUnit: lessonUnit,
                            isCompleted: isCompleted,
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => LessonContentPage(
                                    lessonId: lessonUnit.id,
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              // FAB for "Start Learning"
              Positioned(
                bottom: 16,
                right: 16,
                child: FloatingActionButton.extended(
                  onPressed: () {
                    // Find the first incomplete lesson
                    final firstIncompleteLesson = courseNotifier.state.units
                        .firstWhere(
                          (unit) =>
                              !(courseNotifier
                                      .state
                                      .progressMap[unit.id]
                                      ?.isCompleted ??
                                  false),
                          orElse: () => courseNotifier
                              .state
                              .units
                              .first, // If all completed, go to first
                        );
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => LessonContentPage(
                          lessonId: firstIncompleteLesson.id,
                        ),
                      ),
                    );
                  },
                  label: Text(
                    'Start Learning',
                    style: Theme.of(
                      context,
                    ).textTheme.labelLarge?.copyWith(color: Colors.white),
                  ),
                  icon: const Icon(Icons.play_arrow, color: Colors.white),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      16,
                    ), // Use radiusLarge from theme
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
