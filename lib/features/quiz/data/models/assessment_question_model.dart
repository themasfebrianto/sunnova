import 'dart:convert';
import 'package:sunnova_app/features/quiz/domain/entities/assessment_question_entity.dart';

class AssessmentQuestionModel extends AssessmentQuestionEntity {
  const AssessmentQuestionModel({
    required super.id,
    required super.lessonId,
    required super.question,
    required super.options, // List<String>
    required super.correctAnswerIndex,
    required super.explanation,
    required super.difficultyLevel,
    required super.ordering,
  });

  // JSON serialization (app-level, not DB)
  factory AssessmentQuestionModel.fromJson(Map<String, dynamic> json) {
    return AssessmentQuestionModel(
      id: json['id'] as String,
      lessonId: json['lessonId'] as String,
      question: json['question'] as String,
      options: List<String>.from(json['options'] as List),
      correctAnswerIndex: json['correctAnswerIndex'] as int,
      explanation: json['explanation'] as String,
      difficultyLevel: json['difficultyLevel'] as int,
      ordering: json['ordering'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'lessonId': lessonId,
      'question': question,
      'options': options,
      'correctAnswerIndex': correctAnswerIndex,
      'explanation': explanation,
      'difficultyLevel': difficultyLevel,
      'ordering': ordering,
    };
  }

  // DB serialization
  factory AssessmentQuestionModel.fromMap(Map<String, dynamic> map) {
    return AssessmentQuestionModel(
      id: map['id'] as String,
      lessonId: map['lessonId'] as String,
      question: map['question'] as String,
      options: (jsonDecode(map['options'] as String) as List<dynamic>)
          .cast<String>(),
      correctAnswerIndex: map['correctAnswerIndex'] as int,
      explanation: map['explanation'] as String,
      difficultyLevel: map['difficultyLevel'] as int,
      ordering: map['ordering'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'lessonId': lessonId,
      'question': question,
      'options': jsonEncode(options), // encode List<String> to String
      'correctAnswerIndex': correctAnswerIndex,
      'explanation': explanation,
      'difficultyLevel': difficultyLevel,
      'ordering': ordering,
    };
  }
}
