import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunnova_app/features/quiz/presentation/notifiers/quiz_notifier.dart';
import 'package:sunnova_app/features/quiz/presentation/widgets/question_card.dart';
import 'package:sunnova_app/features/quiz/presentation/widgets/option_button.dart';
import 'package:sunnova_app/features/quiz/presentation/widgets/progress_indicator.dart';
import 'package:sunnova_app/features/quiz/presentation/pages/quiz_result_page.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int _currentQuestionIndex = 0;
  final List<Map<String, dynamic>> _questions = [
    {
      'question': 'What is the capital of France?',
      'options': ['Berlin', 'Madrid', 'Paris', 'Rome'],
      'correctAnswerIndex': 2,
    },
    {
      'question': 'What is 2 + 2?',
      'options': ['3', '4', '5', '6'],
      'correctAnswerIndex': 1,
    },
    {
      'question': 'Which planet is known as the Red Planet?',
      'options': ['Earth', 'Mars', 'Jupiter', 'Venus'],
      'correctAnswerIndex': 1,
    },
  ];
  int? _selectedOptionIndex;

  void _nextQuestion() {
    setState(() {
      if (_currentQuestionIndex < _questions.length - 1) {
        _currentQuestionIndex++;
        _selectedOptionIndex = null; // Reset selection for new question
      }
    });
  }

  void _previousQuestion() {
    setState(() {
      if (_currentQuestionIndex > 0) {
        _currentQuestionIndex--;
        _selectedOptionIndex = null; // Reset selection for new question
      }
    });
  }

  void _submitQuiz() {
    // For now, just navigate to QuizResultPage
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const QuizResultPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    // final quizNotifier = Provider.of<QuizNotifier>(context); // Use if QuizNotifier had data

    return Scaffold(
      appBar: AppBar(
        title: CustomProgressIndicator(
          current: _currentQuestionIndex + 1,
          total: _questions.length,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            QuestionCard(question: _questions[_currentQuestionIndex]['question']),
            const SizedBox(height: 20),
            ...(_questions[_currentQuestionIndex]['options'] as List<String>)
                .asMap()
                .entries
                .map(
                  (entry) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: OptionButton(
                      text: entry.value,
                      onPressed: () {
                        setState(() {
                          _selectedOptionIndex = entry.key;
                        });
                      },
                    ),
                  ),
                )
                .toList(),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (_currentQuestionIndex > 0)
                  ElevatedButton(
                    onPressed: _previousQuestion,
                    child: const Text('Previous'),
                  ),
                if (_currentQuestionIndex < _questions.length - 1)
                  ElevatedButton(
                    onPressed: _nextQuestion,
                    child: const Text('Next'),
                  )
                else
                  ElevatedButton(
                    onPressed: _submitQuiz,
                    child: const Text('Submit Quiz'),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
