import 'package:equatable/equatable.dart';

class BadgeEntity extends Equatable {
  final String id;
  final String title;
  final String description;
  final String icon;
  final int targetValue;
  final int gemReward;

  const BadgeEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.targetValue,
    required this.gemReward,
  });

  @override
  List<Object?> get props => [id, title, description, icon, targetValue, gemReward];
}
