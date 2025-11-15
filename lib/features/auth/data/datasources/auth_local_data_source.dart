import 'package:sunnova_app/core/error/exceptions.dart';
import 'package:sunnova_app/features/auth/data/models/user_model.dart';
import 'package:sunnova_app/core/db/database_helper.dart'; // Import DatabaseHelper

abstract class AuthLocalDataSource {
  Future<UserModel> registerUser(
      String name, String email, String password, String gender);
  Future<UserModel> loginUser(String email, String password);
  Future<void> logoutUser();
  Future<UserModel> getUserProfile(String uid);
  Future<void> saveUser(UserModel user);
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final DatabaseHelper databaseHelper;

  AuthLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<UserModel> registerUser(
      String name, String email, String password, String gender) async {
    try {
      // Simulate database operation
      final newUser = UserModel(
        uid: 'user_${DateTime.now().millisecondsSinceEpoch}',
        email: email,
        displayName: name,
        photoURL: null,
        gender: gender,
        fcmToken: null,
        isPremium: false,
        createdAt: DateTime.now(),
        lastLoginAt: DateTime.now(),
        password: password, // Store password for local authentication
      );
      await databaseHelper.insertUser(newUser.toMap());
      return newUser;
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<UserModel> loginUser(String email, String password) async {
    try {
      final userMap = await databaseHelper.getUserByEmail(email);
      if (userMap != null) {
        final user = UserModel.fromMap(userMap);
        if (user.password == password) {
          return user;
        }
      }
      throw DatabaseException('Invalid credentials');
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<void> logoutUser() async {
    // Simulate clearing session/token locally
    // In a real app, this might involve clearing SharedPreferences or a local token
    return Future.value();
  }

  @override
  Future<UserModel> getUserProfile(String uid) async {
    try {
      final userMap = await databaseHelper.getUser(uid);
      if (userMap != null) {
        return UserModel.fromMap(userMap);
      }
      throw DatabaseException('User not found');
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<void> saveUser(UserModel user) async {
    try {
      await databaseHelper.insertUser(user.toMap());
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }
}