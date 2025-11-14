import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunnova_app/features/quiz/presentation/notifiers/quiz_notifier.dart'; // Import QuizNotifier
import 'package:sunnova_app/features/quiz/presentation/widgets/question_card.dart'; // Import QuestionCard
import 'package:sunnova_app/features/quiz/presentation/widgets/option_button.dart'; // Import OptionButton
import 'package:sunnova_app/features/quiz/presentation/widgets/progress_indicator.dart'; // Import ProgressIndicator
import 'package:sunnova_app/features/quiz/presentation/pages/quiz_result_page.dart'; // Import QuizResultPage

class QuizPage extends StatefulWidget {
  final String lessonId;

  const QuizPage({super.key, required this.lessonId});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final quizNotifier = Provider.of<QuizNotifier>(context, listen: false);
      quizNotifier.fetchQuizQuestions(widget.lessonId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer<QuizNotifier>(
          builder: (context, quizNotifier, child) {
            final currentQuestionIndex =
                quizNotifier.state.currentQuestionIndex;
            final totalQuestions = quizNotifier.state.questions.length;
            return Text(
              'Question ${currentQuestionIndex + 1}/$totalQuestions',
              style: Theme.of(context).textTheme.titleLarge,
            );
          },
        ),
      ),
      body: Consumer<QuizNotifier>(
        builder: (context, quizNotifier, child) {
          if (quizNotifier.state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (quizNotifier.state.errorMessage != null) {
            return Center(
              child: Text('Error: ${quizNotifier.state.errorMessage}'),
            );
          }

          final questions = quizNotifier.state.questions;
          if (questions.isEmpty) {
            return const Center(
              child: Text('No questions available for this lesson.'),
            );
          }

          final currentQuestionIndex = quizNotifier.state.currentQuestionIndex;
          final currentQuestion = questions[currentQuestionIndex];
          final selectedOptionIndex =
              quizNotifier.state.userAnswers[currentQuestionIndex];

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Progress Indicator
                QuizProgressIndicator(
                  currentQuestionIndex: currentQuestionIndex,
                  totalQuestions: questions.length,
                ),
                const SizedBox(height: 20),
                // Question Card
                QuestionCard(question: currentQuestion.questionText),
                const SizedBox(height: 20),
                // Options
                Expanded(
                  child: ListView.builder(
                    itemCount: currentQuestion.options.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: OptionButton(
                          optionText: currentQuestion.options[index],
                          isSelected: selectedOptionIndex == index,
                          onTap: () {
                            quizNotifier.selectAnswer(
                              currentQuestionIndex,
                              index,
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
                // Navigation Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (currentQuestionIndex > 0)
                      Expanded(
                        // Wrap with Expanded
                        child: ElevatedButton(
                          onPressed: quizNotifier.goToPreviousQuestion,
                          child: const Text('Previous'),
                        ),
                      ),
                    const SizedBox(width: 10), // Add some spacing
                    if (currentQuestionIndex < questions.length - 1)
                      Expanded(
                        // Wrap with Expanded
                        child: ElevatedButton(
                          onPressed: quizNotifier.goToNextQuestion,
                          child: const Text('Next'),
                        ),
                      )
                    else
                      Expanded(
                        // Wrap with Expanded
                        child: ElevatedButton(
                          onPressed: () {
                            quizNotifier.submitQuiz(
                              'current_user_id',
                              widget.lessonId,
                            );
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => QuizResultPage(
                                  correctCount: quizNotifier.state.correctCount,
                                  totalQuestions: questions.length,
                                  xpEarned: quizNotifier.state.totalXpEarned,
                                ),
                              ),
                            );
                          },
                          child: const Text('Submit Quiz'),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
