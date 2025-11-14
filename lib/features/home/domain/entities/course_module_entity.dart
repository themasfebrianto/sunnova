import 'package:equatable/equatable.dart';

class CourseModuleEntity extends Equatable {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final int requiredXpToUnlock;
  final bool isLocked;
  final int totalLessons;
  final int completedLessons;

  const CourseModuleEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.requiredXpToUnlock,
    required this.isLocked,
    required this.totalLessons,
    required this.completedLessons,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        imageUrl,
        requiredXpToUnlock,
        isLocked,
        totalLessons,
        completedLessons,
      ];
}
