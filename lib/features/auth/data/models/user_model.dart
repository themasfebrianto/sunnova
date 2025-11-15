import 'package:sunnova_app/features/auth/domain/entities/user_profile_entity.dart';

class UserModel extends UserProfileEntity {
  final String? password; // Only for local storage, not part of entity

  const UserModel({
    required super.uid,
    required super.email,
    super.displayName,
    super.photoURL,
    super.gender,
    super.fcmToken,
    required super.isPremium,
    required super.createdAt,
    super.lastLoginAt,
    this.password,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] as String,
      email: map['email'] as String,
      displayName: map['displayName'] as String?,
      photoURL: map['photoURL'] as String?,
      gender: map['gender'] as String?,
      fcmToken: map['fcmToken'] as String?,
      isPremium: map['isPremium'] == 1,
      createdAt: DateTime.parse(map['createdAt'] as String),
      lastLoginAt: map['lastLoginAt'] != null
          ? DateTime.parse(map['lastLoginAt'] as String)
          : null,
      password: map['password'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'photoURL': photoURL,
      'gender': gender,
      'fcmToken': fcmToken,
      'isPremium': isPremium ? 1 : 0,
      'createdAt': createdAt.toIso8601String(),
      'lastLoginAt': lastLoginAt?.toIso8601String(),
      'password': password,
    };
  }

  // Factory method to create a UserModel from a UserProfileEntity
  factory UserModel.fromEntity(UserProfileEntity entity) {
    return UserModel(
      uid: entity.uid,
      email: entity.email,
      displayName: entity.displayName,
      photoURL: entity.photoURL,
      gender: entity.gender,
      fcmToken: entity.fcmToken,
      isPremium: entity.isPremium,
      createdAt: entity.createdAt,
      lastLoginAt: entity.lastLoginAt,
      // Password is not part of the entity, so it's not included here
    );
  }
}