# Instruksi Pembuatan Presentation Layer - Sunnova App

## 🎯 Objektif
Buatkan implementasi lengkap **Presentation Layer** untuk Sunnova App menggunakan **ChangeNotifier + Provider** dengan fokus pada UI/UX yang intuitif dan gamified.

---

## 📋 Struktur Folder yang Harus Dibuat

```
lib/features/
├── auth/
│   └── presentation/
│       ├── notifiers/
│       │   └── auth_notifier.dart
│       ├── pages/
│       │   ├── splash_page.dart
│       │   ├── login_page.dart
│       │   └── register_page.dart
│       └── widgets/
│           └── auth_text_field.dart
│
├── home/
│   └── presentation/
│       ├── notifiers/
│       │   └── home_notifier.dart
│       ├── pages/
│       │   └── home_page.dart
│       └── widgets/
│           ├── streak_card.dart
│           ├── xp_progress_bar.dart
│           └── course_module_card.dart
│
├── course/
│   └── presentation/
│       ├── notifiers/
│       │   ├── course_notifier.dart
│       │   └── lesson_notifier.dart
│       ├── pages/
│       │   ├── course_detail_page.dart
│       │   ├── lesson_list_page.dart
│       │   └── lesson_content_page.dart
│       └── widgets/
│           ├── lesson_unit_card.dart
│           └── content_viewer.dart
│
├── quiz/
│   └── presentation/
│       ├── notifiers/
│       │   └── quiz_notifier.dart
│       ├── pages/
│       │   ├── quiz_page.dart
│       │   └── quiz_result_page.dart
│       └── widgets/
│           ├── question_card.dart
│           ├── option_button.dart
│           └── progress_indicator.dart
│
├── profile/
│   └── presentation/
│       ├── notifiers/
│       │   └── profile_notifier.dart
│       ├── pages/
│       │   └── profile_page.dart
│       └── widgets/
│           ├── stats_card.dart
│           ├── badge_grid.dart
│           └── achievement_item.dart
│
└── leaderboard/
    └── presentation/
        ├── notifiers/
        │   └── leaderboard_notifier.dart
        ├── pages/
        │   └── leaderboard_page.dart
        └── widgets/
            ├── rank_item.dart
            └── leaderboard_filter.dart
```

---

## 🎨 UI Flow & Navigation

### 1. Authentication Flow
```
SplashPage
    ↓
    ├─→ LoginPage
    │      ↓
    │   RegisterPage
    │      ↓
    └─→ HomePage (MainNavigationPage)
```

**Instruksi Detail:**
- **SplashPage**: Tampilkan logo Sunnova, cek status login (dari SharedPreferences atau DB), redirect ke HomePage jika sudah login, jika belum ke LoginPage
- **LoginPage**: Form email + password, tombol "Masuk", link ke RegisterPage, validasi input
- **RegisterPage**: Form nama, email, password, konfirmasi password, gender selection, tombol "Daftar"

---

### 2. Main Navigation Flow (Bottom Navigation)
```
HomePage (Tab 1 - Home)
    ├─→ CourseDetailPage
    │      ↓
    │   LessonListPage
    │      ↓
    │   LessonContentPage
    │      ↓
    │   QuizPage
    │      ↓
    │   QuizResultPage

ProfilePage (Tab 2 - Profile)

LeaderboardPage (Tab 3 - Leaderboard)
```

**Instruksi Detail:**
- Gunakan `BottomNavigationBar` dengan 3 tab:
  1. **Home** (Icon: home)
  2. **Profile** (Icon: person)
  3. **Leaderboard** (Icon: emoji_events)

---

## 🏗️ Komponen UI yang Harus Dibuat

### A. HomePage Components

#### 1. Notifier: HomeNotifier

**State yang dikelola:**
```dart
class HomeState {
  final UserGameStats? userStats;
  final List<CourseModule> modules;
  final bool isLoading;
  final String? errorMessage;
}
```

**Methods:**
- `fetchUserStats(String userId)` - Load XP, level, streak
- `fetchCourseModules()` - Load semua modul kursus
- `checkDailyLogin()` - Update streak jika user baru login hari ini

#### 2. Widgets:

**StreakCard:**
- Tampilkan current streak dengan ikon api 🔥
- Tampilkan longest streak
- Animasi streak counter

