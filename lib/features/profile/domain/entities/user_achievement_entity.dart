import 'package:equatable/equatable.dart';

class UserAchievementEntity extends Equatable {
  final String id;
  final String userId;
  final String badgeId;
  final String title;
  final String description;
  final bool isUnlocked;
  final DateTime? unlockedAt;
  final bool isNew;

  const UserAchievementEntity({
    required this.id,
    required this.userId,
    required this.badgeId,
    required this.title,
    required this.description,
    required this.isUnlocked,
    this.unlockedAt,
    required this.isNew,
  });

  @override
  List<Object?> get props => [id, userId, badgeId, title, description, isUnlocked, unlockedAt, isNew];
}