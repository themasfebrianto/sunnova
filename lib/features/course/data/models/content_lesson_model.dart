import 'package:sunnova_app/features/course/domain/entities/content_lesson_entity.dart'; // Assuming ContentLessonEntity exists

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

  factory ContentLessonModel.fromJson(Map<String, dynamic> json) {
    return ContentLessonModel(
      id: json['id'] as String,
      unitId: json['unitId'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      videoUrl: json['videoUrl'] as String?,
      audioUrl: json['audioUrl'] as String?,
      ordering: json['ordering'] as int,
      requiredTimeInSeconds: json['requiredTimeInSeconds'] as int,
      xpReward: json['xpReward'] as int,
    );
  }

  Map<String, dynamic> toJson() {
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
}