**XPProgressBar:**
- Progress bar XP ke level berikutnya
- Format: "Level X - XXX/XXX XP"
- Animasi fill progress

**CourseModuleCard:**
- Card untuk setiap modul (Tajwid, Fiqh, dll)
- Badge "LOCKED" jika `isLocked == true`
- Progress indicator (X/Y lessons completed)
- Tap untuk navigate ke CourseDetailPage

---

### B. CourseDetailPage Components

#### 1. Notifier: CourseNotifier

**State:**
```dart
class CourseState {
  final CourseModule? selectedModule;
  final List<LessonUnit> units;
  final Map<String, UserLessonProgress> progressMap;
  final bool isLoading;
  final String? errorMessage;
}
```

**Methods:**
- `fetchCourseDetail(String moduleId)`
- `fetchLessonUnits(String moduleId)`
- `fetchUserProgress(String userId, String moduleId)`

#### 2. Page UI:
- Header dengan icon modul, title, description
- Progress overview: "X/Y Lessons Completed"
- List of LessonUnitCard (scrollable)
- FAB untuk "Start Learning" (navigate ke lesson pertama yang belum selesai)

---
🎨 Google Pastel Material 3 – Fresh Palette

Lembut, airy, friendly — biar UI berasa modern dan fun.

🌿 Primary (Pastel Mint / Aqua — khas Google apps)
final primaryColor     = Color(0xFF8EE5D1);  // Pastel mint
final primaryLight     = Color(0xFFD7FFF6);  // Very soft mint
final primaryDark      = Color(0xFF5ABFA8);  // Teal pastel

🍑 Secondary (Peach Cream — Material You vibes)
final secondaryColor   = Color(0xFFFFD7C2);  // Peach cream
final secondaryLight   = Color(0xFFFFECE3);  // Very soft peach
final secondaryDark    = Color(0xFFEFB79F);  // Warm peach

📄 Surface & Background (Super Clean)
final surfaceColor     = Color(0xFFFFFFFF);  // Pure clean white
final backgroundColor  = Color(0xFFF8F9FA);  // Pastel gray-white
final cardColor        = Color(0xFFFFFFFF);  // White card

✏️ Text (Tetap gampang dibaca)
final textPrimary      = Color(0xFF1F1F1F);  // Soft black
final textSecondary    = Color(0xFF5F6368);  // Google gray
final textTertiary     = Color(0xFF9CA3AF);  // Soft gray

🕹 Gamification Colors (lebih pastel, lebih fun)
final xpBlue           = Color(0xFFAED9FF);  // Pastel sky blue
final xpBlueDark       = Color(0xFF7FB8E8);

final streakOrange     = Color(0xFFFFC9A9);  // Pastel apricot
final streakOrangeDark = Color(0xFFFFA97A);

final badgeYellow      = Color(0xFFFFE49B);  // Pastel yellow
final levelPurple      = Color(0xFFCABDFF);  // Soft pastel purple

🟢🔴 Status Colors (Softened)
final successGreen     = Color(0xFFB6EFB3);  // Pastel success
final successGreenDark = Color(0xFF8EDB8A);

final errorRed         = Color(0xFFFFB4B4);  // Pastel red
final warningAmber     = Color(0xFFFFD8A8);  // Pastel amber
final infoBlue         = Color(0xFFAED4FF);  // Pastel info

🔒 Semantic
final lockedGray       = Color(0xFFE7E7E7);
final completedGreen   = Color(0xFFCAF7C9);
final inProgressBlue   = Color(0xFFCBE4FF);

