import 'package:sunnova_app/features/quiz/domain/entities/user_answer_log_entity.dart';

class UserAnswerLogModel extends UserAnswerLogEntity {
  const UserAnswerLogModel({
    required super.id,
    required super.userId,
    required super.questionId,
    required super.selectedAnswerIndex,
    required super.isCorrect,
    required super.isHintUsed,
    required super.attemptedAt,
  });

  factory UserAnswerLogModel.fromJson(Map<String, dynamic> json) {
    return UserAnswerLogModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      questionId: json['questionId'] as String,
      selectedAnswerIndex: json['selectedAnswerIndex'] as int,
      isCorrect: json['isCorrect'] as bool,
      isHintUsed: json['isHintUsed'] as bool,
      attemptedAt: DateTime.parse(json['attemptedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'questionId': questionId,
      'selectedAnswerIndex': selectedAnswerIndex,
      'isCorrect': isCorrect,
      'isHintUsed': isHintUsed,
      'attemptedAt': attemptedAt.toIso8601String(),
    };
  }

  factory UserAnswerLogModel.fromMap(Map<String, dynamic> map) {
    return UserAnswerLogModel(
      id: map['id'] as String,
      userId: map['userId'] as String,
      questionId: map['questionId'] as String,
      selectedAnswerIndex: map['selectedAnswerIndex'] as int,
      isCorrect: (map['isCorrect'] as int) == 1,
      isHintUsed: (map['isHintUsed'] as int) == 1,
      attemptedAt: DateTime.parse(map['attemptedAt'] as String),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'questionId': questionId,
      'selectedAnswerIndex': selectedAnswerIndex,
      'isCorrect': isCorrect ? 1 : 0,
      'isHintUsed': isHintUsed ? 1 : 0,
      'attemptedAt': attemptedAt.toIso8601String(),
    };
  }
}
