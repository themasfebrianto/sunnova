import 'package:equatable/equatable.dart';

class BadgeEntity extends Equatable {
  final String id;
  final String name;
  final String description;
  final String icon;
  final int targetValue;
  final int gemReward;
  final bool isUnlocked;

  const BadgeEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.targetValue,
    required this.gemReward,
    required this.isUnlocked,
  });

  @override
  List<Object?> get props => [id, name, description, icon, targetValue, gemReward, isUnlocked];
}