🌈 Revised Gradients (Lebih lembut, Material-ish)
final primaryGradient = LinearGradient(
  colors: [Color(0xFF8EE5D1), Color(0xFFD7FFF6)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

final xpGradient = LinearGradient(
  colors: [Color(0xFFAED9FF), Color(0xFF7FB8E8)],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);

final streakGradient = LinearGradient(
  colors: [Color(0xFFFFC9A9), Color(0xFFFFA97A)],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);

final cardGradient = LinearGradient(
  colors: [Color(0xFFFFFFFF), Color(0xFFF8F9FA)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);


Typography (Google Sans & Inter)
dart// === Heading Styles ===
final headingLarge = GoogleFonts.plusJakartaSans(
  fontSize: 32,
  fontWeight: FontWeight.w700,
  letterSpacing: -0.5,
  color: textPrimary,
  height: 1.2,
);

final headingMedium = GoogleFonts.plusJakartaSans(
  fontSize: 24,
  fontWeight: FontWeight.w600,
  letterSpacing: -0.3,
  color: textPrimary,
  height: 1.3,
);

final headingSmall = GoogleFonts.plusJakartaSans(
  fontSize: 20,
  fontWeight: FontWeight.w600,
  letterSpacing: 0,
  color: textPrimary,
  height: 1.4,
);

// === Title Styles ===
final titleLarge = GoogleFonts.inter(
  fontSize: 18,
  fontWeight: FontWeight.w600,
  letterSpacing: 0,
  color: textPrimary,
  height: 1.4,
);

final titleMedium = GoogleFonts.inter(
  fontSize: 16,
  fontWeight: FontWeight.w600,
  letterSpacing: 0.15,
  color: textPrimary,
  height: 1.5,
);

final titleSmall = GoogleFonts.inter(
  fontSize: 14,
  fontWeight: FontWeight.w600,
  letterSpacing: 0.1,
  color: textPrimary,
  height: 1.43,
);

// === Body Styles ===
final bodyLarge = GoogleFonts.inter(
  fontSize: 16,
  fontWeight: FontWeight.w400,
  letterSpacing: 0.5,
  color: textPrimary,
  height: 1.5,
);

final bodyMedium = GoogleFonts.inter(
  fontSize: 14,
  fontWeight: FontWeight.w400,
  letterSpacing: 0.25,
  color: textSecondary,
  height: 1.43,
);

final bodySmall = GoogleFonts.inter(
  fontSize: 12,
  fontWeight: FontWeight.w400,
  letterSpacing: 0.4,
  color: textSecondary,
  height: 1.33,
);

// === Label Styles ===
final labelLarge = GoogleFonts.inter(
  fontSize: 14,
  fontWeight: FontWeight.w500,
  letterSpacing: 0.1,
  color: textPrimary,
  height: 1.43,
);

final labelMedium = GoogleFonts.inter(
  fontSize: 12,
  fontWeight: FontWeight.w500,
  letterSpacing: 0.5,
  color: textSecondary,
  height: 1.33,
);

final labelSmall = GoogleFonts.inter(
  fontSize: 11,
  fontWeight: FontWeight.w500,
  letterSpacing: 0.5,
  color: textTertiary,
  height: 1.45,
);

// === Special Styles ===
final numberDisplay = GoogleFonts.plusJakartaSans(
  fontSize: 36,
  fontWeight: FontWeight.w700,
  letterSpacing: -1,
  color: primaryColor,
  height: 1.2,
);

final badgeText = GoogleFonts.inter(
  fontSize: 10,
  fontWeight: FontWeight.w600,
  letterSpacing: 0.5,
  color: Colors.white,
  height: 1.2,
);
Spacing System (8pt Grid)
dart// === Spacing Constants ===
const space4 = 4.0;    // Micro spacing
const space8 = 8.0;    // Tiny spacing
const space12 = 12.0;  // Small spacing
const space16 = 16.0;  // Base spacing
const space20 = 20.0;  // Medium spacing
const space24 = 24.0;  // Large spacing
const space32 = 32.0;  // XL spacing
const space40 = 40.0;  // XXL spacing
const space48 = 48.0;  // Huge spacing
const space64 = 64.0;  // Massive spacing

// === Padding Presets ===
const pagePadding = EdgeInsets.all(space16);
const cardPadding = EdgeInsets.all(space16);
const sectionPadding = EdgeInsets.symmetric(horizontal: space16, vertical: space12);
const buttonPadding = EdgeInsets.symmetric(horizontal: space24, vertical: space12);
Border Radius & Elevation
dart// === Border Radius ===
const radiusSmall = 8.0;    // Input fields, chips
const radiusMedium = 12.0;  // Cards, buttons
const radiusLarge = 16.0;   // Modal, sheets
const radiusXL = 24.0;      // Hero cards
const radiusFull = 9999.0;  // Circular elements

// === Elevation Shadows (Soft) ===
final elevationLow = [
  BoxShadow(
    color: Colors.black.withOpacity(0.04),
    blurRadius: 8,
    offset: Offset(0, 2),
  ),
];

final elevationMedium = [
  BoxShadow(
    color: Colors.black.withOpacity(0.06),
    blurRadius: 12,
    offset: Offset(0, 4),
  ),
];

final elevationHigh = [
  BoxShadow(
    color: Colors.black.withOpacity(0.08),
    blurRadius: 16,
    offset: Offset(0, 8),
  ),
];

final elevationXL = [
  BoxShadow(
    color: Colors.black.withOpacity(0.1),
    blurRadius: 24,
    offset: Offset(0, 12),
  ),
];
Component Design Patterns
1. Card Design
dart// === Standard Card ===
Container(
  decoration: BoxDecoration(
    color: cardColor,
    borderRadius: BorderRadius.circular(radiusMedium),
    boxShadow: elevationLow,
  ),
  padding: cardPadding,
  child: content,
)

// === Elevated Card (Hover/Selected) ===
Container(
  decoration: BoxDecoration(
    color: cardColor,
    borderRadius: BorderRadius.circular(radiusMedium),
    boxShadow: elevationMedium,
    border: Border.all(color: primaryLight.withOpacity(0.3), width: 1),
  ),
  padding: cardPadding,
  child: content,
)

// === Gradient Card ===
Container(
  decoration: BoxDecoration(
    gradient: cardGradient,
    borderRadius: BorderRadius.circular(radiusMedium),
    boxShadow: elevationLow,
  ),
  padding: cardPadding,
  child: content,
)
2. Button Styles
dart// === Primary Button (Filled) ===
ElevatedButton(
  style: ElevatedButton.styleFrom(
    backgroundColor: primaryColor,
    foregroundColor: Colors.white,
    padding: buttonPadding,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(radiusMedium),
    ),
    minimumSize: Size(double.infinity, 48),
  ),
  onPressed: onPressed,
  child: Text('Button Text', style: labelLarge),
)

// === Secondary Button (Outlined) ===
OutlinedButton(
  style: OutlinedButton.styleFrom(
    foregroundColor: primaryColor,
    padding: buttonPadding,
    side: BorderSide(color: primaryColor, width: 1.5),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(radiusMedium),
    ),
    minimumSize: Size(double.infinity, 48),
  ),
  onPressed: onPressed,
  child: Text('Button Text', style: labelLarge),
)

// === Text Button ===
TextButton(
  style: TextButton.styleFrom(
    foregroundColor: primaryColor,
    padding: buttonPadding,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(radiusMedium),
    ),
  ),
  onPressed: onPressed,
  child: Text('Button Text', style: labelLarge),
)

