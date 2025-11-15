import 'package:equatable/equatable.dart';

class ContentLessonEntity extends Equatable {
  final String id;
  final String unitId;
  final String title;
  final String content; // Markdown or HTML content
  final String? videoUrl;
  final String? audioUrl;
  final int ordering;
  final int requiredTimeInSeconds;
  final int xpReward;

  const ContentLessonEntity({
    required this.id,
    required this.unitId,
    required this.title,
    required this.content,
    this.videoUrl,
    this.audioUrl,
    required this.ordering,
    required this.requiredTimeInSeconds,
    required this.xpReward,
  });

  @override
  List<Object?> get props => [
        id,
        unitId,
        title,
        content,
        videoUrl,
        audioUrl,
        ordering,
        requiredTimeInSeconds,
        xpReward,
      ];
}
