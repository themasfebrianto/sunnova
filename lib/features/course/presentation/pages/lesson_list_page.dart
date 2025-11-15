import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunnova_app/features/course/presentation/notifiers/course_notifier.dart';
import 'package:sunnova_app/features/course/presentation/pages/lesson_content_page.dart';
import 'package:sunnova_app/features/course/presentation/widgets/lesson_unit_card.dart';

class LessonListPage extends StatefulWidget {
  final String moduleId;
  final String lessonId; // The lesson to start with

  const LessonListPage({super.key, required this.moduleId, required this.lessonId});

  @override
  State<LessonListPage> createState() => _LessonListPageState();
}

class _LessonListPageState extends State<LessonListPage> {
  @override
  void initState() {
    super.initState();
    // Ensure course details and lesson units are loaded
    Provider.of<CourseNotifier>(context, listen: false).loadCourseDetail(widget.moduleId);
    Provider.of<CourseNotifier>(context, listen: false).loadLessonUnits(widget.moduleId, 'current_user_id');
    Provider.of<CourseNotifier>(context, listen: false).loadUserProgress('current_user_id', widget.moduleId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lessons'),
      ),
      body: Consumer<CourseNotifier>(
        builder: (context, courseNotifier, child) {
          if (courseNotifier.state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (courseNotifier.state.errorMessage != null) {
            return Center(child: Text('Error: ${courseNotifier.state.errorMessage}'));
          }

          if (courseNotifier.state.units.isEmpty) {
            return const Center(child: Text('No lessons found for this module.'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: courseNotifier.state.units.length,
            itemBuilder: (context, index) {
              final lesson = courseNotifier.state.units[index];
              final progress = courseNotifier.state.progressMap[lesson.id];
              return Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: LessonUnitCard(
                  lesson: lesson,
                  isCompleted: progress?.isCompleted ?? false,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => LessonContentPage(
                          lessonId: lesson.id,
                          moduleId: widget.moduleId,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}