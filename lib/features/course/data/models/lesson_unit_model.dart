import 'package:sunnova_app/features/course/domain/entities/lesson_unit_entity.dart';

class LessonUnitModel extends LessonUnitEntity {
  const LessonUnitModel({
    required super.id,
    required super.title,
    required super.description,
    required super.content,
    super.videoUrl,
    super.audioUrl,
    required super.durationMinutes,
  });

  factory LessonUnitModel.fromJson(Map<String, dynamic> json) {
    return LessonUnitModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      content: json['content'] as String,
      videoUrl: json['videoUrl'] as String?,
      audioUrl: json['audioUrl'] as String?,
      durationMinutes: json['durationMinutes'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'content': content,
      'videoUrl': videoUrl,
      'audioUrl': audioUrl,
      'durationMinutes': durationMinutes,
    };
  }

  factory LessonUnitModel.fromMap(Map<String, dynamic> map) {
    return LessonUnitModel(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      content: map['content'] as String,
      videoUrl: map['videoUrl'] as String?,
      audioUrl: map['audioUrl'] as String?,
      durationMinutes: map['durationMinutes'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'content': content,
      'videoUrl': videoUrl,
      'audioUrl': audioUrl,
      'durationMinutes': durationMinutes,
    };
  }
}
