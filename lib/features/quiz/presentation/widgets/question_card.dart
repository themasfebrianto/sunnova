import 'package:flutter/material.dart';

class QuestionCard extends StatelessWidget {
  final String question;

  const QuestionCard({
    Key? key,
    required this.question,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(question),
      ),
    );
  }
}
