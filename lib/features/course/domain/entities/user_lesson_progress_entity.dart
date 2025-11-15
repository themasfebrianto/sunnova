import 'package:equatable/equatable.dart';

class UserLessonProgressEntity extends Equatable {
  final String userId;
  final String lessonId;
  final bool isCompleted;
  final DateTime? completedAt;

  const UserLessonProgressEntity({
    required this.userId,
    required this.lessonId,
    required this.isCompleted,
    this.completedAt,
  });

  @override
  List<Object?> get props => [userId, lessonId, isCompleted, completedAt];
}
