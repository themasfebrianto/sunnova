import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunnova_app/features/quiz/presentation/notifiers/quiz_notifier.dart';

class QuizResultPage extends StatelessWidget {
  final String moduleId;
  final String lessonId;

  const QuizResultPage({
    super.key,
    required this.moduleId,
    required this.lessonId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Result'),
        automaticallyImplyLeading: false, // Disable back button
      ),
      body: Consumer<QuizNotifier>(
        builder: (context, quizNotifier, child) {
          if (!quizNotifier.state.isSubmitted) {
            return const Center(child: Text('Quiz not submitted yet.'));
          }

          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.emoji_events,
                    color: Colors.amber,
                    size: 100,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'You Scored:',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  Text(
                    '${quizNotifier.state.correctCount}/${quizNotifier.state.questions.length}',
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    '+${quizNotifier.state.totalXpEarned} XP',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () {
                      // Navigate back to CourseDetailPage
                      Navigator.of(context).popUntil(
                          (route) => route.settings.name == '/courseDetail');
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text('Back to Course'),
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () {
                      // Implement logic to show explanations
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Showing explanations (Not implemented)')),
                      );
                    },
                    child: const Text('View Explanations'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}