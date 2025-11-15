import 'package:flutter/material.dart';

class ProgressIndicator extends StatelessWidget {
  final int currentQuestionIndex;
  final int totalQuestions;

  const ProgressIndicator({
    super.key,
    required this.currentQuestionIndex,
    required this.totalQuestions,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LinearProgressIndicator(
          value: (currentQuestionIndex + 1) / totalQuestions,
          backgroundColor: Colors.grey[300],
          color: Colors.blueAccent,
          minHeight: 8,
          borderRadius: BorderRadius.circular(4),
        ),
        const SizedBox(height: 10),
        Text(
          'Question ${currentQuestionIndex + 1} of $totalQuestions',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    );
  }
}