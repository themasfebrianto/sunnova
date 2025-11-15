import 'package:get_it/get_it.dart';
import 'package:sunnova_app/core/db/database_helper.dart';
import 'package:sunnova_app/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:sunnova_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:sunnova_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:sunnova_app/features/auth/domain/usecases/get_current_user.dart';
import 'package:sunnova_app/features/auth/domain/usecases/login_user.dart';
import 'package:sunnova_app/features/auth/domain/usecases/logout_user.dart';
import 'package:sunnova_app/features/auth/domain/usecases/register_user.dart';
import 'package:sunnova_app/features/auth/presentation/notifiers/auth_notifier.dart';
import 'package:sunnova_app/features/home/data/datasources/home_local_data_source.dart';
import 'package:sunnova_app/features/home/data/repositories/home_repository_impl.dart';
import 'package:sunnova_app/features/home/domain/repositories/home_repository.dart';
import 'package:sunnova_app/features/home/domain/usecases/get_course_modules.dart';
import 'package:sunnova_app/features/home/domain/usecases/get_user_game_stats.dart';
import 'package:sunnova_app/features/home/presentation/notifiers/home_notifier.dart';
import 'package:sunnova_app/features/course/data/datasources/course_local_data_source.dart';
import 'package:sunnova_app/features/course/data/repositories/course_repository_impl.dart';
import 'package:sunnova_app/features/course/domain/repositories/course_repository.dart';
import 'package:sunnova_app/features/course/domain/usecases/get_course_detail.dart';
import 'package:sunnova_app/features/course/domain/usecases/get_lesson_units.dart';
import 'package:sunnova_app/features/course/domain/usecases/get_user_lesson_progress.dart';
import 'package:sunnova_app/features/course/domain/usecases/mark_lesson_as_completed.dart';
import 'package:sunnova_app/features/course/domain/usecases/get_lesson_content.dart';
import 'package:sunnova_app/features/course/presentation/notifiers/course_notifier.dart';
import 'package:sunnova_app/features/course/presentation/notifiers/lesson_notifier.dart';
import 'package:sunnova_app/features/quiz/data/datasources/quiz_local_data_source.dart';
import 'package:sunnova_app/features/quiz/data/repositories/quiz_repository_impl.dart';
import 'package:sunnova_app/features/quiz/domain/repositories/quiz_repository.dart';
import 'package:sunnova_app/features/quiz/domain/usecases/get_quiz_questions.dart';
import 'package:sunnova_app/features/quiz/domain/usecases/submit_quiz_answers.dart';
import 'package:sunnova_app/features/quiz/presentation/notifiers/quiz_notifier.dart';
import 'package:sunnova_app/features/profile/data/datasources/profile_local_data_source.dart';
import 'package:sunnova_app/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:sunnova_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:sunnova_app/features/profile/domain/usecases/get_user_profile.dart'
    as profile_usecase;
import 'package:sunnova_app/features/profile/domain/usecases/get_user_achievements.dart';
import 'package:sunnova_app/features/profile/domain/usecases/get_badges.dart';
import 'package:sunnova_app/features/profile/presentation/notifiers/profile_notifier.dart';
import 'package:sunnova_app/features/leaderboard/data/datasources/leaderboard_local_data_source.dart'; // Import LeaderboardLocalDataSource
import 'package:sunnova_app/features/leaderboard/data/repositories/leaderboard_repository_impl.dart'; // Import LeaderboardRepositoryImpl
import 'package:sunnova_app/features/leaderboard/domain/repositories/leaderboard_repository.dart'; // Import LeaderboardRepository
import 'package:sunnova_app/features/leaderboard/domain/usecases/get_leaderboard.dart'; // Import GetLeaderboard
import 'package:sunnova_app/features/leaderboard/presentation/notifiers/leaderboard_notifier.dart'; // Import LeaderboardNotifier

import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance; // sl is short for Service Locator

Future<void> init() async {
  //! Features - Auth
  // Presentation
  sl.registerFactory(
    () => AuthNotifier(
      loginUser: sl(),
      registerUser: sl(),
      getCurrentUser: sl(),
      logoutUser: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetCurrentUser(sl()));
  sl.registerLazySingleton(() => LoginUser(sl()));
  sl.registerLazySingleton(() => RegisterUser(sl()));
  sl.registerLazySingleton(() => LogoutUser(sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(localDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(databaseHelper: sl(), sharedPreferences: sl()),
  );

  //! Features - Home
  // Presentation
  sl.registerFactory(
    () => HomeNotifier(getUserGameStats: sl(), getCourseModules: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => GetUserGameStats(sl()));
  sl.registerLazySingleton(() => GetCourseModules(sl()));

  // Repository
  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(localDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<HomeLocalDataSource>(
    () => HomeLocalDataSourceImpl(databaseHelper: sl()),
  );

  //! Features - Course
  // Presentation
  sl.registerFactory(
    () => CourseNotifier(
      getCourseDetail: sl(),
      getLessonUnits: sl(),
      getUserLessonProgress: sl(),
    ),
  );
  sl.registerFactory(
    () => LessonNotifier(
      getCourseDetail: sl(),
      getLessonUnits: sl(),
      getUserLessonProgress: sl(),
      markLessonAsCompleted: sl(),
      getLessonContent: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetCourseDetail(sl()));
  sl.registerLazySingleton(() => GetLessonUnits(sl()));
  sl.registerLazySingleton(() => GetUserLessonProgress(sl()));
  sl.registerLazySingleton(() => MarkLessonAsCompleted(sl()));
  sl.registerLazySingleton(() => GetLessonContent(sl()));

  // Repository
  sl.registerLazySingleton<CourseRepository>(
    () => CourseRepositoryImpl(localDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<CourseLocalDataSource>(
    () => CourseLocalDataSourceImpl(databaseHelper: sl()),
  );

  //! Features - Quiz
  // Presentation
  sl.registerFactory(
    () => QuizNotifier(getQuizQuestions: sl(), submitQuizAnswers: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => GetQuizQuestions(sl()));
  sl.registerLazySingleton(() => SubmitQuizAnswers(sl()));

  // Repository
  sl.registerLazySingleton<QuizRepository>(
    () => QuizRepositoryImpl(localDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<QuizLocalDataSource>(
    () => QuizLocalDataSourceImpl(databaseHelper: sl()),
  );

  //! Features - Profile
  // Presentation
  sl.registerFactory(
    () => ProfileNotifier(
      fetchUserProfile: sl(), // GetUserProfile use case
      fetchUserStats: sl(),
      fetchUserAchievements: sl(),
      logoutUser: sl(), // LogoutUser use case
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => profile_usecase.GetUserProfile(sl()));
  sl.registerLazySingleton(() => GetUserAchievements(sl()));
  sl.registerLazySingleton(() => GetBadges(sl()));

  // Repository
  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(localDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<ProfileLocalDataSource>(
    () => ProfileLocalDataSourceImpl(databaseHelper: sl()),
  );

  //! Features - Leaderboard
  // Presentation
  sl.registerFactory(() => LeaderboardNotifier(getLeaderboard: sl()));

  // Use cases
  sl.registerLazySingleton(() => GetLeaderboard(sl()));

  // Repository
  sl.registerLazySingleton<LeaderboardRepository>(
    () => LeaderboardRepositoryImpl(localDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<LeaderboardLocalDataSource>(
    () => LeaderboardLocalDataSourceImpl(databaseHelper: sl()),
  );

  //! Core
  sl.registerLazySingleton(() => DatabaseHelper());

  //! External
  sl.registerLazySingletonAsync<SharedPreferences>(() => SharedPreferences.getInstance());
}
