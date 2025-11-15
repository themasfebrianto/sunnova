import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunnova_app/features/course/presentation/notifiers/course_notifier.dart';
import 'package:sunnova_app/features/course/presentation/pages/lesson_list_page.dart';
import 'package:sunnova_app/features/course/presentation/widgets/lesson_unit_card.dart';

class CourseDetailPage extends StatefulWidget {
  final String moduleId;

  const CourseDetailPage({super.key, required this.moduleId});

  @override
  State<CourseDetailPage> createState() => _CourseDetailPageState();
}

class _CourseDetailPageState extends State<CourseDetailPage> {
  @override
  void initState() {
    super.initState();
    // Assuming a user is logged in and we have their ID
    // Replace 'current_user_id' with actual user ID from AuthNotifier or similar
    Provider.of<CourseNotifier>(context, listen: false)
        .loadCourseDetail(widget.moduleId);
    Provider.of<CourseNotifier>(context, listen: false)
        .loadLessonUnits(widget.moduleId, 'current_user_id');
    Provider.of<CourseNotifier>(context, listen: false)
        .loadUserProgress('current_user_id', widget.moduleId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Course Detail'),
      ),
      body: Consumer<CourseNotifier>(
        builder: (context, courseNotifier, child) {
          if (courseNotifier.state.isLoading &&
              courseNotifier.state.selectedModule == null) {
            return const Center(child: CircularProgressIndicator());
          }

          if (courseNotifier.state.errorMessage != null) {
            return Center(
                child: Text('Error: ${courseNotifier.state.errorMessage}'));
          }

          final module = courseNotifier.state.selectedModule;
          if (module == null) {
            return const Center(child: Text('Course module not found.'));
          }

          final completedLessons = courseNotifier.state.progressMap.values
              .where((progress) => progress.isCompleted)
              .length;
          final totalLessons = courseNotifier.state.units.length;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  module.title,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 10),
                Text(
                  module.description,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 20),
                Text(
                  '$completedLessons/$totalLessons Lessons Completed',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 20),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: courseNotifier.state.units.length,
                  itemBuilder: (context, index) {
                    final lesson = courseNotifier.state.units[index];
                    final progress =
                        courseNotifier.state.progressMap[lesson.id];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: LessonUnitCard(
                        lesson: lesson,
                        isCompleted: progress?.isCompleted ?? false,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => LessonListPage(
                                lessonId: lesson.id,
                                moduleId: widget.moduleId,
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
          );
        },
      ),
      floatingActionButton: Consumer<CourseNotifier>(
        builder: (context, courseNotifier, child) {
          if (courseNotifier.state.isLoading ||
              courseNotifier.state.selectedModule == null ||
              courseNotifier.state.units.isEmpty) {
            return const SizedBox.shrink(); // Hide button if data is not ready
          }
          return FloatingActionButton.extended(
            onPressed: () {
              // Find the first uncompleted lesson and navigate to it
              final firstUncompletedLesson =
                  courseNotifier.state.units.firstWhere(
                (lesson) =>
                    !(courseNotifier.state.progressMap[lesson.id]?.isCompleted ??
                        false),
                orElse: () => courseNotifier.state.units.first, // Fallback to first lesson
              );
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => LessonListPage(
                    lessonId: firstUncompletedLesson.id,
                    moduleId: widget.moduleId,
                  ),
                ),
              );
            },
            label: const Text('Start Learning'),
            icon: const Icon(Icons.play_arrow),
          );
        },
      ),
    );
  }
}