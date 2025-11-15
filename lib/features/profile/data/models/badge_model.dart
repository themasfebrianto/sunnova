import 'package:sunnova_app/features/profile/domain/entities/badge_entity.dart';

class BadgeModel extends BadgeEntity {
  const BadgeModel({
    required super.id,
    required super.title,
    required super.description,
    required super.icon,
    required super.targetValue,
    required super.gemReward,
    required super.isUnlocked,
  });

  factory BadgeModel.fromJson(Map<String, dynamic> json) {
    return BadgeModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      icon: json['icon'] as String,
      targetValue: json['targetValue'] as int,
      gemReward: json['gemReward'] as int,
      isUnlocked: json['isUnlocked'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'icon': icon,
      'targetValue': targetValue,
      'gemReward': gemReward,
      'isUnlocked': isUnlocked,
    };
  }

  factory BadgeModel.fromMap(Map<String, dynamic> map) {
    return BadgeModel(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      icon: map['icon'] as String,
      targetValue: map['targetValue'] as int,
      gemReward: map['gemReward'] as int,
      isUnlocked: (map['isUnlocked'] as int) == 1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'icon': icon,
      'targetValue': targetValue,
      'gemReward': gemReward,
      'isUnlocked': isUnlocked ? 1 : 0, // store as int
    };
  }
}
