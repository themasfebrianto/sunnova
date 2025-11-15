import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sunnova_app/core/error/failures.dart';
import 'package:sunnova_app/features/course/domain/entities/lesson_unit_entity.dart';
import 'package:sunnova_app/features/course/domain/entities/user_lesson_progress_entity.dart';
import 'package:sunnova_app/features/course/domain/repositories/course_repository.dart';
import 'package:sunnova_app/features/course/domain/usecases/get_course_detail.dart';
import 'package:sunnova_app/features/course/domain/usecases/get_lesson_units.dart';
import 'package:sunnova_app/features/course/domain/usecases/get_user_lesson_progress.dart';
import 'package:sunnova_app/features/course/domain/usecases/mark_lesson_as_completed.dart';
import 'package:sunnova_app/features/home/domain/entities/course_module_entity.dart';

import 'course_usecases_test.mocks.dart';

@GenerateMocks([CourseRepository])
void main() {
  late GetCourseDetail getCourseDetail;
  late GetLessonUnits getLessonUnits;
  late GetUserLessonProgress getUserLessonProgress;
  late MarkLessonAsCompleted markLessonAsCompleted;
  late MockCourseRepository mockCourseRepository;

  setUp(() {
    mockCourseRepository = MockCourseRepository();
    getCourseDetail = GetCourseDetail(mockCourseRepository);
    getLessonUnits = GetLessonUnits(mockCourseRepository);
    getUserLessonProgress = GetUserLessonProgress(mockCourseRepository);
    markLessonAsCompleted = MarkLessonAsCompleted(mockCourseRepository);
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

  group('GetCourseDetail', () {
    const tModuleId = 'module_1';

    test('should get course detail from the repository', () async {
      // arrange
      when(
        mockCourseRepository.getCourseDetail(tModuleId),
      ).thenAnswer((_) async => Right(tCourseModule));
      // act
      final result = await getCourseDetail(
        GetCourseDetailParams(moduleId: tModuleId),
      );
      // assert
      expect(result, Right(tCourseModule));
      verify(mockCourseRepository.getCourseDetail(tModuleId));
      verifyNoMoreInteractions(mockCourseRepository);
    });

    test(
      'should return failure when getting course detail is unsuccessful',
      () async {
        // arrange
        when(
          mockCourseRepository.getCourseDetail(tModuleId),
        ).thenAnswer((_) async => Left(DatabaseFailure('Error')));
        // act
        final result = await getCourseDetail(
          GetCourseDetailParams(moduleId: tModuleId),
        );
        // assert
        expect(result, Left(DatabaseFailure('Error')));
        verify(mockCourseRepository.getCourseDetail(tModuleId));
        verifyNoMoreInteractions(mockCourseRepository);
      },
    );
  });

  group('GetLessonUnits', () {
    const tModuleId = 'module_1';

    test('should get lesson units from the repository', () async {
      // arrange
      when(
        mockCourseRepository.getLessonUnits(tModuleId, ''),
      ).thenAnswer((_) async => Right(tLessonUnitList));
      // act
      final result = await getLessonUnits(
        GetLessonUnitsParams(moduleId: tModuleId, userId: ''),
      );
      // assert
      expect(result, Right(tLessonUnitList));
      verify(mockCourseRepository.getLessonUnits(tModuleId, ''));
      verifyNoMoreInteractions(mockCourseRepository);
    });

    test(
      'should return failure when getting lesson units is unsuccessful',
      () async {
        // arrange
        when(
          mockCourseRepository.getLessonUnits(tModuleId, ''),
        ).thenAnswer((_) async => Left(DatabaseFailure('Error')));
        // act
        final result = await getLessonUnits(
          GetLessonUnitsParams(moduleId: tModuleId, userId: ''),
        );
        // assert
        expect(result, Left(DatabaseFailure('Error')));
        verify(mockCourseRepository.getLessonUnits(tModuleId, ''));
        verifyNoMoreInteractions(mockCourseRepository);
      },
    );
  });

  group('GetUserLessonProgress', () {
    const tUserId = 'user_1';
    const tLessonId = 'lesson_1';

    test('should get user lesson progress from the repository', () async {
      // arrange
      when(
        mockCourseRepository.getUserLessonProgress(tUserId, tLessonId),
      ).thenAnswer((_) async => Right(tUserLessonProgress));
      // act
      final result = await getUserLessonProgress(
        GetUserLessonProgressParams(userId: tUserId, lessonId: tLessonId),
      );
      // assert
      expect(result, Right(tUserLessonProgress));
      verify(mockCourseRepository.getUserLessonProgress(tUserId, tLessonId));
      verifyNoMoreInteractions(mockCourseRepository);
    });

    test(
      'should return failure when getting user lesson progress is unsuccessful',
      () async {
        // arrange
        when(
          mockCourseRepository.getUserLessonProgress(tUserId, tLessonId),
        ).thenAnswer((_) async => Left(DatabaseFailure('Error')));
        // act
        final result = await getUserLessonProgress(
          GetUserLessonProgressParams(userId: tUserId, lessonId: tLessonId),
        );
        // assert
        expect(result, Left(DatabaseFailure('Error')));
        verify(mockCourseRepository.getUserLessonProgress(tUserId, tLessonId));
        verifyNoMoreInteractions(mockCourseRepository);
      },
    );
  });

  group('MarkLessonAsCompleted', () {
    const tUserId = 'user_1';
    const tLessonId = 'lesson_1';

    test('should mark lesson as completed in the repository', () async {
      // arrange
      when(
        mockCourseRepository.markLessonAsCompleted(tUserId, tLessonId),
      ).thenAnswer((_) async => const Right(null));
      // act
      final result = await markLessonAsCompleted(
        MarkLessonAsCompletedParams(userId: tUserId, lessonId: tLessonId),
      );
      // assert
      expect(result, const Right(null));
      verify(mockCourseRepository.markLessonAsCompleted(tUserId, tLessonId));
      verifyNoMoreInteractions(mockCourseRepository);
    });

    test(
      'should return failure when marking lesson as completed is unsuccessful',
      () async {
        // arrange
        when(
          mockCourseRepository.markLessonAsCompleted(tUserId, tLessonId),
        ).thenAnswer((_) async => Left(DatabaseFailure('Error')));
        // act
        final result = await markLessonAsCompleted(
          MarkLessonAsCompletedParams(userId: tUserId, lessonId: tLessonId),
        );
        // assert
        expect(result, Left(DatabaseFailure('Error')));
        verify(mockCourseRepository.markLessonAsCompleted(tUserId, tLessonId));
        verifyNoMoreInteractions(mockCourseRepository);
      },
    );
  });
}
