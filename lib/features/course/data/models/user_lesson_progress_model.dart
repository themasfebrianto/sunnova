import 'package:sunnova_app/features/course/domain/entities/user_lesson_progress_entity.dart';

class UserLessonProgressModel extends UserLessonProgressEntity {
  const UserLessonProgressModel({
    required super.userId,
    required super.lessonId,
    required super.isCompleted,
    super.completedAt,
  });

  factory UserLessonProgressModel.fromJson(Map<String, dynamic> json) {
    return UserLessonProgressModel(
      userId: json['userId'] as String,
      lessonId: json['lessonId'] as String,
      isCompleted: json['isCompleted'] as bool,
      completedAt: json['completedAt'] != null
          ? DateTime.parse(json['completedAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'lessonId': lessonId,
      'isCompleted': isCompleted,
      'completedAt': completedAt?.toIso8601String(),
    };
  }

  factory UserLessonProgressModel.fromMap(Map<String, dynamic> map) {
    return UserLessonProgressModel(
      userId: map['userId'] as String,
      lessonId: map['lessonId'] as String,
      isCompleted: (map['isCompleted'] as int) == 1,
      completedAt: map['completedAt'] != null
          ? DateTime.parse(map['completedAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'lessonId': lessonId,
      'isCompleted': isCompleted ? 1 : 0,
      'completedAt': completedAt?.toIso8601String(),
    };
  }
}
