import 'package:equatable/equatable.dart';

class AssessmentQuestionEntity extends Equatable {
  final String id;
  final String lessonId;
  final String questionText;
  final List<String> options;
  final int correctOptionIndex;
  final String explanation;

  const AssessmentQuestionEntity({
    required this.id,
    required this.lessonId,
    required this.questionText,
    required this.options,
    required this.correctOptionIndex,
    required this.explanation,
  });

  @override
  List<Object?> get props => [
    id,
    lessonId,
    questionText,
    options,
    correctOptionIndex,
    explanation,
  ];
}
