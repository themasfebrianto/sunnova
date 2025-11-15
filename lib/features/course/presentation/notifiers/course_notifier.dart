import 'package:flutter/material.dart';
import 'package:sunnova_app/features/course/domain/entities/user_lesson_progress_entity.dart';
import 'package:sunnova_app/features/course/domain/usecases/get_course_detail.dart';
import 'package:sunnova_app/features/course/domain/usecases/get_lesson_units.dart';
import 'package:sunnova_app/features/course/domain/usecases/get_user_lesson_progress.dart';
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
  }) => CourseState(
    selectedModule: selectedModule ?? this.selectedModule,
    units: units ?? this.units,
    progressMap: progressMap ?? this.progressMap,
    isLoading: false,
  );

  // Error state
  CourseState error(String message) =>
      CourseState(errorMessage: message, isLoading: false);
}

class CourseNotifier extends ChangeNotifier {
  final GetCourseDetail getCourseDetail;
  final GetLessonUnits getLessonUnits;
  final GetUserLessonProgress getUserLessonProgress;

  CourseNotifier({
    required this.getCourseDetail,
    required this.getLessonUnits,
    required this.getUserLessonProgress,
  });

  CourseState _state = CourseState.initial();
  CourseState get state => _state;

  // Placeholder methods
  Future<void> loadCourseDetail(String moduleId) async {
    _state = _state.loading();
    notifyListeners();

    final result = await getCourseDetail(GetCourseDetailParams(moduleId: moduleId));

    result.fold(
      (failure) {
        _state = _state.error(failure.message ?? 'An unknown error occurred');
        notifyListeners();
      },
      (module) {
        _state = _state.loaded(selectedModule: module);
        notifyListeners();
      },
    );
  }

  Future<void> loadLessonUnits(String moduleId, String userId) async {
    _state = _state.loading();
    notifyListeners();

    final result = await getLessonUnits(GetLessonUnitsParams(moduleId: moduleId, userId: userId));

    result.fold(
      (failure) {
        _state = _state.error(failure.message ?? 'An unknown error occurred');
        notifyListeners();
      },
      (units) {
        _state = _state.loaded(units: units);
        notifyListeners();
      },
    );
  }

  Future<void> loadUserProgress(String userId, String moduleId) async {
    _state = _state.loading();
    notifyListeners();

    final unitsResult = await getLessonUnits(GetLessonUnitsParams(moduleId: moduleId, userId: userId));

    await unitsResult.fold(
      (failure) {
        _state = _state.error(failure.message ?? 'An unknown error occurred');
      },
      (units) async {
        final Map<String, UserLessonProgressEntity> progressMap = {};
        bool hasError = false; // Flag to track if any individual progress fetch failed
        for (var unit in units) {
          final progressResult = await getUserLessonProgress(GetUserLessonProgressParams(userId: userId, lessonId: unit.id));
          progressResult.fold(
            (failure) {
              hasError = true; // Mark that an error occurred
              // Optionally, you could still add a default uncompleted state here if desired,
              // but for this test, we want to ensure the overall state is error if any sub-fetch fails.
            },
            (progress) {
              progressMap[unit.id] = progress;
            },
          );
        }

        if (hasError) {
          _state = _state.error('Failed to fetch some lesson progress.');
        } else {
          _state = _state.loaded(units: units, progressMap: progressMap);
        }
      },
    );
    notifyListeners();
  }
}
