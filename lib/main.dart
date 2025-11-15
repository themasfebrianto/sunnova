import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart'; // Import google_fonts
import 'package:flutter/foundation.dart' show kIsWeb; // Import kIsWeb
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart'; // Import for web database
import 'package:sqflite/sqflite.dart'; // Import for databaseFactory
import 'package:sunnova_app/core/db/database_seeder.dart'; // Import database seeder
import 'package:sunnova_app/core/db/database_helper.dart'; // Import database helper

import 'package:sunnova_app/features/auth/presentation/notifiers/auth_notifier.dart';
import 'package:sunnova_app/features/home/presentation/notifiers/home_notifier.dart';
import 'package:sunnova_app/features/course/presentation/notifiers/course_notifier.dart';
import 'package:sunnova_app/features/course/presentation/notifiers/lesson_notifier.dart';
import 'package:sunnova_app/features/quiz/presentation/notifiers/quiz_notifier.dart';
import 'package:sunnova_app/features/profile/presentation/notifiers/profile_notifier.dart';
import 'package:sunnova_app/features/leaderboard/presentation/notifiers/leaderboard_notifier.dart';

import 'package:sunnova_app/features/auth/presentation/pages/splash_page.dart'; // Import SplashPage
import 'package:sunnova_app/injection_container.dart' as di; // Import as di (dependency injection)

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    databaseFactory = databaseFactoryFfiWeb;
  }

  await di.init(); // Initialize dependency injection

  // Seed the database
  final databaseHelper = di.sl<DatabaseHelper>();
  await seedDatabase(databaseHelper);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => di.sl<AuthNotifier>(),
        ), // Use GetIt to provide AuthNotifier
        ChangeNotifierProvider(create: (_) => di.sl<HomeNotifier>()),
        ChangeNotifierProvider(create: (_) => di.sl<CourseNotifier>()),
        ChangeNotifierProvider(create: (_) => di.sl<LessonNotifier>()),
        ChangeNotifierProvider(create: (_) => di.sl<QuizNotifier>()),
        ChangeNotifierProvider(create: (_) => di.sl<ProfileNotifier>()),
        ChangeNotifierProvider(create: (_) => di.sl<LeaderboardNotifier>()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Primary Colors
    final primaryGreen = const Color(0xFF00A884); // Islamic green
    final accentGold = const Color(0xFFFFD700);

    // Typography
    final textTheme = TextTheme(
      titleLarge: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold),
      bodyMedium: GoogleFonts.inter(fontSize: 16),
      bodySmall: GoogleFonts.inter(fontSize: 12, color: Colors.grey),
    );

    return MaterialApp(
      title: 'Sunnova App',
      theme: ThemeData(
        primaryColor: primaryGreen,
        colorScheme: ColorScheme.light(
          primary: primaryGreen,
          secondary: accentGold,
          surface: Colors.white,
          error: Colors.red,
          onPrimary: Colors.white,
          onSecondary: Colors.black,
          onSurface: Colors.black,
          onError: Colors.white,
        ),
        textTheme: textTheme,
        appBarTheme: AppBarTheme(
          backgroundColor: primaryGreen,
          foregroundColor: Colors.white,
          titleTextStyle: textTheme.titleLarge?.copyWith(color: Colors.white),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryGreen,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          ),
        ),
        cardTheme: CardThemeData(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.grey[200],
        ),
      ),
      home: const SplashPage(),
    );
  }
}