// === Floating Action Button ===
FloatingActionButton.extended(
  onPressed: onPressed,
  backgroundColor: primaryColor,
  elevation: 4,
  icon: Icon(Icons.add, color: Colors.white),
  label: Text('Label', style: labelLarge.copyWith(color: Colors.white)),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(radiusLarge),
  ),
)
3. Input Fields
dart// === Text Field ===
TextField(
  decoration: InputDecoration(
    filled: true,
    fillColor: surfaceColor,
    hintText: 'Placeholder',
    hintStyle: bodyMedium.copyWith(color: textTertiary),
    prefixIcon: Icon(Icons.search, color: textSecondary, size: 20),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(radiusMedium),
      borderSide: BorderSide(color: Colors.transparent),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(radiusMedium),
      borderSide: BorderSide(color: Colors.transparent),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(radiusMedium),
      borderSide: BorderSide(color: primaryColor, width: 2),
    ),
    contentPadding: EdgeInsets.symmetric(horizontal: space16, vertical: space16),
  ),
  style: bodyLarge,
)
4. Progress Indicators
dart// === Linear Progress (XP Bar) ===
Container(
  height: 8,
  decoration: BoxDecoration(
    color: backgroundColor,
    borderRadius: BorderRadius.circular(radiusFull),
  ),
  child: ClipRRect(
    borderRadius: BorderRadius.circular(radiusFull),
    child: LinearProgressIndicator(
      value: progress,
      backgroundColor: Colors.transparent,
      valueColor: AlwaysStoppedAnimation(xpBlue),
    ),
  ),
)

