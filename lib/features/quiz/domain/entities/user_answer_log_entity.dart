import 'package:equatable/equatable.dart';

class UserAnswerLogEntity extends Equatable {
  final String id;
  final String userId;
  final String questionId;
  final int selectedAnswerIndex;
  final bool isCorrect;
  final bool isHintUsed;
  final DateTime attemptedAt;

  const UserAnswerLogEntity({
    required this.id,
    required this.userId,
    required this.questionId,
    required this.selectedAnswerIndex,
    required this.isCorrect,
    required this.isHintUsed,
    required this.attemptedAt,
  });

  @override
  List<Object?> get props => [
        id,
        userId,
        questionId,
        selectedAnswerIndex,
        isCorrect,
        isHintUsed,
        attemptedAt,
      ];
}
