import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sunnova_app/features/auth/data/models/user_model.dart'; // Import UserModel

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    String path = join(await getDatabasesPath(), 'sunnova_app.db');
    return await openDatabase(
      path,
      version: 3, // Increment version again
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

    // Insert default user for testing
    final defaultUser = UserModel(
      uid: 'default_user_id',
      email: 'themas@email.com',
      displayName: 'Themas User',
      gender: 'male',
      isPremium: false,
      createdAt: DateTime.now(),
      lastLoginAt: DateTime.now(),
      password: '1234567', // Added password
    );
    await db.insert('users', defaultUser.toMap());
  }

  // Add onUpgrade to handle schema changes in future versions
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 3) { // Check for previous versions
      await db.execute('DROP TABLE IF EXISTS users');
      await _onCreate(db, newVersion);
    }
  }
}
