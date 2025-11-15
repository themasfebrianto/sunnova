import 'package:equatable/equatable.dart';

class UserProfileEntity extends Equatable {
  final String uid;
  final String email;
  final String? displayName;
  final String? photoURL;
  final String? gender;
  final String? fcmToken;
  final bool isPremium;
  final DateTime createdAt;
  final DateTime? lastLoginAt;

  const UserProfileEntity({
    required this.uid,
    required this.email,
    this.displayName,
    this.photoURL,
    this.gender,
    this.fcmToken,
    required this.isPremium,
    required this.createdAt,
    this.lastLoginAt,
  });

  @override
  List<Object?> get props => [
        uid,
        email,
        displayName,
        photoURL,
        gender,
        fcmToken,
        isPremium,
        createdAt,
        lastLoginAt,
      ];
}
