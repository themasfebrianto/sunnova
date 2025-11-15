import 'package:sunnova_app/features/course/domain/entities/content_lesson_entity.dart';

class ContentLessonModel extends ContentLessonEntity {
  const ContentLessonModel({
    required super.id,
    required super.unitId,
    required super.title,
    required super.content,
    super.videoUrl,
    super.audioUrl,
    required super.ordering,
    required super.requiredTimeInSeconds,
    required super.xpReward,
  });

  factory ContentLessonModel.fromMap(Map<String, dynamic> map) {
    return ContentLessonModel(
      id: map['id'] as String,
      unitId: map['unitId'] as String,
      title: map['title'] as String,
      content: map['content'] as String,
      videoUrl: map['videoUrl'] as String?,
      audioUrl: map['audioUrl'] as String?,
      ordering: map['ordering'] as int,
      requiredTimeInSeconds: map['requiredTimeInSeconds'] as int,
      xpReward: map['xpReward'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'unitId': unitId,
      'title': title,
      'content': content,
      'videoUrl': videoUrl,
      'audioUrl': audioUrl,
      'ordering': ordering,
      'requiredTimeInSeconds': requiredTimeInSeconds,
      'xpReward': xpReward,
    };
  }

  factory ContentLessonModel.fromEntity(ContentLessonEntity entity) {
    return ContentLessonModel(
      id: entity.id,
      unitId: entity.unitId,
      title: entity.title,
      content: entity.content,
      videoUrl: entity.videoUrl,
      audioUrl: entity.audioUrl,
      ordering: entity.ordering,
      requiredTimeInSeconds: entity.requiredTimeInSeconds,
      xpReward: entity.xpReward,
    );
  }
}