// === Circular Progress Indicator ===
CircularProgressIndicator(
  valueColor: AlwaysStoppedAnimation(primaryColor),
  strokeWidth: 3,
)
5. Chips & Badges
dart// === Chip ===
Container(
  padding: EdgeInsets.symmetric(horizontal: space12, vertical: space8),
  decoration: BoxDecoration(
    color: primaryLight.withOpacity(0.2),
    borderRadius: BorderRadius.circular(radiusSmall),
  ),
  child: Text('Chip Label', style: labelSmall.copyWith(color: primaryDark)),
)

// === Badge ===
Container(
  padding: EdgeInsets.symmetric(horizontal: space8, vertical: space4),
  decoration: BoxDecoration(
    color: successGreen,
    borderRadius: BorderRadius.circular(radiusSmall),
  ),
  child: Text('NEW', style: badgeText),
)
Animation Requirements & Curves
dart// === Animation Durations ===
const durationFast = Duration(milliseconds: 150);     // Micro interactions
const durationNormal = Duration(milliseconds: 300);   // Standard transitions
const durationSlow = Duration(milliseconds: 500);     // Emphasis animations

// === Animation Curves (Material 3) ===
const curveEaseIn = Curves.easeIn;
const curveEaseOut = Curves.easeOut;
const curveEaseInOut = Curves.easeInOut;
const curveEmphasized = Cubic(0.2, 0.0, 0, 1.0);      // Material 3 emphasized
const curveStandard = Cubic(0.4, 0.0, 0.2, 1.0);      // Material 3 standard

// === Specific Animations ===
// XP Gain Animation
AnimatedContainer(
  duration: durationNormal,
  curve: curveEmphasized,
  transform: Matrix4.identity()..scale(isAnimating ? 1.1 : 1.0),
  child: xpWidget,
)

// Streak Update (Bounce)
TweenAnimationBuilder(
  tween: Tween<double>(begin: 0, end: 1),
  duration: durationSlow,
  curve: Curves.elasticOut,
  builder: (context, value, child) {
    return Transform.scale(scale: value, child: child);
  },
  child: streakIcon,
)

// Card Tap (Ripple + Scale)
InkWell(
  onTap: onTap,
  borderRadius: BorderRadius.circular(radiusMedium),
  splashColor: primaryLight.withOpacity(0.2),
  highlightColor: primaryLight.withOpacity(0.1),
  child: AnimatedScale(
    scale: isPressed ? 0.98 : 1.0,
    duration: durationFast,
    curve: curveStandard,
    child: cardContent,
  ),
)

// Level Up Modal (Fade + Scale)
AnimatedOpacity(
  opacity: showModal ? 1.0 : 0.0,
  duration: durationNormal,
  curve: curveEaseInOut,
  child: AnimatedScale(
    scale: showModal ? 1.0 : 0.8,
    duration: durationNormal,
    curve: curveEmphasized,
    child: levelUpDialog,
  ),
)
Icon System
dart// === Icon Sizes ===
const iconSmall = 16.0;
const iconMedium = 20.0;
const iconLarge = 24.0;
const iconXL = 32.0;
const iconXXL = 48.0;

// === Icon Colors ===
final iconPrimary = textPrimary;
final iconSecondary = textSecondary;
final iconTertiary = textTertiary;
final iconAccent = primaryColor;
AppBar & Navigation Styling
dart// === AppBar Style ===
AppBar(
  backgroundColor: Colors.white,
  elevation: 0,
  centerTitle: false,
  title: Text('Title', style: titleLarge),
  iconTheme: IconThemeData(color: textPrimary),
  systemOverlayStyle: SystemUiOverlayStyle.dark,
  bottom: PreferredSize(
    preferredSize: Size.fromHeight(1),
    child: Container(
      color: backgroundColor,
      height: 1,
    ),
  ),
)

// === Bottom Navigation Bar ===
BottomNavigationBar(
  backgroundColor: Colors.white,
  elevation: 8,
  type: BottomNavigationBarType.fixed,
  selectedItemColor: primaryColor,
  unselectedItemColor: textSecondary,
  selectedLabelStyle: labelSmall,
  unselectedLabelStyle: labelSmall,
  selectedFontSize: 12,
  unselectedFontSize: 12,
  items: [
    BottomNavigationBarItem(
      icon: Icon(Icons.home_outlined, size: iconLarge),
      activeIcon: Icon(Icons.home, size: iconLarge),
      label: 'Home',
    ),
    // ...
  ],
)

