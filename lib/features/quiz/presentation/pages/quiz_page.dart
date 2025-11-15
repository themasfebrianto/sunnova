import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunnova_app/features/quiz/presentation/notifiers/quiz_notifier.dart';
import 'package:sunnova_app/features/quiz/presentation/pages/quiz_result_page.dart';
import 'package:sunnova_app/features/quiz/presentation/widgets/option_button.dart';
import 'package:sunnova_app/features/quiz/presentation/widgets/question_card.dart';
import 'package:sunnova_app/features/quiz/presentation/widgets/progress_indicator.dart'
    as quiz_progress_indicator; // Alias to avoid conflict

class QuizPage extends StatefulWidget {
  final String lessonId;
  final String moduleId;

  const QuizPage({super.key, required this.lessonId, required this.moduleId});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<QuizNotifier>(context, listen: false)
        .fetchQuizQuestions(widget.lessonId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz'),
      ),
      body: Consumer<QuizNotifier>(
        builder: (context, quizNotifier, child) {
          if (quizNotifier.state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (quizNotifier.state.errorMessage != null) {
            return Center(
                child: Text('Error: ${quizNotifier.state.errorMessage}'));
          }

          if (quizNotifier.state.questions.isEmpty) {
            return const Center(child: Text('No questions found for this quiz.'));
          }

          final currentQuestion =
              quizNotifier.state.questions[quizNotifier.state.currentQuestionIndex];
          final selectedOptionIndex =
              quizNotifier.state.userAnswers[quizNotifier.state.currentQuestionIndex];

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                quiz_progress_indicator.ProgressIndicator(
                  currentQuestionIndex: quizNotifier.state.currentQuestionIndex,
                  totalQuestions: quizNotifier.state.questions.length,
                ),
                const SizedBox(height: 20),
                QuestionCard(question: currentQuestion.question),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: currentQuestion.options.length,
                    itemBuilder: (context, index) {
                      return OptionButton(
                        optionText: currentQuestion.options[index],
                        isSelected: selectedOptionIndex == index,
                        onTap: () {
                          quizNotifier.selectAnswer(
                              quizNotifier.state.currentQuestionIndex, index);
                        },
                      );
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (quizNotifier.state.currentQuestionIndex > 0)
                      ElevatedButton(
                        onPressed: quizNotifier.goToPreviousQuestion,
                        child: const Text('Previous'),
                      ),
                    if (quizNotifier.state.currentQuestionIndex <
                        quizNotifier.state.questions.length - 1)
                      ElevatedButton(
                        onPressed: quizNotifier.goToNextQuestion,
                        child: const Text('Next'),
                      ),
                    if (quizNotifier.state.currentQuestionIndex ==
                        quizNotifier.state.questions.length - 1)
                      ElevatedButton(
                        onPressed: () async {
                          await quizNotifier.submitQuiz('current_user_id', widget.lessonId);
                          if (!mounted) return;
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (_) => QuizResultPage(
                                moduleId: widget.moduleId,
                                lessonId: widget.lessonId,
                              ),
                            ),
                          );
                        },
                        child: const Text('Submit Quiz'),
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