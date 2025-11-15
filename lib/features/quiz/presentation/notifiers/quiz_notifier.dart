import 'package:flutter/material.dart';
import 'package:sunnova_app/features/quiz/domain/entities/assessment_question_entity.dart';
import 'package:sunnova_app/features/quiz/domain/entities/user_answer_log_entity.dart';
import 'package:sunnova_app/features/quiz/domain/usecases/get_quiz_questions.dart';
import 'package:sunnova_app/features/quiz/domain/usecases/submit_quiz_answers.dart';

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

  QuizState copyWith({
    List<AssessmentQuestionEntity>? questions,
    int? currentQuestionIndex,
    Map<int, int>? userAnswers,
    bool? isSubmitted,
    int? correctCount,
    int? totalXpEarned,
    bool? isLoading,
    String? errorMessage,
  }) {
    return QuizState(
      questions: questions ?? this.questions,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      userAnswers: userAnswers ?? this.userAnswers,
      isSubmitted: isSubmitted ?? this.isSubmitted,
      correctCount: correctCount ?? this.correctCount,
      totalXpEarned: totalXpEarned ?? this.totalXpEarned,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  factory QuizState.initial() => QuizState();
  QuizState loading() => QuizState(isLoading: true);
  QuizState loaded({
    List<AssessmentQuestionEntity>? questions,
    int? currentQuestionIndex,
    Map<int, int>? userAnswers,
    bool? isSubmitted,
    int? correctCount,
    int? totalXpEarned,
  }) =>
      QuizState(
        questions: questions ?? this.questions,
        currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
        userAnswers: userAnswers ?? this.userAnswers,
        isSubmitted: isSubmitted ?? this.isSubmitted,
        correctCount: correctCount ?? this.correctCount,
        totalXpEarned: totalXpEarned ?? this.totalXpEarned,
        isLoading: false,
      );
  QuizState error(String message) => QuizState(errorMessage: message, isLoading: false);
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

  Future<void> fetchQuizQuestions(String lessonId) async {
    _state = _state.loading();
    notifyListeners();

    final result = await getQuizQuestions(GetQuizQuestionsParams(lessonId: lessonId));

    result.fold(
      (failure) {
        _state = _state.error(failure.message ?? 'Failed to fetch quiz questions');
        notifyListeners();
      },
      (questions) {
        _state = _state.loaded(questions: questions);
        notifyListeners();
      },
    );
  }

  void selectAnswer(int questionIndex, int optionIndex) {
    if (_state.isSubmitted) return; // Cannot change answers after submission
    final updatedAnswers = Map<int, int>.from(_state.userAnswers);
    updatedAnswers[questionIndex] = optionIndex;
    _state = _state.copyWith(userAnswers: updatedAnswers);
    notifyListeners();
  }

  Future<void> submitQuiz(String userId, String lessonId) async {
    _state = _state.copyWith(isLoading: true);
    notifyListeners();

    int correctCount = 0;
    final List<UserAnswerLogEntity> userAnswerLogs = [];

    for (int i = 0; i < _state.questions.length; i++) {
      final question = _state.questions[i];
      final selectedOptionIndex = _state.userAnswers[i];
      final isCorrect = (selectedOptionIndex != null &&
          selectedOptionIndex == question.correctAnswerIndex);

      if (isCorrect) {
        correctCount++;
      }

      userAnswerLogs.add(
        UserAnswerLogEntity(
          id: 'log_${DateTime.now().millisecondsSinceEpoch}_$i', // Unique ID for log
          userId: userId,
          lessonId: lessonId,
          questionId: question.id,
          selectedAnswerIndex: selectedOptionIndex,
          isCorrect: isCorrect,
          isHintUsed: false, // Assuming no hint used for now
          attemptedAt: DateTime.now(),
          xpEarned: isCorrect ? 10 : 0, // 10 XP per correct answer
        ),
      );
    }

    final totalXpEarned = correctCount * 10; // Example: 10 XP per correct answer

    final result = await submitQuizAnswers(
      SubmitQuizAnswersParams(
        userId: userId,
        lessonId: lessonId,
        answers: userAnswerLogs,
      ),
    );

    result.fold(
      (failure) {
        _state = _state.error(failure.message ?? 'Failed to submit quiz');
        notifyListeners();
      },
      (_) {
        _state = _state.copyWith(
          isSubmitted: true,
          correctCount: correctCount,
          totalXpEarned: totalXpEarned,
          isLoading: false,
        );
        notifyListeners();
      },
    );
  }

  void goToNextQuestion() {
    if (_state.currentQuestionIndex < _state.questions.length - 1) {
      _state = _state.copyWith(currentQuestionIndex: _state.currentQuestionIndex + 1);
      notifyListeners();
    }
  }

  void goToPreviousQuestion() {
    if (_state.currentQuestionIndex > 0) {
      _state = _state.copyWith(currentQuestionIndex: _state.currentQuestionIndex - 1);
      notifyListeners();
    }
  }
}