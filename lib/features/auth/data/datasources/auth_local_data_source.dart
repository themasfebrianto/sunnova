import 'package:shared_preferences/shared_preferences.dart';
import 'package:sunnova_app/core/db/database_helper.dart';
import 'package:sunnova_app/core/error/exceptions.dart';
import 'package:sunnova_app/features/auth/data/models/user_model.dart';

abstract class AuthLocalDataSource {
  Future<UserModel> loginUser(String email, String password);
  Future<UserModel> registerUser(String email, String password, String displayName, String gender);
  Future<UserModel> getCurrentUser();
  Future<void> logoutUser();
  Future<void> cacheUser(UserModel user);
  Future<UserModel?> getCachedUser();
  Future<void> clearCachedUser();
}

const CACHED_USER = 'CACHED_USER';

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final DatabaseHelper databaseHelper;
  final SharedPreferences sharedPreferences;

  AuthLocalDataSourceImpl({required this.databaseHelper, required this.sharedPreferences});

  @override
  Future<UserModel> loginUser(String email, String password) async {
    final userMap = await databaseHelper.getUserByEmail(email);
    if (userMap != null) {
      final user = UserModel.fromMap(userMap);
      if (user.password == password) {
        await cacheUser(user);
        return user;
      }
    }
    throw AuthenticationException('Invalid credentials');
  }

  @override
  Future<UserModel> registerUser(String email, String password, String displayName, String gender) async {
    final existingUser = await databaseHelper.getUserByEmail(email);
    if (existingUser != null) {
      throw AuthenticationException('Email already registered');
    }

    final newUser = UserModel(
      uid: DateTime.now().millisecondsSinceEpoch.toString(), // Simple unique ID
      email: email,
      displayName: displayName,
      gender: gender,
      isPremium: false,
      createdAt: DateTime.now(),
      password: password,
    );
    await databaseHelper.insertUser(newUser.toMap());
    await cacheUser(newUser);
    return newUser;
  }

  @override
  Future<UserModel> getCurrentUser() async {
    final cachedUser = await getCachedUser();
    if (cachedUser != null) {
      return cachedUser;
    }
    throw CacheException('No cached user found');
  }

  @override
  Future<void> logoutUser() async {
    await clearCachedUser();
  }

  @override
  Future<void> cacheUser(UserModel user) async {
    await sharedPreferences.setString(CACHED_USER, user.uid);
  }

  @override
  Future<UserModel?> getCachedUser() async {
    final uid = sharedPreferences.getString(CACHED_USER);
    if (uid != null) {
      final userMap = await databaseHelper.getUser(uid);
      if (userMap != null) {
        return UserModel.fromMap(userMap);
      }
    }
    return null;
  }

  @override
  Future<void> clearCachedUser() async {
    await sharedPreferences.remove(CACHED_USER);
  }
}
