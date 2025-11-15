import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'sunnova_app.db');
    return await openDatabase(
      path,
      version: 4, // Increment version
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users(
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
      )
    ''');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < newVersion) {
      await db.execute('''
        CREATE TABLE badges(
          id TEXT PRIMARY KEY,
          title TEXT,
          description TEXT,
          icon TEXT,
          targetValue INTEGER,
          gemReward INTEGER
        )
      ''');
      await db.execute('''
        CREATE TABLE course_modules(
          id TEXT PRIMARY KEY,
          title TEXT,
          description TEXT,
          imageUrl TEXT,
          requiredXpToUnlock INTEGER,
          isLocked INTEGER,
          totalLessons INTEGER,
          completedLessons INTEGER
        )
      ''');
      await db.execute('''
        CREATE TABLE lesson_units(
          id TEXT PRIMARY KEY,
          moduleId TEXT,
          title TEXT,
          description TEXT,
          content TEXT,
          videoUrl TEXT,
          audioUrl TEXT,
          'order' INTEGER,
          xpReward INTEGER,
          isPremium INTEGER,
          createdAt TEXT,
          updatedAt TEXT
        )
      ''');
      await db.execute('''
        CREATE TABLE assessment_questions(
          id TEXT PRIMARY KEY,
          lessonId TEXT,
          questionText TEXT,
          options TEXT,
          correctOptionIndex INTEGER,
          explanation TEXT,
          difficultyLevel INTEGER,
          ordering INTEGER,
          createdAt TEXT,
          updatedAt TEXT
        )
      ''');
      await db.execute('''
        CREATE TABLE user_achievements(
          id TEXT PRIMARY KEY,
          userId TEXT,
          badgeId TEXT,
          unlockedAt TEXT,
          isNew INTEGER
        )
      ''');
      await db.execute('''
        CREATE TABLE user_game_stats(
          userId TEXT PRIMARY KEY,
          xp INTEGER,
          level INTEGER,
          currentStreak INTEGER,
          longestStreak INTEGER,
          lessonsCompleted INTEGER,
          quizzesPassed INTEGER,
          lastLoginDate TEXT
        )
      ''');
      await db.execute('''
        CREATE TABLE user_lesson_progress(
          userId TEXT,
          lessonId TEXT,
          isCompleted INTEGER,
          completedAt TEXT,
          PRIMARY KEY (userId, lessonId)
        )
      ''');
      await db.execute('''
        CREATE TABLE user_answer_logs(
          id TEXT PRIMARY KEY,
          userId TEXT,
          questionId TEXT,
          selectedAnswerIndex INTEGER,
          isCorrect INTEGER,
          isHintUsed INTEGER,
          attemptedAt TEXT
        )
      ''');
    }
  }

  // User CRUD operations
  Future<int> insertUser(Map<String, dynamic> user) async {
    Database db = await database;
    return await db.insert('users', user,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<Map<String, dynamic>?> getUser(String uid) async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'uid = ?',
      whereArgs: [uid],
    );
    if (maps.isNotEmpty) {
      return maps.first;
    }
    return null;
  }

  Future<Map<String, dynamic>?> getUserByEmail(String email) async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );
    if (maps.isNotEmpty) {
      return maps.first;
    }
    return null;
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
    return await db.delete(
      'users',
      where: 'uid = ?',
      whereArgs: [uid],
    );
  }

  // Badge CRUD operations
  Future<int> insertBadge(Map<String, dynamic> badge) async {
    Database db = await database;
    return await db.insert('badges', badge,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> getAllBadges() async {
    Database db = await database;
    return await db.query('badges');
  }

  // Course Module CRUD operations
  Future<int> insertCourseModule(Map<String, dynamic> module) async {
    Database db = await database;
    return await db.insert('course_modules', module,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<Map<String, dynamic>?> getCourseModule(String moduleId) async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query(
      'course_modules',
      where: 'id = ?',
      whereArgs: [moduleId],
    );
    if (maps.isNotEmpty) {
      return maps.first;
    }
    return null;
  }

  Future<List<Map<String, dynamic>>> getAllCourseModules() async {
    Database db = await database;
    return await db.query('course_modules');
  }

  // Lesson Unit CRUD operations
  Future<int> insertLessonUnit(Map<String, dynamic> lesson) async {
    Database db = await database;
    return await db.insert('lesson_units', lesson,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> getLessonUnitsByModuleId(
      String moduleId, String userId) async {
    Database db = await database;
    return await db.query(
      'lesson_units',
      where: 'moduleId = ?',
      whereArgs: [moduleId],
      orderBy: "'order' ASC",
    );
  }

  Future<Map<String, dynamic>?> getLessonUnit(String lessonId) async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query(
      'lesson_units',
      where: 'id = ?',
      whereArgs: [lessonId],
    );
    if (maps.isNotEmpty) {
      return maps.first;
    }
    return null;
  }

  // Assessment Question CRUD operations
  Future<int> insertAssessmentQuestion(Map<String, dynamic> question) async {
    Database db = await database;
    return await db.insert('assessment_questions', question,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> getAssessmentQuestionsByLessonId(
      String lessonId) async {
    Database db = await database;
    return await db.query(
      'assessment_questions',
      where: 'lessonId = ?',
      whereArgs: [lessonId],
    );
  }

  // User Achievement CRUD operations
  Future<int> insertUserAchievement(Map<String, dynamic> achievement) async {
    Database db = await database;
    return await db.insert('user_achievements', achievement,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> getUserAchievements(String userId) async {
    Database db = await database;
    return await db.query(
      'user_achievements',
      where: 'userId = ?',
      whereArgs: [userId],
    );
  }

  // User Game Stats CRUD operations
  Future<int> insertUserGameStats(Map<String, dynamic> stats) async {
    Database db = await database;
    return await db.insert('user_game_stats', stats,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<Map<String, dynamic>?> getUserGameStats(String userId) async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query(
      'user_game_stats',
      where: 'userId = ?',
      whereArgs: [userId],
    );
    if (maps.isNotEmpty) {
      return maps.first;
    }
    return null;
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

  // User Lesson Progress CRUD operations
  Future<int> insertUserLessonProgress(Map<String, dynamic> progress) async {
    Database db = await database;
    return await db.insert('user_lesson_progress', progress,
        conflictAlgorithm: ConflictAlgorithm.replace);
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
      String userId, String lessonId) async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query(
      'user_lesson_progress',
      where: 'userId = ? AND lessonId = ?',
      whereArgs: [userId, lessonId],
    );
    if (maps.isNotEmpty) {
      return maps.first;
    }
    return null;
  }

  // User Answer Log CRUD operations
  Future<int> insertUserAnswerLog(Map<String, dynamic> answerLog) async {
    Database db = await database;
    return await db.insert('user_answer_logs', answerLog,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // Leaderboard operations
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

}