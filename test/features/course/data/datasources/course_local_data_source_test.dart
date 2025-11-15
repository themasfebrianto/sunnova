import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sunnova_app/core/db/database_helper.dart';
import 'package:sunnova_app/core/error/exceptions.dart' as app_exceptions;
import 'package:sunnova_app/features/course/data/datasources/course_local_data_source.dart';
import 'package:sunnova_app/features/home/data/models/course_module_model.dart';
import 'package:sunnova_app/features/course/data/models/lesson_unit_model.dart';
import 'package:sunnova_app/features/course/data/models/user_lesson_progress_model.dart';

import 'course_local_data_source_test.mocks.dart';

@GenerateMocks([DatabaseHelper])
void main() {
  late CourseLocalDataSourceImpl dataSource;
  late MockDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
    dataSource = CourseLocalDataSourceImpl(databaseHelper: mockDatabaseHelper);
  });

  group('getCourseDetail', () {
    const tModuleId = 'module_1';
    final tCourseModuleModel = CourseModuleModel(
      id: tModuleId,
      title: 'Test Module',
      description: 'Test Description',
      imageUrl: 'test.png',
      requiredXpToUnlock: 0,
      isLocked: false,
      totalLessons: 5,
      completedLessons: 0,
    );

    test('should return CourseModuleModel when data is found', () async {
      // arrange
      when(
        mockDatabaseHelper.getCourseModule(tModuleId),
      ).thenAnswer((_) async => tCourseModuleModel.toMap());
      // act
      final result = await dataSource.getCourseDetail(tModuleId);
      // assert
      expect(result, tCourseModuleModel);
      verify(mockDatabaseHelper.getCourseModule(tModuleId));
    });

    test('should throw DatabaseException when data is not found', () async {
      // arrange
      when(
        mockDatabaseHelper.getCourseModule(tModuleId),
      ).thenAnswer((_) async => null);
      // act
      final call = dataSource.getCourseDetail;
      // assert
      expect(
        () => call(tModuleId),
        throwsA(isA<app_exceptions.DatabaseException>()),
      );
      verify(mockDatabaseHelper.getCourseModule(tModuleId));
    });

    test(
      'should throw DatabaseException when database operation fails',
      () async {
        // arrange
        when(
          mockDatabaseHelper.getCourseModule(tModuleId),
        ).thenThrow(Exception());
        // act
        final call = dataSource.getCourseDetail;
        // assert
        expect(
          () => call(tModuleId),
          throwsA(isA<app_exceptions.DatabaseException>()),
        );
        verify(mockDatabaseHelper.getCourseModule(tModuleId));
      },
    );
  });

  group('getLessonUnits', () {
    const tModuleId = 'module_1';
    final tLessonUnitModel = LessonUnitModel(
      id: 'lesson_1',
      title: 'Test Lesson',
      description: 'Test Description',
      content: 'Test Content',
      durationMinutes: 10,
      moduleId: tModuleId,
      order: 1,
    );
    final tLessonUnitList = [tLessonUnitModel];

    test('should return List<LessonUnitModel> when data is found', () async {
      // arrange
      when(
        mockDatabaseHelper.getLessonUnitsByModuleId(tModuleId),
      ).thenAnswer((_) async => [tLessonUnitModel.toMap()]);
      // act
      final result = await dataSource.getLessonUnits(tModuleId, '');
      // assert
      expect(result, tLessonUnitList);
      verify(mockDatabaseHelper.getLessonUnitsByModuleId(tModuleId));
    });

    test(
      'should throw DatabaseException when database operation fails',
      () async {
        // arrange
        when(
          mockDatabaseHelper.getLessonUnitsByModuleId(tModuleId),
        ).thenThrow(Exception());
        // act
        final call = dataSource.getLessonUnits;
        // assert
        expect(
          () => call(tModuleId, ''),
          throwsA(isA<app_exceptions.DatabaseException>()),
        );
        verify(mockDatabaseHelper.getLessonUnitsByModuleId(tModuleId));
      },
    );
  });

  group('getUserLessonProgress', () {
    const tUserId = 'user_1';
    const tLessonId = 'lesson_1';
    final tUserLessonProgressModel = UserLessonProgressModel(
      userId: tUserId,
      lessonId: tLessonId,
      isCompleted: true,
      completedAt: DateTime.now(),
    );

    test('should return UserLessonProgressModel when data is found', () async {
      // arrange
      when(
        mockDatabaseHelper.getUserLessonProgress(tUserId, tLessonId),
      ).thenAnswer((_) async => tUserLessonProgressModel.toMap());
      // act
      final result = await dataSource.getUserLessonProgress(tUserId, tLessonId);
      // assert
      expect(result, tUserLessonProgressModel);
      verify(mockDatabaseHelper.getUserLessonProgress(tUserId, tLessonId));
    });

    test(
      'should return default uncompleted UserLessonProgressModel when data is not found',
      () async {
        // arrange
        when(
          mockDatabaseHelper.getUserLessonProgress(tUserId, tLessonId),
        ).thenAnswer((_) async => null);
        // act
        final result = await dataSource.getUserLessonProgress(
          tUserId,
          tLessonId,
        );
        // assert
        expect(result.isCompleted, false);
        expect(result.userId, tUserId);
        expect(result.lessonId, tLessonId);
        verify(mockDatabaseHelper.getUserLessonProgress(tUserId, tLessonId));
      },
    );

    test(
      'should throw DatabaseException when database operation fails',
      () async {
        // arrange
        when(
          mockDatabaseHelper.getUserLessonProgress(tUserId, tLessonId),
        ).thenThrow(Exception());
        // act
        final call = dataSource.getUserLessonProgress;
        // assert
        expect(
          () => call(tUserId, tLessonId),
          throwsA(isA<app_exceptions.DatabaseException>()),
        );
        verify(mockDatabaseHelper.getUserLessonProgress(tUserId, tLessonId));
      },
    );
  });

  group('markLessonAsCompleted', () {
    const tUserId = 'user_1';
    const tLessonId = 'lesson_1';

    test('should call insertUserLessonProgress on DatabaseHelper', () async {
      // arrange
      when(
        mockDatabaseHelper.insertUserLessonProgress(any),
      ).thenAnswer((_) async => 1);
      // act
      await dataSource.markLessonAsCompleted(tUserId, tLessonId);
      // assert
      verify(mockDatabaseHelper.insertUserLessonProgress(any));
    });

    test(
      'should throw DatabaseException when database operation fails',
      () async {
        // arrange
        when(
          mockDatabaseHelper.insertUserLessonProgress(any),
        ).thenThrow(Exception());
        // act
        final call = dataSource.markLessonAsCompleted;
        // assert
        expect(
          () => call(tUserId, tLessonId),
          throwsA(isA<app_exceptions.DatabaseException>()),
        );
        verify(mockDatabaseHelper.insertUserLessonProgress(any));
      },
    );
  });
}
