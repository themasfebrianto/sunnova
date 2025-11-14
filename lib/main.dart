import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart'; // Import google_fonts
import 'package:flutter/foundation.dart' show kIsWeb; // Import kIsWeb
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart'; // Import for web database
import 'package:flutter/services.dart'; // Import for SystemUiOverlayStyle

import 'package:sunnova_app/features/auth/presentation/notifiers/auth_notifier.dart';
import 'package:sunnova_app/features/home/presentation/notifiers/home_notifier.dart';
import 'package:sunnova_app/features/course/presentation/notifiers/course_notifier.dart';
import 'package:sunnova_app/features/course/presentation/notifiers/lesson_notifier.dart';
import 'package:sunnova_app/features/quiz/presentation/notifiers/quiz_notifier.dart';
import 'package:sunnova_app/features/profile/presentation/notifiers/profile_notifier.dart';
import 'package:sunnova_app/features/leaderboard/presentation/notifiers/leaderboard_notifier.dart';

import 'package:sunnova_app/features/home/presentation/pages/home_page.dart'; // Import HomePage
import 'package:sunnova_app/injection_container.dart'
    as di; // Import as di (dependency injection)
import 'package:sqflite/sqflite.dart'; // Import for databaseFactory

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    databaseFactory = databaseFactoryFfiWeb;
  }

  await di.init(); // Initialize dependency injection
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => di.sl<AuthNotifier>(),
        ), // Use GetIt to provide AuthNotifier
        ChangeNotifierProvider(create: (_) => HomeNotifier()),
        ChangeNotifierProvider(create: (_) => CourseNotifier()),
        ChangeNotifierProvider(create: (_) => LessonNotifier()),
        ChangeNotifierProvider(create: (_) => QuizNotifier()),
        ChangeNotifierProvider(create: (_) => ProfileNotifier()),
        ChangeNotifierProvider(create: (_) => LeaderboardNotifier()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // === Primary Color Scheme (Pastel Mint / Aqua) ===
    const Color primaryColor = Color(0xFF8EE5D1); // Pastel mint
    const Color primaryLight = Color(0xFFD7FFF6); // Very soft mint
    const Color primaryDark = Color(0xFF5ABFA8); // Teal pastel

    // === Secondary Colors (Peach Cream) ===
    const Color secondaryColor = Color(0xFFFFD7C2); // Peach cream
    const Color secondaryLight = Color(0xFFFFECE3); // Very soft peach
    const Color secondaryDark = Color(0xFFEFB79F); // Warm peach

    // === Surface & Background ===
    const Color surfaceColor = Color(0xFFFFFFFF); // Pure clean white
    const Color backgroundColor = Color(0xFFF8F9FA); // Pastel gray-white
    const Color cardColor = Color(0xFFFFFFFF); // White card

    // === Text Colors ===
    const Color textPrimary = Color(0xFF1F1F1F); // Soft black
    const Color textSecondary = Color(0xFF5F6368); // Google gray
    const Color textTertiary = Color(0xFF9CA3AF); // Soft gray

    // === Gamification Colors (more pastel, more fun) ===
    const Color xpBlue = Color(0xFFAED9FF); // Pastel sky blue
    const Color xpBlueDark = Color(0xFF7FB8E8);

    const Color streakOrange = Color(0xFFFFC9A9); // Pastel apricot
    const Color streakOrangeDark = Color(0xFFFFA97A);

    const Color badgeYellow = Color(0xFFFFE49B); // Pastel yellow
    const Color levelPurple = Color(0xFFCABDFF); // Soft pastel purple

    // === Status Colors (Softened) ===
    const Color successGreen = Color(0xFFB6EFB3); // Pastel success
    const Color successGreenDark = Color(0xFF8EDB8A);

    const Color errorRed = Color(0xFFFFB4B4); // Pastel red
    const Color warningAmber = Color(0xFFFFD8A8); // Pastel amber
    const Color infoBlue = Color(0xFFAED4FF); // Pastel info

    // === Semantic Colors ===
    const Color lockedGray = Color(0xFFE7E7E7);
    const Color completedGreen = Color(0xFFCAF7C9);
    const Color inProgressBlue = Color(0xFFCBE4FF);

    // === Revised Gradients (Softer, Material-ish) ===
    const LinearGradient primaryGradient = LinearGradient(
      colors: [Color(0xFF8EE5D1), Color(0xFFD7FFF6)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    const LinearGradient xpGradient = LinearGradient(
      colors: [Color(0xFFAED9FF), Color(0xFF7FB8E8)],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    );

    const LinearGradient streakGradient = LinearGradient(
      colors: [Color(0xFFFFC9A9), Color(0xFFFFA97A)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );

    const LinearGradient cardGradient = LinearGradient(
      colors: [Color(0xFFFFFFFF), Color(0xFFF8F9FA)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    // === Spacing Constants ===
    const double space4 = 4.0; // Micro spacing
    const double space8 = 8.0; // Tiny spacing
    const double space12 = 12.0; // Small spacing
    const double space16 = 16.0; // Base spacing
    const double space20 = 20.0; // Medium spacing
    const double space24 = 24.0; // Large spacing
    const double space32 = 32.0; // XL spacing
    const double space40 = 40.0; // XXL spacing
    const double space48 = 48.0; // Huge spacing
    const double space64 = 64.0; // Massive spacing

    // === Padding Presets ===
    const EdgeInsets pagePadding = EdgeInsets.all(space16);
    const EdgeInsets cardPadding = EdgeInsets.all(space16);
    const EdgeInsets sectionPadding = EdgeInsets.symmetric(
      horizontal: space16,
      vertical: space12,
    );
    const EdgeInsets buttonPadding = EdgeInsets.symmetric(
      horizontal: space24,
      vertical: space12,
    );

    // === Border Radius ===
    const double radiusSmall = 8.0; // Input fields, chips
    const double radiusMedium = 12.0; // Cards, buttons
    const double radiusLarge = 16.0; // Modal, sheets
    const double radiusXL = 24.0; // Hero cards
    const double radiusFull = 9999.0; // Circular elements

    // === Elevation Shadows (Soft) ===
    final List<BoxShadow> elevationLow = [
      BoxShadow(
        color: Colors.black.withAlpha((255 * 0.04).round()),
        blurRadius: 8,
        offset: Offset(0, 2),
      ),
    ];

    final List<BoxShadow> elevationMedium = [
      BoxShadow(
        color: Colors.black.withAlpha((255 * 0.06).round()),
        blurRadius: 12,
        offset: Offset(0, 4),
      ),
    ];

    final List<BoxShadow> elevationHigh = [
      BoxShadow(
        color: Colors.black.withAlpha((255 * 0.08).round()),
        blurRadius: 16,
        offset: Offset(0, 8),
      ),
    ];

    final List<BoxShadow> elevationXL = [
      BoxShadow(
        color: Colors.black.withAlpha((255 * 0.1).round()),
        blurRadius: 24,
        offset: Offset(0, 12),
      ),
    ];

    // === Typography (Google Sans & Inter) ===
    // Heading Styles
    final TextStyle headingLarge = GoogleFonts.plusJakartaSans(
      fontSize: 32,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.5,
      color: textPrimary,
      height: 1.2,
    );

    final TextStyle headingMedium = GoogleFonts.plusJakartaSans(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.3,
      color: textPrimary,
      height: 1.3,
    );

    final TextStyle headingSmall = GoogleFonts.plusJakartaSans(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      letterSpacing: 0,
      color: textPrimary,
      height: 1.4,
    );

    // Title Styles
    final TextStyle titleLarge = GoogleFonts.inter(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      letterSpacing: 0,
      color: textPrimary,
      height: 1.4,
    );

    final TextStyle titleMedium = GoogleFonts.inter(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.15,
      color: textPrimary,
      height: 1.5,
    );

    final TextStyle titleSmall = GoogleFonts.inter(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.1,
      color: textPrimary,
      height: 1.43,
    );

    // Body Styles
    final TextStyle bodyLarge = GoogleFonts.inter(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5,
      color: textPrimary,
      height: 1.5,
    );

    final TextStyle bodyMedium = GoogleFonts.inter(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
      color: textSecondary,
      height: 1.43,
    );

    final TextStyle bodySmall = GoogleFonts.inter(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.4,
      color: textSecondary,
      height: 1.33,
    );

    // Label Styles
    final TextStyle labelLarge = GoogleFonts.inter(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
      color: textPrimary,
      height: 1.43,
    );

    final TextStyle labelMedium = GoogleFonts.inter(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.5,
      color: textSecondary,
      height: 1.33,
    );

    final TextStyle labelSmall = GoogleFonts.inter(
      fontSize: 11,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.5,
      color: textTertiary,
      height: 1.45,
    );

    // Special Styles
    final TextStyle numberDisplay = GoogleFonts.plusJakartaSans(
      fontSize: 36,
      fontWeight: FontWeight.w700,
      letterSpacing: -1,
      color: primaryColor,
      height: 1.2,
    );

    final TextStyle badgeText = GoogleFonts.inter(
      fontSize: 10,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.5,
      color: Colors.white,
      height: 1.2,
    );
    // === Icon Sizes ===
    const double iconSmall = 16.0;
    const double iconMedium = 20.0;
    const double iconLarge = 24.0;
    const double iconXL = 32.0;
    const double iconXXL = 48.0;

    // === Icon Colors ===
    const Color iconPrimary = textPrimary;
    const Color iconSecondary = textSecondary;
    const Color iconTertiary = textTertiary;
    const Color iconAccent = primaryColor;

    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryColor,
          primary: primaryColor,
          onPrimary: Colors.white,
          primaryContainer: primaryLight,
          onPrimaryContainer: primaryDark,
          secondary: secondaryColor,
          onSecondary: Colors.white,
          secondaryContainer: secondaryLight,
          onSecondaryContainer: secondaryDark,
          tertiary:
              levelPurple, // Using levelPurple as tertiary for general accent
          onTertiary: Colors.white,
          error: errorRed,
          onError: Colors.white,
          surfaceContainerLowest: backgroundColor,
          onSurfaceVariant: textPrimary,
          surface: surfaceColor,
          onSurface: textPrimary,
          surfaceContainer: cardColor, // Use cardColor for surfaceContainer
        ),
        useMaterial3: true,
        textTheme: TextTheme(
          displayLarge: GoogleFonts.plusJakartaSans(
            fontSize: 57,
            fontWeight: FontWeight.w400,
            letterSpacing: -0.25,
            color: textPrimary,
          ),
          displayMedium: GoogleFonts.plusJakartaSans(
            fontSize: 45,
            fontWeight: FontWeight.w400,
            letterSpacing: 0,
            color: textPrimary,
          ),
          displaySmall: GoogleFonts.plusJakartaSans(
            fontSize: 36,
            fontWeight: FontWeight.w400,
            letterSpacing: 0,
            color: textPrimary,
          ),
          headlineLarge: headingLarge,
          headlineMedium: headingMedium,
          headlineSmall: headingSmall,
          titleLarge: titleLarge,
          titleMedium: titleMedium,
          titleSmall: titleSmall,
          bodyLarge: bodyLarge,
          bodyMedium: bodyMedium,
          bodySmall: bodySmall,
          labelLarge: labelLarge,
          labelMedium: labelMedium,
          labelSmall: labelSmall,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: false,
          titleTextStyle: titleLarge,
          iconTheme: const IconThemeData(color: textPrimary),
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          surfaceTintColor:
              Colors.transparent, // Disable default Material 3 tint
          shadowColor: Colors.transparent, // Remove shadow
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            foregroundColor: Colors.white,
            padding: buttonPadding,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radiusMedium),
            ),
            minimumSize: const Size(double.infinity, 48), // Set a fixed height
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: primaryColor,
            padding: buttonPadding,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radiusMedium),
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: primaryColor,
            padding: buttonPadding,
            side: const BorderSide(color: primaryColor, width: 1.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radiusMedium),
            ),
            minimumSize: const Size(double.infinity, 48),
          ),
        ),
        cardTheme: CardThemeData(
          elevation: 0,
          color: cardColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusMedium),
          ),
          shadowColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          margin: EdgeInsets.zero,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: surfaceColor,
          hintStyle: bodyMedium.copyWith(color: textTertiary),
          prefixIconColor: textSecondary,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radiusMedium),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radiusMedium),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radiusMedium),
            borderSide: BorderSide(color: primaryColor, width: 2),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: space16,
            vertical: space16,
          ),
        ),
      ),
      home: HomePage(),
    );
  }
}
