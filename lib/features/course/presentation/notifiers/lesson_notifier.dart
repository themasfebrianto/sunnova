import 'package:flutter/material.dart';
import 'package:sunnova_app/features/course/domain/entities/lesson_unit_entity.dart'; // Import LessonUnitEntity
import 'package:sunnova_app/features/course/domain/usecases/get_course_detail.dart';
import 'package:sunnova_app/features/course/domain/usecases/get_lesson_content.dart';
import 'package:sunnova_app/features/course/domain/usecases/get_lesson_units.dart';
import 'package:sunnova_app/features/course/domain/usecases/get_user_lesson_progress.dart';
import 'package:sunnova_app/features/course/domain/usecases/mark_lesson_as_completed.dart';

// Define LessonState
class LessonState {
  final LessonUnitEntity? currentLesson;
  final bool isLoading;
  final bool isCompleted;
  final String? errorMessage;

  LessonState({
    this.currentLesson,
    this.isLoading = false,
    this.isCompleted = false,
    this.errorMessage,
  });

  // Initial state
  factory LessonState.initial() => LessonState();

  // Loading state
  LessonState loading() => LessonState(isLoading: true);

  // Loaded state
  LessonState loaded({LessonUnitEntity? currentLesson, bool? isCompleted}) =>
      LessonState(
        currentLesson: currentLesson ?? this.currentLesson,
        isCompleted: isCompleted ?? this.isCompleted,
        isLoading: false,
      );

  // Error state
  LessonState error(String message) =>
      LessonState(errorMessage: message, isLoading: false);
}

class LessonNotifier extends ChangeNotifier {
  final GetCourseDetail getCourseDetail;
  final GetLessonUnits getLessonUnits;
  final GetUserLessonProgress getUserLessonProgress;
  final MarkLessonAsCompleted markLessonAsCompleted;
  final GetLessonContent getLessonContent;

  LessonNotifier({
    required this.getCourseDetail,
    required this.getLessonUnits,
    required this.getUserLessonProgress,
    required this.markLessonAsCompleted,
    required this.getLessonContent,
  });

  LessonState _state = LessonState.initial();
  LessonState get state => _state;

  // Placeholder methods
  Future<void> loadLessonContent(String lessonId) async {
    _state = _state.loading();
    notifyListeners();

    final result = await getLessonContent(GetLessonContentParams(lessonId: lessonId));

    result.fold(
      (failure) {
        _state = _state.error(failure.message ?? 'Failed to fetch lesson content');
        notifyListeners();
      },
      (lesson) {
        _state = _state.loaded(currentLesson: lesson);
        notifyListeners();
      },
    );
  }

  Future<void> completeLesson(String userId, String lessonId) async {
    _state = _state.loading();
    notifyListeners();

    final result = await markLessonAsCompleted(MarkLessonAsCompletedParams(
      userId: userId,
      lessonId: lessonId,
    ));

    result.fold(
      (failure) {
        _state = _state.error(failure.message ?? 'Failed to mark lesson as completed');
        notifyListeners();
      },
      (_) {
        _state = _state.loaded(isCompleted: true);
        notifyListeners();
      },
    );
  }

  Future<void> goToNextLesson() async {
    // Implement logic to navigate to the next lesson
  }
}
