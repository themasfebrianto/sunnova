import 'package:equatable/equatable.dart';

class AssessmentQuestionEntity extends Equatable {
  final String id;
  final String lessonId;
  final String question;
  final List<String> options;
  final int correctAnswerIndex;
  final String explanation;
  final int difficultyLevel;
  final int ordering;

  const AssessmentQuestionEntity({
    required this.id,
    required this.lessonId,
    required this.question,
    required this.options,
    required this.correctAnswerIndex,
    required this.explanation,
    required this.difficultyLevel,
    required this.ordering,
  });

  @override
  List<Object?> get props => [
        id,
        lessonId,
        question,
        options,
        correctAnswerIndex,
        explanation,
        difficultyLevel,
        ordering,
      ];
}