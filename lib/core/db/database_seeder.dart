import 'package:sunnova_app/core/db/database_helper.dart';
import 'package:sunnova_app/features/auth/data/models/user_model.dart';
import 'package:sunnova_app/features/profile/data/models/badge_model.dart';
import 'package:sunnova_app/features/home/data/models/course_module_model.dart';
import 'package:sunnova_app/features/course/data/models/lesson_unit_model.dart'; // Corrected import
import 'package:sunnova_app/features/quiz/data/models/assessment_question_model.dart';
import 'package:sunnova_app/features/profile/data/models/user_achievement_model.dart';
import 'package:sunnova_app/features/home/data/models/user_game_stats_model.dart';

Future<void> seedDatabase(DatabaseHelper databaseHelper) async {
  // Seed Users
  final user1 = UserModel(
    uid: 'user_1',
    email: 'john.doe@example.com',
    displayName: 'John Doe',
    photoURL: null,
    gender: 'male',
    fcmToken: null,
    isPremium: false,
    createdAt: DateTime.now().subtract(const Duration(days: 30)),
    lastLoginAt: DateTime.now(),
    password: 'password123',
  );
  await databaseHelper.insertUser(user1.toMap());

  final user2 = UserModel(
    uid: 'user_2',
    email: 'jane.doe@example.com',
    displayName: 'Jane Doe',
    photoURL: null,
    gender: 'female',
    fcmToken: null,
    isPremium: true,
    createdAt: DateTime.now().subtract(const Duration(days: 60)),
    lastLoginAt: DateTime.now().subtract(const Duration(days: 5)),
    password: 'password123',
  );
  await databaseHelper.insertUser(user2.toMap());

  // Seed Badges
  final badge1 = BadgeModel(
    id: 'badge_1',
    name: 'First Login',
    description: 'Unlocked on first login',
    icon: 'login_icon',
    targetValue: 1,
    gemReward: 10,
    isUnlocked: false,
  );
  await databaseHelper.insertBadge(badge1.toMap());

  final badge2 = BadgeModel(
    id: 'badge_2',
    name: '5-Day Streak',
    description: 'Achieve a 5-day login streak',
    icon: 'streak_icon',
    targetValue: 5,
    gemReward: 20,
    isUnlocked: false,
  );
  await databaseHelper.insertBadge(badge2.toMap());

  final badge3 = BadgeModel(
    id: 'badge_3',
    name: 'Quiz Master',
    description: 'Complete 10 quizzes',
    icon: 'quiz_icon',
    targetValue: 10,
    gemReward: 30,
    isUnlocked: false,
  );
  await databaseHelper.insertBadge(badge3.toMap());

  // Seed Course Modules
  final module1 = CourseModuleModel(
    id: 'module_1',
    title: 'Tajwid Dasar',
    description: 'Pelajari dasar-dasar ilmu tajwid',
    imageUrl: 'tajwid_image.png',
    requiredXpToUnlock: 0,
    isLocked: false,
    totalLessons: 2, // Example value
    completedLessons: 0, // Example value
  );
  await databaseHelper.insertCourseModule(module1.toMap());

  final module2 = CourseModuleModel(
    id: 'module_2',
    title: 'Fiqh Shalat',
    description: 'Memahami tata cara shalat sesuai sunnah',
    imageUrl: 'fiqh_image.png',
    requiredXpToUnlock: 500,
    isLocked: true,
    totalLessons: 0, // Example value
    completedLessons: 0, // Example value
  );
  await databaseHelper.insertCourseModule(module2.toMap());

  // Seed Lesson Units for Module 1
  final lesson1_1 = LessonUnitModel(
    id: 'lesson_1_1',
    title: 'Pengenalan Huruf Hijaiyah',
    description: 'Mengenal huruf-huruf hijaiyah dan makhrajnya',
    content: 'Ini adalah konten pengenalan huruf hijaiyah...',
    videoUrl: null,
    audioUrl: null,
    durationMinutes: 15,
  );
  await databaseHelper.insertLessonUnit(lesson1_1.toMap());

  final lesson1_2 = LessonUnitModel(
    id: 'lesson_1_2',
    title: 'Hukum Nun Mati dan Tanwin',
    description: 'Memahami hukum nun mati dan tanwin (idzhar, ikhfa, iqlab, idgham)',
    content: 'Ini adalah konten hukum nun mati dan tanwin...',
    videoUrl: null,
    audioUrl: null,
    durationMinutes: 20,
  );
  await databaseHelper.insertLessonUnit(lesson1_2.toMap());

  // Seed Assessment Questions for Lesson 1_1
  final question1_1_1 = AssessmentQuestionModel(
    id: 'q_1_1_1',
    lessonId: 'lesson_1_1',
    question: 'Berapa jumlah huruf hijaiyah?',
    options: ['28', '29', '30', '31'],
    correctAnswerIndex: 1,
    explanation: 'Jumlah huruf hijaiyah adalah 29.',
    difficultyLevel: 1,
    ordering: 1,
  );
  await databaseHelper.insertAssessmentQuestion(question1_1_1.toMap());

  final question1_1_2 = AssessmentQuestionModel(
    id: 'q_1_1_2',
    lessonId: 'lesson_1_1',
    question: 'Huruf apakah ini: ا',
    options: ['Alif', 'Ba', 'Ta', 'Tsa'],
    correctAnswerIndex: 0,
    explanation: 'Itu adalah huruf Alif.',
    difficultyLevel: 1,
    ordering: 2,
  );
  await databaseHelper.insertAssessmentQuestion(question1_1_2.toMap());

  // Seed User Achievements for user_1
  final user1Ach1 = UserAchievementModel(
    id: 'u1_ach_1',
    userId: 'user_1',
    badgeId: badge1.id,
    title: badge1.name,
    description: badge1.description,
    isUnlocked: true,
    unlockedAt: DateTime.now().subtract(const Duration(days: 29)),
    isNew: false,
  );
  await databaseHelper.insertUserAchievement(user1Ach1.toMap());

  final user1Ach2 = UserAchievementModel(
    id: 'u1_ach_2',
    userId: 'user_1',
    badgeId: badge2.id,
    title: badge2.name,
    description: badge2.description,
    isUnlocked: true,
    unlockedAt: DateTime.now().subtract(const Duration(days: 10)),
    isNew: false,
  );
  await databaseHelper.insertUserAchievement(user1Ach2.toMap());

  // Seed User Game Stats for user_1
  final user1Stats = UserGameStatsModel(
    userName: user1.displayName ?? 'User 1',
    xp: 1200,
    level: 5,
    currentXp: 1200,
    xpToNextLevel: 1500, // Example value
    currentStreak: 7,
    longestStreak: 15,
    lessonsCompleted: 10,
    quizzesPassed: 5,
    totalXp: 1200,
  );
  await databaseHelper.insertUserGameStats(user1Stats.toMap());

  // Seed User Game Stats for user_2
  final user2Stats = UserGameStatsModel(
    userName: user2.displayName ?? 'User 2',
    xp: 2500,
    level: 8,
    currentXp: 2500,
    xpToNextLevel: 3000, // Example value
    currentStreak: 3,
    longestStreak: 25,
    lessonsCompleted: 20,
    quizzesPassed: 12,
    totalXp: 2500,
  );
  await databaseHelper.insertUserGameStats(user2Stats.toMap());
}
