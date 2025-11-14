import 'package:flutter/material.dart';
import 'package:sunnova_app/features/home/domain/entities/course_module_entity.dart'; // Import CourseModuleEntity
import 'package:sunnova_app/features/course/domain/entities/lesson_unit_entity.dart'; // Import LessonUnitEntity and UserLessonProgressEntity

// Define CourseState
class CourseState {
  final CourseModuleEntity? selectedModule;
  final List<LessonUnitEntity> units;
  final Map<String, UserLessonProgressEntity> progressMap;
  final bool isLoading;
  final String? errorMessage;

  CourseState({
    this.selectedModule,
    this.units = const [],
    this.progressMap = const {},
    this.isLoading = false,
    this.errorMessage,
  });

  // Initial state
  factory CourseState.initial() => CourseState();

  // Loading state
  CourseState loading() => CourseState(isLoading: true);

  // Loaded state
  CourseState loaded({
    CourseModuleEntity? selectedModule,
    List<LessonUnitEntity>? units,
    Map<String, UserLessonProgressEntity>? progressMap,
  }) =>
      CourseState(
        selectedModule: selectedModule ?? this.selectedModule,
        units: units ?? this.units,
        progressMap: progressMap ?? this.progressMap,
        isLoading: false,
      );

  // Error state
  CourseState error(String message) => CourseState(
        errorMessage: message,
        isLoading: false,
      );
}

class CourseNotifier extends ChangeNotifier {
  CourseState _state = CourseState.initial();
  CourseState get state => _state;

  // Placeholder methods
  Future<void> fetchCourseDetail(String moduleId) async {
    _state = _state.loading();
    notifyListeners();
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));
    _state = _state.loaded(
      selectedModule: CourseModuleEntity(
        id: moduleId,
        title: 'Tajwid Basic',
        description: 'Learn the basics of Tajwid.',
        imageUrl: 'https://via.placeholder.com/150',
        requiredXpToUnlock: 0,
        isLocked: false,
        totalLessons: 10,
        completedLessons: 3,
      ),
    );
    notifyListeners();
  }

  Future<void> fetchLessonUnits(String moduleId) async {
    _state = _state.loading();
    notifyListeners();
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));
    _state = _state.loaded(
      units: [
        LessonUnitEntity(
          id: 'lesson_1',
          title: 'Introduction to Tajwid',
          description: 'Understand the importance of Tajwid.',
          content: 'Content for lesson 1',
          durationMinutes: 15,
        ),
        LessonUnitEntity(
          id: 'lesson_2',
          title: 'Makharij al-Huruf',
          description: 'Learn the points of articulation.',
          content: 'Content for lesson 2',
          durationMinutes: 20,
        ),
        LessonUnitEntity(
          id: 'lesson_3',
          title: 'Sifat al-Huruf',
          description: 'Explore the characteristics of letters.',
          content: 'Content for lesson 3',
          durationMinutes: 25,
        ),
      ],
    );
    notifyListeners();
  }

  Future<void> fetchUserProgress(String userId, String moduleId) async {
    _state = _state.loading();
    notifyListeners();
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));
    _state = _state.loaded(
      progressMap: {
        'lesson_1': UserLessonProgressEntity(userId: userId, lessonId: 'lesson_1', isCompleted: true),
        'lesson_2': UserLessonProgressEntity(userId: userId, lessonId: 'lesson_2', isCompleted: false),
        'lesson_3': UserLessonProgressEntity(userId: userId, lessonId: 'lesson_3', isCompleted: false),
      },
    );
    notifyListeners();
  }
}