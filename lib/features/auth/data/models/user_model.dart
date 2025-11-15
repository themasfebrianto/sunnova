import 'package:sunnova_app/features/auth/domain/entities/user_entity.dart'; // Added missing import

class UserModel extends UserEntity {
  const UserModel({
    // Removed const
    required super.uid,
    super.email,
    super.displayName,
    super.photoURL,
    super.gender,
    super.fcmToken,
    required super.isPremium,
    required super.createdAt,
    super.lastLoginAt,
    super.password,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] as String,
      email: json['email'] as String?,
      displayName: json['displayName'] as String?,
      photoURL: json['photoURL'] as String?,
      gender: json['gender'] as String?,
      fcmToken: json['fcmToken'] as String?,
      isPremium: json['isPremium'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      lastLoginAt: json['lastLoginAt'] != null
          ? DateTime.parse(json['lastLoginAt'] as String)
          : null,
      password: json['password'] as String?, // Added password
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'photoURL': photoURL,
      'gender': gender,
      'fcmToken': fcmToken,
      'isPremium': isPremium,
      'createdAt': createdAt.toIso8601String(),
      'lastLoginAt': lastLoginAt?.toIso8601String(),
      'password': password, // Added password
    };
  }

  // Method to convert UserModel to a Map for database operations
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] as String,
      email: map['email'] as String?,
      displayName: map['displayName'] as String?,
      photoURL: map['photoURL'] as String?,
      gender: map['gender'] as String?,
      fcmToken: map['fcmToken'] as String?,
      isPremium: (map['isPremium'] as int) == 1,
      createdAt: DateTime.parse(map['createdAt'] as String),
      lastLoginAt: map['lastLoginAt'] != null
          ? DateTime.parse(map['lastLoginAt'] as String)
          : null,
      password: map['password'] as String?, // Added password
    );
  }

  // Method to convert UserModel to a Map for database operations
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
      'password': password, // Added password
    };
  }
}
