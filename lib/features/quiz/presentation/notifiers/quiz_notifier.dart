import 'package:flutter/material.dart';
import 'package:sunnova_app/features/quiz/domain/entities/assessment_question_entity.dart'; // Import AssessmentQuestionEntity

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
  QuizState _state = QuizState.initial();
  QuizState get state => _state;

  // Placeholder methods
  Future<void> fetchQuizQuestions(String lessonId) async {
    _state = _state.loading();
    notifyListeners();
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));
    _state = _state.loaded(
      questions: [
        AssessmentQuestionEntity(
          id: 'q1',
          lessonId: lessonId,
          questionText: 'What is the first letter of the Arabic alphabet?',
          options: ['Alif', 'Ba', 'Ta', 'Tha'],
          correctOptionIndex: 0,
          explanation: 'Alif is the first letter.',
        ),
        AssessmentQuestionEntity(
          id: 'q2',
          lessonId: lessonId,
          questionText: 'Which of these is a heavy letter?',
          options: ['Ta', 'Dal', 'Sad', 'Kaf'],
          correctOptionIndex: 2,
          explanation: 'Sad is a heavy letter.',
        ),
        AssessmentQuestionEntity(
          id: 'q3',
          lessonId: lessonId,
          questionText: 'How many harakat is a Fatha?',
          options: ['One', 'Two', 'Three', 'Four'],
          correctOptionIndex: 0,
          explanation: 'A Fatha is one harakah.',
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

  Future<void> submitQuiz(String userId, String lessonId) async {
    _state = _state.loading();
    notifyListeners();

    int correct = 0;
    for (int i = 0; i < _state.questions.length; i++) {
      if (_state.userAnswers[i] == _state.questions[i].correctOptionIndex) {
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
