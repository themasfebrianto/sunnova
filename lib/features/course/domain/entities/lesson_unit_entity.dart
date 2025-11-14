import 'package:equatable/equatable.dart';

class LessonUnitEntity extends Equatable {
  final String id;
  final String title;
  final String description;
  final String content; // Markdown or HTML content
  final String? videoUrl;
  final String? audioUrl;
  final int durationMinutes;

  const LessonUnitEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.content,
    this.videoUrl,
    this.audioUrl,
    required this.durationMinutes,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        content,
        videoUrl,
        audioUrl,
        durationMinutes,
      ];
}

class UserLessonProgressEntity extends Equatable {
  final String userId;
  final String lessonId;
  final bool isCompleted;
  final DateTime? completedAt;

  const UserLessonProgressEntity({
    required this.userId,
    required this.lessonId,
    this.isCompleted = false,
    this.completedAt,
  });

  @override
  List<Object?> get props => [
        userId,
        lessonId,
        isCompleted,
        completedAt,
      ];
}
