import 'package:equatable/equatable.dart';

class UserAnswerLogEntity extends Equatable {
  final String id;
  final String userId;
  final String lessonId;
  final String questionId;
  final int? selectedAnswerIndex;
  final bool isCorrect;
  final bool isHintUsed;
  final DateTime attemptedAt;
  final int xpEarned;

  const UserAnswerLogEntity({
    required this.id,
    required this.userId,
    required this.lessonId,
    required this.questionId,
    this.selectedAnswerIndex,
    required this.isCorrect,
    required this.isHintUsed,
    required this.attemptedAt,
    required this.xpEarned,
  });

  @override
  List<Object?> get props => [
        id,
        userId,
        lessonId,
        questionId,
        selectedAnswerIndex,
        isCorrect,
        isHintUsed,
        attemptedAt,
        xpEarned,
      ];
}