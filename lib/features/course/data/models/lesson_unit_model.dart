import 'package:sunnova_app/features/course/domain/entities/lesson_unit_entity.dart';

class LessonUnitModel extends LessonUnitEntity {
  const LessonUnitModel({
    required super.id,
    required super.moduleId,
    required super.order,
    required super.title,
    required super.description,
    required super.content,
    super.videoUrl,
    super.audioUrl,
    required super.durationMinutes,
  });

  factory LessonUnitModel.fromJson(Map<String, dynamic> json) {
    return LessonUnitModel(
      id: json['id'],
      moduleId: json['moduleId'],
      order: json['order'],
      title: json['title'],
      description: json['description'],
      content: json['content'],
      videoUrl: json['videoUrl'],
      audioUrl: json['audioUrl'],
      durationMinutes: json['durationMinutes'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'moduleId': moduleId,
      'order': order,
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
      id: map['id'],
      moduleId: map['moduleId'],
      order: map['order'],
      title: map['title'],
      description: map['description'],
      content: map['content'],
      videoUrl: map['videoUrl'],
      audioUrl: map['audioUrl'],
      durationMinutes: map['durationMinutes'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'moduleId': moduleId,
      'order': order,
      'title': title,
      'description': description,
      'content': content,
      'videoUrl': videoUrl,
      'audioUrl': audioUrl,
      'durationMinutes': durationMinutes,
    };
  }
}
