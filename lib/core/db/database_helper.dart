import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _db;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  // ------------------------------------------------------------
  // PUBLIC API
  // ------------------------------------------------------------
  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  // ------------------------------------------------------------
  // INIT
  // ------------------------------------------------------------
  Future<Database> _initDb() async {
    final path = join(await getDatabasesPath(), 'sunnova_new.db');

    return await openDatabase(
      path,
      version: 4,
      onConfigure: (db) async {
        await db.execute('PRAGMA foreign_keys = ON');
      },
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  // ------------------------------------------------------------
  // TABLE DEFINITIONS
  // ------------------------------------------------------------
  final Map<String, String> tables = {
    'users': '''
    uid TEXT PRIMARY KEY,
    email TEXT,
    displayName TEXT,
    photoURL TEXT,
    gender TEXT,
    fcmToken TEXT,
    isPremium INTEGER,
    createdAt TEXT,
    lastLoginAt TEXT,
    password TEXT
  ''',

    'badges': '''
    id TEXT PRIMARY KEY,
    title TEXT,
    description TEXT,
    icon TEXT,
    targetValue INTEGER,
    gemReward INTEGER,
    isUnlocked INTEGER
  ''',

    'course_modules': '''
    id TEXT PRIMARY KEY,
    title TEXT,
    description TEXT,
    imageUrl TEXT,
    requiredXpToUnlock INTEGER,
    isLocked INTEGER,
    totalLessons INTEGER,
    completedLessons INTEGER
  ''',

    'lesson_units': '''
    id TEXT PRIMARY KEY,
    moduleId TEXT REFERENCES course_modules(id) ON DELETE CASCADE,
    title TEXT,
    description TEXT,
    content TEXT,
    videoUrl TEXT,
    audioUrl TEXT,
    "order" INTEGER,
    xpReward INTEGER,
    isPremium INTEGER,
    durationMinutes INTEGER,
    createdAt TEXT,
    updatedAt TEXT
  ''',

    'assessment_questions': '''
    id TEXT PRIMARY KEY,
    lessonId TEXT,
    question TEXT,
    options TEXT,
    correctAnswerIndex INTEGER,
    explanation TEXT,
    difficultyLevel INTEGER,
    ordering INTEGER,
    createdAt TEXT,
    updatedAt TEXT
  ''',

    'user_achievements': '''
    id TEXT PRIMARY KEY,
    userId TEXT,
    badgeId TEXT,
    title TEXT,
    description TEXT,
    isUnlocked INTEGER,
    unlockedAt TEXT,
    isNew INTEGER
  ''',

    'user_game_stats': '''
    userId TEXT PRIMARY KEY,
    userName TEXT,
    xp INTEGER,
    currentXp INTEGER,
    xpToNextLevel INTEGER,
    totalXp INTEGER,
    level INTEGER,
    currentStreak INTEGER,
    longestStreak INTEGER,
    lessonsCompleted INTEGER,
    quizzesPassed INTEGER,
    lastLoginDate TEXT
  ''',

    'user_lesson_progress': '''
    userId TEXT,
    lessonId TEXT,
    isCompleted INTEGER,
    completedAt TEXT,
    PRIMARY KEY (userId, lessonId)
  ''',

    'user_answer_logs': '''
    id TEXT PRIMARY KEY,
    userId TEXT,
    questionId TEXT,
    selectedAnswerIndex INTEGER,
    isCorrect INTEGER,
    isHintUsed INTEGER,
    attemptedAt TEXT
  ''',
  };

  // ------------------------------------------------------------
  // ON CREATE
  // ------------------------------------------------------------
  Future<void> _onCreate(Database db, int version) async {
    for (var entry in tables.entries) {
      await db.execute('CREATE TABLE ${entry.key} (${entry.value})');
    }
  }

  // ------------------------------------------------------------
  // ON UPGRADE (EMPTY FOR NOW — CLEAN START)
  // ------------------------------------------------------------
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Keep empty until next version bump
  }

  // ------------------------------------------------------------
  // HELPER: Add column *only if needed* (kept for future migrations)
  // ------------------------------------------------------------
  Future<void> _ensureColumn(
    Database db,
    String table,
    String column,
    String type,
  ) async {
    final result = await db.rawQuery('PRAGMA table_info($table)');
    final exists = result.any((c) => c['name'] == column);

    if (!exists) {
      await db.execute('ALTER TABLE $table ADD COLUMN $column $type');
    }
  }

  // ========================================================================
  // =============================== CRUD ===================================
  // ========================================================================

  // ---------------------- USERS ----------------------
  Future<int> insertUser(Map<String, dynamic> user) async {
    Database db = await database;
    return await db.insert(
      'users',
      user,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Map<String, dynamic>?> getUser(String uid) async {
    Database db = await database;
    final maps = await db.query('users', where: 'uid = ?', whereArgs: [uid]);
    return maps.isNotEmpty ? maps.first : null;
  }

  Future<Map<String, dynamic>?> getUserByEmail(String email) async {
    Database db = await database;
    final maps = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );
    return maps.isNotEmpty ? maps.first : null;
  }

  Future<int> updateUser(Map<String, dynamic> user) async {
    Database db = await database;
    return await db.update(
      'users',
      user,
      where: 'uid = ?',
      whereArgs: [user['uid']],
    );
  }

  Future<int> deleteUser(String uid) async {
    Database db = await database;
    return await db.delete('users', where: 'uid = ?', whereArgs: [uid]);
  }

  // ---------------------- BADGES ----------------------
  Future<int> insertBadge(Map<String, dynamic> badge) async {
    Database db = await database;
    return await db.insert(
      'badges',
      badge,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getAllBadges() async {
    Database db = await database;
    return await db.query('badges');
  }

  // ---------------------- COURSE MODULES ----------------------
  Future<int> insertCourseModule(Map<String, dynamic> module) async {
    Database db = await database;
    return await db.insert(
      'course_modules',
      module,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Map<String, dynamic>?> getCourseModule(String moduleId) async {
    Database db = await database;
    final maps = await db.query(
      'course_modules',
      where: 'id = ?',
      whereArgs: [moduleId],
    );
    return maps.isNotEmpty ? maps.first : null;
  }

  Future<List<Map<String, dynamic>>> getAllCourseModules() async {
    Database db = await database;
    return await db.query('course_modules');
  }

  // ---------------------- LESSON UNITS ----------------------
  Future<int> insertLessonUnit(Map<String, dynamic> lesson) async {
    Database db = await database;
    return await db.insert(
      'lesson_units',
      lesson,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getLessonUnitsByModuleId(
    String moduleId,
  ) async {
    Database db = await database;
    return await db.query(
      'lesson_units',
      where: 'moduleId = ?',
      whereArgs: [moduleId],
      orderBy: '"order" ASC',
    );
  }

  Future<Map<String, dynamic>?> getLessonUnit(String lessonId) async {
    Database db = await database;
    final maps = await db.query(
      'lesson_units',
      where: 'id = ?',
      whereArgs: [lessonId],
    );
    return maps.isNotEmpty ? maps.first : null;
  }

  // ---------------------- ASSESSMENT QUESTIONS ----------------------
  Future<int> insertAssessmentQuestion(Map<String, dynamic> question) async {
    Database db = await database;
    return await db.insert(
      'assessment_questions',
      question,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getAssessmentQuestionsByLessonId(
    String lessonId,
  ) async {
    Database db = await database;
    return await db.query(
      'assessment_questions',
      where: 'lessonId = ?',
      whereArgs: [lessonId],
    );
  }

  // ---------------------- USER ACHIEVEMENTS ----------------------
  Future<int> insertUserAchievement(Map<String, dynamic> achievement) async {
    Database db = await database;
    return await db.insert(
      'user_achievements',
      achievement,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getUserAchievements(String userId) async {
    Database db = await database;
    return await db.query(
      'user_achievements',
      where: 'userId = ?',
      whereArgs: [userId],
    );
  }

  // ---------------------- USER GAME STATS ----------------------
  Future<int> insertUserGameStats(Map<String, dynamic> stats) async {
    Database db = await database;
    return await db.insert(
      'user_game_stats',
      stats,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Map<String, dynamic>?> getUserGameStats(String userId) async {
    Database db = await database;
    final maps = await db.query(
      'user_game_stats',
      where: 'userId = ?',
      whereArgs: [userId],
    );
    return maps.isNotEmpty ? maps.first : null;
  }

  Future<int> updateUserGameStats(Map<String, dynamic> stats) async {
    Database db = await database;
    return await db.update(
      'user_game_stats',
      stats,
      where: 'userId = ?',
      whereArgs: [stats['userId']],
    );
  }

  // ---------------------- USER LESSON PROGRESS ----------------------
  Future<int> insertUserLessonProgress(Map<String, dynamic> progress) async {
    Database db = await database;
    return await db.insert(
      'user_lesson_progress',
      progress,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> updateUserLessonProgress(Map<String, dynamic> progress) async {
    Database db = await database;
    return await db.update(
      'user_lesson_progress',
      progress,
      where: 'userId = ? AND lessonId = ?',
      whereArgs: [progress['userId'], progress['lessonId']],
    );
  }

  Future<Map<String, dynamic>?> getUserLessonProgress(
    String userId,
    String lessonId,
  ) async {
    Database db = await database;
    final maps = await db.query(
      'user_lesson_progress',
      where: 'userId = ? AND lessonId = ?',
      whereArgs: [userId, lessonId],
    );
    return maps.isNotEmpty ? maps.first : null;
  }

  // ---------------------- USER ANSWER LOGS ----------------------
  Future<int> insertUserAnswerLog(Map<String, dynamic> answerLog) async {
    Database db = await database;
    return await db.insert(
      'user_answer_logs',
      answerLog,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // ---------------------- LEADERBOARD ----------------------
  Future<List<Map<String, dynamic>>> getLeaderboardRanks() async {
    Database db = await database;
    return await db.rawQuery('''
      SELECT
        u.uid,
        u.displayName,
        u.photoURL,
        ugs.xp
      FROM users u
      JOIN user_game_stats ugs ON u.uid = ugs.userId
      ORDER BY ugs.xp DESC
    ''');
  }

  // ---------------------- CLEAR DATA (DEV ONLY) ----------------------
  Future<void> clearAllTables() async {
    Database db = await database;
    await db.delete('users');
    await db.delete('badges');
    await db.delete('course_modules');
    await db.delete('lesson_units');
    await db.delete('assessment_questions');
    await db.delete('user_achievements');
    await db.delete('user_game_stats');
    await db.delete('user_lesson_progress');
    await db.delete('user_answer_logs');
  }

  Future<void> _closeDb() async {
    if (_db != null) {
      try {
        await _db!.close();
      } catch (_) {}
      _db = null;
    }
  }

  /// Delete all databases that contain "sunnova" in their filename
  Future<void> deleteAllDatabases() async {
    await _closeDb();

    final dbDir = await getDatabasesPath();
    final dir = Directory(dbDir);

    if (!await dir.exists()) return;

    final files = dir.listSync();

    for (var file in files) {
      final name = basename(file.path).toLowerCase();
      if (name.contains('sunnova')) {
        try {
          await File(file.path).delete();
          if (kDebugMode) {
            print('Deleted DB file: ${file.path}');
          }
        } catch (e) {
          if (kDebugMode) {
            print('Failed to delete ${file.path}: $e');
          }
        }
      }
    }
  }
}
