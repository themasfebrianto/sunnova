import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sunnova_app/core/error/failures.dart';
import 'package:sunnova_app/features/course/domain/entities/lesson_unit_entity.dart';
import 'package:sunnova_app/features/course/domain/entities/user_lesson_progress_entity.dart';
import 'package:sunnova_app/features/course/domain/usecases/get_course_detail.dart';
import 'package:sunnova_app/features/course/domain/usecases/get_lesson_units.dart';
import 'package:sunnova_app/features/course/domain/usecases/get_user_lesson_progress.dart';
import 'package:sunnova_app/features/course/presentation/notifiers/course_notifier.dart';
import 'package:sunnova_app/features/home/domain/entities/course_module_entity.dart';

import 'course_notifier_test.mocks.dart';

@GenerateMocks([GetCourseDetail, GetLessonUnits, GetUserLessonProgress])
void main() {
  late CourseNotifier courseNotifier;
  late MockGetCourseDetail mockGetCourseDetail;
  late MockGetLessonUnits mockGetLessonUnits;
  late MockGetUserLessonProgress mockGetUserLessonProgress;

  setUp(() {
    mockGetCourseDetail = MockGetCourseDetail();
    mockGetLessonUnits = MockGetLessonUnits();
    mockGetUserLessonProgress = MockGetUserLessonProgress();
    courseNotifier = CourseNotifier(
      getCourseDetail: mockGetCourseDetail,
      getLessonUnits: mockGetLessonUnits,
      getUserLessonProgress: mockGetUserLessonProgress,
    );
  });

  final tCourseModule = CourseModuleEntity(
    id: 'mod1',
    title: 'Test Module',
    description: 'Test Description',
    imageUrl: 'test.png',
    requiredXpToUnlock: 0,
    isLocked: false,
    totalLessons: 5,
    completedLessons: 0,
  );

  final tLessonUnit = LessonUnitEntity(
    id: 'lesson_1',
    title: 'Test Lesson',
    description: 'Test Description',
    content: 'Test Content',
    durationMinutes: 10,
  );
  final tLessonUnitList = [tLessonUnit];

  final tUserLessonProgress = UserLessonProgressEntity(
    userId: 'user_1',
    lessonId: 'lesson_1',
    isCompleted: true,
    completedAt: DateTime.now(),
  );

  group('loadCourseDetail', () {
    const tModuleId = 'module_1';

    test(
      'should set state to loading and then loaded with course detail on successful fetch',
      () async {
        // arrange
        when(
          mockGetCourseDetail(any),
        ).thenAnswer((_) async => Right(tCourseModule));
        // act
        await courseNotifier.loadCourseDetail(tModuleId);
        // assert
        expect(courseNotifier.state.isLoading, false);
        expect(courseNotifier.state.selectedModule, tCourseModule);
        expect(courseNotifier.state.errorMessage, null);
        verify(mockGetCourseDetail(GetCourseDetailParams(moduleId: tModuleId)));
        verifyNoMoreInteractions(mockGetCourseDetail);
      },
    );

    test(
      'should set state to loading and then error on failed fetch',
      () async {
        // arrange
        when(
          mockGetCourseDetail(any),
        ).thenAnswer((_) async => Left(DatabaseFailure('Error')));
        // act
        await courseNotifier.loadCourseDetail(tModuleId);
        // assert
        expect(courseNotifier.state.isLoading, false);
        expect(courseNotifier.state.selectedModule, null);
        expect(courseNotifier.state.errorMessage, 'Error');
        verify(mockGetCourseDetail(GetCourseDetailParams(moduleId: tModuleId)));
        verifyNoMoreInteractions(mockGetCourseDetail);
      },
    );
  });

  group('loadLessonUnits', () {
    const tModuleId = 'module_1';
    const tUserId = 'user_1'; // Define tUserId here

    test(
      'should set state to loading and then loaded with lesson units on successful fetch',
      () async {
        // arrange
        when(
          mockGetLessonUnits(any),
        ).thenAnswer((_) async => Right(tLessonUnitList));
        // act
        await courseNotifier.loadLessonUnits(tModuleId, tUserId);
        // assert
        expect(courseNotifier.state.isLoading, false);
        expect(courseNotifier.state.units, tLessonUnitList);
        expect(courseNotifier.state.errorMessage, null);
        verify(
          mockGetLessonUnits(
            GetLessonUnitsParams(moduleId: tModuleId, userId: tUserId),
          ),
        );
        verifyNoMoreInteractions(mockGetLessonUnits);
      },
    );

    test(
      'should set state to loading and then error on failed fetch',
      () async {
        // arrange
        when(
          mockGetLessonUnits(any),
        ).thenAnswer((_) async => Left(DatabaseFailure('Error')));
        // act
        await courseNotifier.loadLessonUnits(tModuleId, tUserId);
        // assert
        expect(courseNotifier.state.isLoading, false);
        expect(courseNotifier.state.units, []);
        expect(courseNotifier.state.errorMessage, 'Error');
        verify(
          mockGetLessonUnits(
            GetLessonUnitsParams(moduleId: tModuleId, userId: tUserId),
          ),
        );
        verifyNoMoreInteractions(mockGetLessonUnits);
      },
    );
  });

  group('loadUserProgress', () {
    const tUserId = 'user_1';
    const tModuleId = 'module_1';

    test(
      'should set state to loading and then loaded with user progress on successful fetch',
      () async {
        // arrange
        when(
          mockGetLessonUnits(any),
        ).thenAnswer((_) async => Right(tLessonUnitList));
        when(
          mockGetUserLessonProgress(any),
        ).thenAnswer((_) async => Right(tUserLessonProgress));
        // act
        await courseNotifier.loadUserProgress(tUserId, tModuleId);
        // assert
        expect(courseNotifier.state.isLoading, false);
        expect(
          courseNotifier.state.progressMap[tLessonUnit.id],
          tUserLessonProgress,
        );
        expect(courseNotifier.state.errorMessage, null);
        verify(
          mockGetLessonUnits(
            GetLessonUnitsParams(moduleId: tModuleId, userId: tUserId),
          ),
        );
        verify(
          mockGetUserLessonProgress(
            GetUserLessonProgressParams(
              userId: tUserId,
              lessonId: tLessonUnit.id,
            ),
          ),
        );
        verifyNoMoreInteractions(mockGetLessonUnits);
        verifyNoMoreInteractions(mockGetUserLessonProgress);
      },
    );

    test(
      'should set state to loading and then error on failed fetch of lesson units',
      () async {
        // arrange
        when(
          mockGetLessonUnits(any),
        ).thenAnswer((_) async => Left(DatabaseFailure('Error')));
        // act
        await courseNotifier.loadUserProgress(tUserId, tModuleId);
        // assert
        expect(courseNotifier.state.isLoading, false);
        expect(courseNotifier.state.progressMap, {});
        expect(courseNotifier.state.errorMessage, 'Error');
        verify(
          mockGetLessonUnits(
            GetLessonUnitsParams(moduleId: tModuleId, userId: tUserId),
          ),
        );
        verifyNoMoreInteractions(mockGetLessonUnits);
        verifyZeroInteractions(mockGetUserLessonProgress);
      },
    );

    test(
      'should set state to loading and then error on failed fetch of user lesson progress',
      () async {
        // arrange
        when(
          mockGetLessonUnits(any),
        ).thenAnswer((_) async => Right(tLessonUnitList));
        when(
          mockGetUserLessonProgress(any),
        ).thenAnswer((_) async => Left(DatabaseFailure('Error')));
        // act
        await courseNotifier.loadUserProgress(tUserId, tModuleId);
        // assert
        expect(courseNotifier.state.isLoading, false);
        expect(courseNotifier.state.progressMap, {});
        expect(courseNotifier.state.errorMessage, 'Failed to fetch some lesson progress.');
        verify(
          mockGetLessonUnits(
            GetLessonUnitsParams(moduleId: tModuleId, userId: tUserId),
          ),
        );
        verify(
          mockGetUserLessonProgress(
            GetUserLessonProgressParams(
              userId: tUserId,
              lessonId: tLessonUnit.id,
            ),
          ),
        );
        verifyNoMoreInteractions(mockGetLessonUnits);
        verifyNoMoreInteractions(mockGetUserLessonProgress);
      },
    );
  });
}
