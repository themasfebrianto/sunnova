import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunnova_app/features/course/presentation/notifiers/lesson_notifier.dart';
import 'package:sunnova_app/features/quiz/presentation/pages/quiz_page.dart';

class LessonContentPage extends StatefulWidget {
  final String lessonId;
  final String moduleId;

  const LessonContentPage({
    super.key,
    required this.lessonId,
    required this.moduleId,
  });

  @override
  State<LessonContentPage> createState() => _LessonContentPageState();
}

class _LessonContentPageState extends State<LessonContentPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<LessonNotifier>(context, listen: false)
        .loadLessonContent(widget.lessonId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lesson Content'),
      ),
      body: Consumer<LessonNotifier>(
        builder: (context, lessonNotifier, child) {
          if (lessonNotifier.state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (lessonNotifier.state.errorMessage != null) {
            return Center(
                child: Text('Error: ${lessonNotifier.state.errorMessage}'));
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
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 10),
                Text(
                  lesson.description,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 20),
                Text(
                  lesson.content,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                // Add audio/video player if URLs are available
                if (lesson.videoUrl != null) ...[
                  const SizedBox(height: 20),
                  Text(
                    'Video Content:',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  // Placeholder for video player
                  Container(
                    height: 200,
                    color: Colors.black,
                    alignment: Alignment.center,
                    child: const Text(
                      'Video Player Placeholder',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
                if (lesson.audioUrl != null) ...[
                  const SizedBox(height: 20),
                  Text(
                    'Audio Content:',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  // Placeholder for audio player
                  Container(
                    height: 50,
                    color: Colors.grey[300],
                    alignment: Alignment.center,
                    child: const Text('Audio Player Placeholder'),
                  ),
                ],
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () async {
                    // Mark lesson as completed
                    await lessonNotifier.completeLesson(
                        'current_user_id', widget.lessonId);
                    if (!mounted) return;
                    // Navigate to quiz page
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => QuizPage(
                          lessonId: widget.lessonId,
                          moduleId: widget.moduleId,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                  ),
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