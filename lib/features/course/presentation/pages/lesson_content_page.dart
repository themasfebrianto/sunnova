import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunnova_app/features/course/presentation/notifiers/lesson_notifier.dart'; // Import LessonNotifier
import 'package:sunnova_app/features/course/domain/entities/lesson_unit_entity.dart'; // Import LessonUnitEntity

class LessonContentPage extends StatefulWidget {
  final String lessonId;

  const LessonContentPage({super.key, required this.lessonId});

  @override
  State<LessonContentPage> createState() => _LessonContentPageState();
}

class _LessonContentPageState extends State<LessonContentPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final lessonNotifier = Provider.of<LessonNotifier>(context, listen: false);
      lessonNotifier.fetchLessonContent(widget.lessonId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lesson Content'), // Placeholder title
      ),
      body: Consumer<LessonNotifier>(
        builder: (context, lessonNotifier, child) {
          if (lessonNotifier.state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (lessonNotifier.state.errorMessage != null) {
            return Center(child: Text('Error: ${lessonNotifier.state.errorMessage}'));
          }

          final lesson = lessonNotifier.state.currentLesson;
          if (lesson == null) {
            return const Center(child: Text('Lesson content not found.'));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  lesson.title,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 16),
                Text(
                  lesson.description,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 24),
                // Placeholder for content viewer (e.g., Markdown or HTML renderer)
                Text(
                  lesson.content,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                // Add audio/video player if URLs exist
                if (lesson.videoUrl != null) ...[
                  const SizedBox(height: 24),
                  Text('Video Player Placeholder: ${lesson.videoUrl}'),
                ],
                if (lesson.audioUrl != null) ...[
                  const SizedBox(height: 24),
                  Text('Audio Player Placeholder: ${lesson.audioUrl}'),
                ],
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    // Mark lesson as completed and navigate to next lesson or quiz
                    lessonNotifier.markLessonAsCompleted('current_user_id', lesson.id);
                    // Example: Navigate to QuizPage or next lesson
                  },
                  child: const Text('Selesai & Lanjut Quiz'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}