### C. LessonContentPage Components

#### 1. Notifier: LessonNotifier

**State:**
```dart
class LessonState {
  final ContentLesson? currentLesson;
  final bool isLoading;
  final bool isCompleted;
  final String? errorMessage;
}
```

**Methods:**
- `fetchLessonContent(String lessonId)`
- `markLessonAsCompleted(String userId, String lessonId)`
- `goToNextLesson()`

#### 2. Page UI:
- AppBar dengan progress indicator (Lesson X/Y)
- Content viewer (support markdown/HTML)
- Audio/Video player jika ada `audioUrl` atau `videoUrl`
- Bottom button: "Selesai & Lanjut Quiz"

---

### D. QuizPage Components

#### 1. Notifier: QuizNotifier

**State:**
```dart
class QuizState {
  final List<AssessmentQuestion> questions;
  final int currentQuestionIndex;
  final Map<int, int> userAnswers; // questionIndex -> selectedOptionIndex
  final bool isSubmitted;
  final int correctCount;
  final int totalXpEarned;
  final bool isLoading;
  final String? errorMessage;
}
```

**Methods:**
- `fetchQuizQuestions(String lessonId)`
- `selectAnswer(int questionIndex, int optionIndex)`
- `submitQuiz(String userId, String lessonId)`
- `goToNextQuestion()`
- `goToPreviousQuestion()`

#### 2. Page UI:
- Progress indicator: "Question X/Y"
- QuestionCard dengan pertanyaan
- List of OptionButton (4 pilihan)
- Navigation: Previous / Next button
- Submit button (muncul di pertanyaan terakhir)

---

### E. QuizResultPage

**UI Components:**
- Header: "Hasil Quiz" dengan icon trophy/medal
- Score display: "X/Y Benar"
- XP earned animation: "+50 XP"
- Button: "Lihat Pembahasan" (scroll ke list explanation)
- Button: "Kembali ke Kursus" (pop to CourseDetailPage)
- List jawaban dengan status benar/salah + explanation

---

### F. ProfilePage Components

#### 1. Notifier: ProfileNotifier

**State:**
```dart
class ProfileState {
  final UserProfile? user;
  final UserGameStats? stats;
  final List<UserAchievement> achievements;
  final bool isLoading;
  final String? errorMessage;
}
```

**Methods:**
- `fetchUserProfile(String userId)`
- `fetchUserStats(String userId)`
- `fetchUserAchievements(String userId)`
- `logout()`

#### 2. Widgets:

**StatsCard:**
- Total XP, Level, Current Streak, Lessons Completed, Quizzes Passed
- Grid layout 2x3

**BadgeGrid:**
- Grid of badges dengan status locked/unlocked
- Tap untuk lihat detail badge

**AchievementItem:**
- List tile untuk setiap achievement
- Badge icon, title, unlocked date

---

### G. LeaderboardPage Components

#### 1. Notifier: LeaderboardNotifier

**State:**
```dart
class LeaderboardState {
  final List<LeaderboardRank> weeklyRanks;
  final List<LeaderboardRank> monthlyRanks;
  final String selectedFilter; // 'WEEKLY' atau 'MONTHLY'
  final int? currentUserRank;
  final bool isLoading;
  final String? errorMessage;
}
```

**Methods:**
- `fetchLeaderboard(String rankType)`
- `switchFilter(String filter)`

#### 2. Page UI:
- Tab selector: Weekly / Monthly
- Current user rank card (highlighted)
- List of RankItem:
  - Rank number
  - User name + photo
  - XP score
  - Crown icon untuk top 3

---

## 🎨 Design Guidelines

### Color Palette (Islamic Theme)
```dart
// Primary Colors
final primaryGreen = Color(0xFF00A884); // Islamic green
final accentGold = Color(0xFFFFD700);
final darkBlue = Color(0xFF1E3A5F);

// Gamification Colors
final xpBlue = Color(0xFF4A90E2);
final streakOrange = Color(0xFFFF6B35);
final badgeYellow = Color(0xFFFFCA28);
```

### Typography
- Title: `GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold)`
- Body: `GoogleFonts.inter(fontSize: 16)`
- Caption: `GoogleFonts.inter(fontSize: 12, color: Colors.grey)`

