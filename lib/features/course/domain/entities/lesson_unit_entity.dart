import 'package:equatable/equatable.dart';

class LessonUnitEntity extends Equatable {
  final String id;
  final String moduleId;
  final int order;
  final String title;
  final String description;
  final String content; // Markdown or HTML content
  final String? videoUrl;
  final String? audioUrl;
  final int durationMinutes;

  const LessonUnitEntity({
    required this.id,
    required this.moduleId,
    required this.order,
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
    moduleId,
    order,
    title,
    description,
    content,
    videoUrl,
    audioUrl,
    durationMinutes,
  ];
}
