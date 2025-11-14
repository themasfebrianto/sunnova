import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String uid;
  final String? email;
  final String? displayName;
  final String? photoURL;
  final String? gender;
  final String? fcmToken;
  final bool isPremium;
  final DateTime createdAt;
  final DateTime? lastLoginAt;
  final String? password; // Added password field

  const UserEntity({
    required this.uid,
    this.email,
    this.displayName,
    this.photoURL,
    this.gender,
    this.fcmToken,
    required this.isPremium,
    required this.createdAt,
    this.lastLoginAt,
    this.password, // Added password to constructor
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
        password, // Added password to props
      ];
}
