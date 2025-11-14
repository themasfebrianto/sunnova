import 'package:equatable/equatable.dart';

class UserAchievementEntity extends Equatable {
  final String id;
  final String title;
  final String description;
  final String iconUrl;
  final DateTime unlockedAt;
  final bool isUnlocked;

  const UserAchievementEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.iconUrl,
    required this.unlockedAt,
    required this.isUnlocked,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    iconUrl,
    unlockedAt,
    isUnlocked,
  ];
}
