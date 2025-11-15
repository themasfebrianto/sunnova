import 'package:sunnova_app/features/home/domain/entities/course_module_entity.dart';

class CourseModuleModel extends CourseModuleEntity {
  const CourseModuleModel({
    required super.id,
    required super.title,
    required super.description,
    required super.imageUrl,
    required super.requiredXpToUnlock,
    required super.isLocked,
    required super.totalLessons,
    required super.completedLessons,
  });

  factory CourseModuleModel.fromJson(Map<String, dynamic> json) {
    return CourseModuleModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
      requiredXpToUnlock: json['requiredXpToUnlock'] as int,
      isLocked: json['isLocked'] as bool,
      totalLessons: json['totalLessons'] as int,
      completedLessons: json['completedLessons'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'requiredXpToUnlock': requiredXpToUnlock,
      'isLocked': isLocked,
      'totalLessons': totalLessons,
      'completedLessons': completedLessons,
    };
  }

  factory CourseModuleModel.fromMap(Map<String, dynamic> map) {
    return CourseModuleModel(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      imageUrl: map['imageUrl'] as String,
      requiredXpToUnlock: map['requiredXpToUnlock'] as int,
      isLocked: (map['isLocked'] as int) == 1,
      totalLessons: map['totalLessons'] as int,
      completedLessons: map['completedLessons'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'requiredXpToUnlock': requiredXpToUnlock,
      'isLocked': isLocked ? 1 : 0,
      'totalLessons': totalLessons,
      'completedLessons': completedLessons,
    };
  }
}
