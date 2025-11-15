import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sunnova_app/core/error/failures.dart';
import 'package:sunnova_app/features/course/domain/entities/lesson_unit_entity.dart';
import 'package:sunnova_app/features/course/domain/usecases/get_course_detail.dart';
import 'package:sunnova_app/features/course/domain/usecases/get_lesson_content.dart';
import 'package:sunnova_app/features/course/domain/usecases/get_lesson_units.dart';
import 'package:sunnova_app/features/course/domain/usecases/get_user_lesson_progress.dart';
import 'package:sunnova_app/features/course/domain/usecases/mark_lesson_as_completed.dart';
import 'package:sunnova_app/features/course/presentation/notifiers/lesson_notifier.dart';

import 'lesson_notifier_test.mocks.dart';

@GenerateMocks([
  GetLessonContent,
  MarkLessonAsCompleted,
  GetCourseDetail,
  GetLessonUnits,
  GetUserLessonProgress
])
void main() {
  late LessonNotifier lessonNotifier;
  late MockGetLessonContent mockGetLessonContent;
  late MockMarkLessonAsCompleted mockMarkLessonAsCompleted;
  late MockGetCourseDetail mockGetCourseDetail;
  late MockGetLessonUnits mockGetLessonUnits;
  late MockGetUserLessonProgress mockGetUserLessonProgress;

  setUp(() {
    mockGetLessonContent = MockGetLessonContent();
    mockMarkLessonAsCompleted = MockMarkLessonAsCompleted();
    mockGetCourseDetail = MockGetCourseDetail();
    mockGetLessonUnits = MockGetLessonUnits();
    mockGetUserLessonProgress = MockGetUserLessonProgress();
    lessonNotifier = LessonNotifier(
      getLessonContent: mockGetLessonContent,
      markLessonAsCompleted: mockMarkLessonAsCompleted,
      getCourseDetail: mockGetCourseDetail,
      getLessonUnits: mockGetLessonUnits,
      getUserLessonProgress: mockGetUserLessonProgress,
    );
  });

  final tLessonUnit = LessonUnitEntity(
    id: 'lesson_1',
    title: 'Introduction to Tajwid',
    description: 'Understand the importance of Tajwid.',
    content: 'This is the content of the lesson. It can be **Markdown** or HTML.',
    videoUrl: null,
    audioUrl: null,
    durationMinutes: 15,
  );

  group('loadLessonContent', () {
    const tLessonId = 'lesson_1';

    test(
      'should set state to loading and then loaded with lesson content on successful fetch',
      () async {
        // arrange
        when(mockGetLessonContent(any))
            .thenAnswer((_) async => Right(tLessonUnit));
        // act
        await lessonNotifier.loadLessonContent(tLessonId);
        // assert
        expect(lessonNotifier.state.isLoading, false);
        expect(lessonNotifier.state.currentLesson, tLessonUnit);
        expect(lessonNotifier.state.errorMessage, null);
        verify(mockGetLessonContent(GetLessonContentParams(lessonId: tLessonId)));
        verifyNoMoreInteractions(mockGetLessonContent);
      },
    );

    test(
      'should set state to loading and then error on failed fetch',
      () async {
        // arrange
        when(mockGetLessonContent(any))
            .thenAnswer((_) async => Left(DatabaseFailure('Error')));
        // act
        await lessonNotifier.loadLessonContent(tLessonId);
        // assert
        expect(lessonNotifier.state.isLoading, false);
        expect(lessonNotifier.state.currentLesson, null);
        expect(lessonNotifier.state.errorMessage, 'Error');
        verify(mockGetLessonContent(GetLessonContentParams(lessonId: tLessonId)));
        verifyNoMoreInteractions(mockGetLessonContent);
      },
    );
  });

  group('completeLesson', () {
    const tUserId = 'user_1';
    const tLessonId = 'lesson_1';

    test(
      'should set state to loading and then completed on successful mark',
      () async {
        // arrange
        when(mockMarkLessonAsCompleted(any))
            .thenAnswer((_) async => const Right(null));
        // act
        await lessonNotifier.completeLesson(tUserId, tLessonId);
        // assert
        expect(lessonNotifier.state.isLoading, false);
        expect(lessonNotifier.state.isCompleted, true);
        expect(lessonNotifier.state.errorMessage, null);
        verify(mockMarkLessonAsCompleted(MarkLessonAsCompletedParams(userId: tUserId, lessonId: tLessonId)));
        verifyNoMoreInteractions(mockMarkLessonAsCompleted);
      },
    );

    test(
      'should set state to loading and then error on failed mark',
      () async {
        // arrange
        when(mockMarkLessonAsCompleted(any))
            .thenAnswer((_) async => Left(DatabaseFailure('Error')));
        // act
        await lessonNotifier.completeLesson(tUserId, tLessonId);
        // assert
        expect(lessonNotifier.state.isLoading, false);
        expect(lessonNotifier.state.isCompleted, false);
        expect(lessonNotifier.state.errorMessage, 'Error');
        verify(mockMarkLessonAsCompleted(MarkLessonAsCompletedParams(userId: tUserId, lessonId: tLessonId)));
        verifyNoMoreInteractions(mockMarkLessonAsCompleted);
      },
    );
  });
}
