import 'package:flutter/material.dart';

class QuizProgressIndicator extends StatelessWidget {
  final int currentQuestionIndex;
  final int totalQuestions;

  const QuizProgressIndicator({
    super.key,
    required this.currentQuestionIndex,
    required this.totalQuestions,
  });

  @override
  Widget build(BuildContext context) {
    final double progress = (currentQuestionIndex + 1) / totalQuestions;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Question ${currentQuestionIndex + 1} of $totalQuestions',
          style: Theme.of(context).textTheme.labelMedium,
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: progress,
          backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
          color: Theme.of(context).colorScheme.primary,
          minHeight: 8,
          borderRadius: BorderRadius.circular(4),
        ),
      ],
    );
  }
}
