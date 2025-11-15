import 'package:flutter/material.dart';
import 'package:sunnova_app/features/quiz/domain/entities/assessment_question_entity.dart'; // Import AssessmentQuestionEntity
import 'package:sunnova_app/features/quiz/domain/usecases/get_quiz_questions.dart';
import 'package:sunnova_app/features/quiz/domain/usecases/submit_quiz_answers.dart';

// Define QuizState
class QuizState {
  final List<AssessmentQuestionEntity> questions;
  final int currentQuestionIndex;
  final Map<int, int> userAnswers; // questionIndex -> selectedOptionIndex
  final bool isSubmitted;
  final int correctCount;
  final int totalXpEarned;
  final bool isLoading;
  final String? errorMessage;

  QuizState({
    this.questions = const [],
    this.currentQuestionIndex = 0,
    this.userAnswers = const {},
    this.isSubmitted = false,
    this.correctCount = 0,
    this.totalXpEarned = 0,
    this.isLoading = false,
    this.errorMessage,
  });

  // Initial state
  factory QuizState.initial() => QuizState();

  // Loading state
  QuizState loading() => QuizState(isLoading: true);

  // Loaded state
  QuizState loaded({
    List<AssessmentQuestionEntity>? questions,
    int? currentQuestionIndex,
    Map<int, int>? userAnswers,
    bool? isSubmitted,
    int? correctCount,
    int? totalXpEarned,
  }) => QuizState(
    questions: questions ?? this.questions,
    currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
    userAnswers: userAnswers ?? this.userAnswers,
    isSubmitted: isSubmitted ?? this.isSubmitted,
    correctCount: correctCount ?? this.correctCount,
    totalXpEarned: totalXpEarned ?? this.totalXpEarned,
    isLoading: false,
  );

  // Error state
  QuizState error(String message) =>
      QuizState(errorMessage: message, isLoading: false);
}

class QuizNotifier extends ChangeNotifier {
  final GetQuizQuestions getQuizQuestions;
  final SubmitQuizAnswers submitQuizAnswers;

  QuizNotifier({
    required this.getQuizQuestions,
    required this.submitQuizAnswers,
  });

  QuizState _state = QuizState.initial();
  QuizState get state => _state;

  // Placeholder methods
  Future<void> loadQuizQuestions(String lessonId) async {
    _state = _state.loading();
    notifyListeners();
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));
    _state = _state.loaded(
      questions: [
        AssessmentQuestionEntity(
          id: 'q1',
          lessonId: lessonId,
          question: 'What is the first letter of the Arabic alphabet?',
          options: const ['Alif', 'Ba', 'Ta', 'Tha'],
          correctAnswerIndex: 0,
          explanation: 'Alif is the first letter.',
          difficultyLevel: 1,
          ordering: 1,
        ),
        AssessmentQuestionEntity(
          id: 'q2',
          lessonId: lessonId,
          question: 'Which of these is a heavy letter?',
          options: const ['Ta', 'Dal', 'Sad', 'Kaf'],
          correctAnswerIndex: 2,
          explanation: 'Sad is a heavy letter.',
          difficultyLevel: 2,
          ordering: 2,
        ),
        AssessmentQuestionEntity(
          id: 'q3',
          lessonId: lessonId,
          question: 'How many harakat is a Fatha?',
          options: const ['One', 'Two', 'Three', 'Four'],
          correctAnswerIndex: 0,
          explanation: 'A Fatha is one harakah.',
          difficultyLevel: 1,
          ordering: 3,
        ),
      ],
    );
    notifyListeners();
  }

  void selectAnswer(int questionIndex, int optionIndex) {
    final updatedAnswers = Map<int, int>.from(_state.userAnswers);
    updatedAnswers[questionIndex] = optionIndex;
    _state = _state.loaded(userAnswers: updatedAnswers);
    notifyListeners();
  }

  void goToNextQuestion() {
    if (_state.currentQuestionIndex < _state.questions.length - 1) {
      _state = _state.loaded(
        currentQuestionIndex: _state.currentQuestionIndex + 1,
      );
      notifyListeners();
    }
  }

  void goToPreviousQuestion() {
    if (_state.currentQuestionIndex > 0) {
      _state = _state.loaded(
        currentQuestionIndex: _state.currentQuestionIndex - 1,
      );
      notifyListeners();
    }
  }

  Future<void> performSubmitQuiz(String userId, String lessonId) async {
    _state = _state.loading();
    notifyListeners();

    int correct = 0;
    for (int i = 0; i < _state.questions.length; i++) {
      if (_state.userAnswers[i] == _state.questions[i].correctAnswerIndex) {
        correct++;
      }
    }

    // Simulate XP calculation
    final int xpEarned = correct * 10; // 10 XP per correct answer

    _state = _state.loaded(
      isSubmitted: true,
      correctCount: correct,
      totalXpEarned: xpEarned,
    );
    notifyListeners();
    // In a real app, this would interact with a use case to update backend/DB
  }
}
