import 'package:flutter/material.dart';

class QuizResultPage extends StatefulWidget {
  // Changed to StatefulWidget for animation
  final int correctCount;
  final int totalQuestions;
  final int xpEarned;

  const QuizResultPage({
    super.key,
    required this.correctCount,
    required this.totalQuestions,
    required this.xpEarned,
  });

  @override
  State<QuizResultPage> createState() => _QuizResultPageState();
}

class _QuizResultPageState extends State<QuizResultPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  int _displayedXp = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2), // Animation duration
      vsync: this,
    );
    _animation =
        Tween<double>(
          begin: 0,
          end: widget.xpEarned.toDouble(),
        ).animate(_controller)..addListener(() {
          setState(() {
            _displayedXp = _animation.value.toInt();
          });
        });

    _controller.forward(); // Start the animation
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Quiz Result',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        automaticallyImplyLeading: false, // Disable back button
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.emoji_events, // Trophy icon
                size: 100,
                color: Theme.of(context).colorScheme.secondary,
              ),
              const SizedBox(height: 20),
              Text(
                'Quiz Completed!',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 10),
              Text(
                'You answered ${widget.correctCount} out of ${widget.totalQuestions} questions correctly.',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Text(
                '+$_displayedXp XP', // Animated XP
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  // Navigate back to CourseDetailPage
                  Navigator.of(context).popUntil(
                    (route) => route.isFirst,
                  ); // Pop all the way to home
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Back to Courses',
                  style: Theme.of(
                    context,
                  ).textTheme.labelLarge?.copyWith(color: Colors.white),
                ),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  // TODO: Implement "View Explanation" functionality
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('View Explanation not yet implemented.'),
                    ),
                  );
                },
                child: Text(
                  'View Explanation',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
