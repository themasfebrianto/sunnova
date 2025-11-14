import 'package:sqflite/sqflite.dart' hide DatabaseException;
import 'package:sunnova_app/core/db/database_helper.dart';
import 'package:sunnova_app/core/error/exceptions.dart' as core_exceptions; // Alias core exceptions
import 'package:sunnova_app/features/auth/data/models/user_model.dart';

abstract class AuthLocalDataSource {
  Future<UserModel> getUser(String uid);
  Future<void> saveUser(UserModel user);
  Future<void> deleteUser(String uid);
  Future<UserModel> loginUser(String email, String password);
  Future<void> registerUser(UserModel user);
  Future<void> logoutUser();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final DatabaseHelper databaseHelper;

  AuthLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<UserModel> getUser(String uid) async {
    final db = await databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'uid = ?',
      whereArgs: [uid],
    );
    if (maps.isNotEmpty) {
      return UserModel.fromMap(maps.first);
    } else {
      throw core_exceptions.DatabaseException(); // Use my custom DatabaseException
    }
  }

  @override
  Future<void> saveUser(UserModel user) async {
    final db = await databaseHelper.database;
    await db.insert(
      'users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> deleteUser(String uid) async {
    final db = await databaseHelper.database;
    await db.delete(
      'users',
      where: 'uid = ?',
      whereArgs: [uid],
    );
  }

  @override
  Future<UserModel> loginUser(String email, String password) async {
    final db = await databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'email = ? AND password = ?', // In a real app, password should be hashed
      whereArgs: [email, password],
    );
    if (maps.isNotEmpty) {
      return UserModel.fromMap(maps.first);
    } else {
      throw core_exceptions.DatabaseException(); // Use my custom DatabaseException
    }
  }

  @override
  Future<void> registerUser(UserModel user) async {
    final db = await databaseHelper.database;
    await db.insert(
      'users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.abort, // Abort if user with same uid/email exists
    );
  }

  @override
  Future<void> logoutUser() async {
    // For local data source, logout might mean clearing current user session or data
    // For now, it's a no-op or could clear SharedPreferences
  }
}