### Animation Requirements
- XP gain: `AnimatedContainer` dengan scale animation
- Level up: Modal dialog dengan confetti effect
- Streak update: Bounce animation pada streak icon
- Card tap: Ripple effect + scale transform

---

## 🔧 Implementation Guidelines

### Setup Provider di main.dart
```dart
void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthNotifier()),
        ChangeNotifierProvider(create: (_) => HomeNotifier()),
        ChangeNotifierProvider(create: (_) => CourseNotifier()),
        ChangeNotifierProvider(create: (_) => LessonNotifier()),
        ChangeNotifierProvider(create: (_) => QuizNotifier()),
        ChangeNotifierProvider(create: (_) => ProfileNotifier()),
        ChangeNotifierProvider(create: (_) => LeaderboardNotifier()),
      ],
      child: MyApp(),
    ),
  );
}
```

### State Pattern Template
Setiap Notifier harus mengikuti pattern ini:
```dart
class MyNotifier extends ChangeNotifier {
  MyState _state = MyState.initial();
  MyState get state => _state;

  Future<void> loadData() async {
    _state = MyState.loading();
    notifyListeners();

    final result = await _useCase.call(params);
    
    result.fold(
      (failure) {
        _state = MyState.error(failure.message);
        notifyListeners();
      },
      (data) {
        _state = MyState.loaded(data);
        notifyListeners();
      },
    );
  }
}
```

### Page Template dengan Consumer
```dart
class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Title')),
      body: Consumer<MyNotifier>(
        builder: (context, notifier, child) {
          final state = notifier.state;
          
          if (state.isLoading) {
            return Center(child: CircularProgressIndicator());
          }
          
          if (state.errorMessage != null) {
            return Center(child: Text('Error: ${state.errorMessage}'));
          }
          
          return _buildContent(state);
        },
      ),
    );
  }
}
```

---

## 📱 Testing Scenarios

### Manual Testing Checklist:
- [ ] Login/Register flow berfungsi
- [ ] HomePage menampilkan streak & XP dengan benar
- [ ] Course modules ter-lock/unlock sesuai requiredXpToUnlock
- [ ] Lesson content tampil lengkap
- [ ] Quiz flow: jawab → submit → lihat hasil
- [ ] XP bertambah setelah selesai quiz
- [ ] Streak bertambah jika login di hari berbeda
- [ ] Profile menampilkan stats & badges
- [ ] Leaderboard sorting by XP
- [ ] Logout menghapus session

---

## 🚀 Priority Order

### Phase 1 (MVP):
- Auth Flow (Splash, Login, Register)
- HomePage dengan StreakCard & CourseModuleCard
- CourseDetailPage dengan LessonUnitCard

### Phase 2:
- LessonContentPage dengan content viewer
- QuizPage dengan question navigation
- QuizResultPage dengan XP animation

### Phase 3:
- ProfilePage dengan stats & badges
- LeaderboardPage dengan filtering

---

## 📝 Best Practices

### Performance Optimization:
- Gunakan `Selector` untuk widget yang hanya perlu rebuild saat specific field berubah
- Implementasikan `const` constructor untuk widget yang tidak berubah
- Lazy load images dengan `CachedNetworkImage`
- Debounce user input untuk form validation

### Error Handling:
- Tampilkan loading indicators untuk setiap async operation
- Tampilkan error messages yang user-friendly
- Implementasikan retry mechanism untuk failed requests
- Handle offline mode dengan menampilkan cached data

### Code Quality:
- Setiap notifier harus melakukan `notifyListeners()` setelah state berubah
- Gunakan named parameters untuk constructor
- Implementasikan proper disposal untuk controller dan listener
- Tambahkan empty state untuk list yang kosong
- Gunakan meaningful variable names

---

## 🎯 Deliverables

1. **Semua file notifier** dengan implementasi lengkap state management
2. **Semua page** dengan UI sesuai design guidelines
3. **Semua reusable widget** yang telah didefinisikan
4. **Navigation routing** yang terintegrasi
5. **Provider setup** di main.dart
6. **Testing checklist** yang telah diverifikasi

---

**Mulai implementasi dari Phase 1, pastikan setiap component terintegrasi dengan Domain & Data layer yang sudah ada!** 🎯