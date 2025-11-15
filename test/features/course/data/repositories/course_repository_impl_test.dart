import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sunnova_app/core/error/exceptions.dart';
import 'package:sunnova_app/core/error/failures.dart';
import 'package:sunnova_app/features/course/data/datasources/course_local_data_source.dart';
import 'package:sunnova_app/features/home/data/models/course_module_model.dart';
import 'package:sunnova_app/features/course/data/models/lesson_unit_model.dart';
import 'package:sunnova_app/features/course/data/models/user_lesson_progress_model.dart';
import 'package:sunnova_app/features/course/data/repositories/course_repository_impl.dart';
import 'package:sunnova_app/features/home/domain/entities/course_module_entity.dart';
import 'package:sunnova_app/features/course/domain/entities/lesson_unit_entity.dart';
import 'package:sunnova_app/features/course/domain/entities/user_lesson_progress_entity.dart';

import 'course_repository_impl_test.mocks.dart';

@GenerateMocks([CourseLocalDataSource])
void main() {
  late CourseRepositoryImpl repository;
  late MockCourseLocalDataSource mockCourseLocalDataSource;

  setUp(() {
    mockCourseLocalDataSource = MockCourseLocalDataSource();
    repository = CourseRepositoryImpl(
      localDataSource: mockCourseLocalDataSource,
    );
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
    final CourseModuleEntity tCourseModuleEntity = tCourseModuleModel;

    test(
      'should return course module entity when the call to local data source is successful',
      () async {
        // arrange
        when(
          mockCourseLocalDataSource.getCourseDetail(tModuleId),
        ).thenAnswer((_) async => tCourseModuleModel);
        // act
        final result = await repository.getCourseDetail(tModuleId);
        // assert
        expect(result, Right(tCourseModuleEntity));
        verify(mockCourseLocalDataSource.getCourseDetail(tModuleId));
      },
    );

    test(
      'should return DatabaseFailure when the call to local data source is unsuccessful',
      () async {
        // arrange
        when(
          mockCourseLocalDataSource.getCourseDetail(tModuleId),
        ).thenThrow(const DatabaseException('Test Exception'));
        // act
        final result = await repository.getCourseDetail(tModuleId);
        // assert
        expect(result, Left(DatabaseFailure('Test Exception')));
        verify(mockCourseLocalDataSource.getCourseDetail(tModuleId));
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
    final List<LessonUnitModel> tLessonUnitList = [tLessonUnitModel];
    final List<LessonUnitEntity> tLessonUnitEntityList = [tLessonUnitModel];

    test(
      'should return list of lesson unit entities when the call to local data source is successful',
      () async {
        // arrange
        when(
          mockCourseLocalDataSource.getLessonUnits(tModuleId, ''),
        ).thenAnswer((_) async => tLessonUnitList);
        // act
        final result = await repository.getLessonUnits(tModuleId, '');
        // assert
        expect(result.isRight(), true);
        result.fold(
          (failure) => fail('Expected Right, got Left'),
          (list) => expect(list, tLessonUnitEntityList),
        );
        verify(mockCourseLocalDataSource.getLessonUnits(tModuleId, ''));
      },
    );

    test(
      'should return DatabaseFailure when the call to local data source is unsuccessful',
      () async {
        // arrange
        when(
          mockCourseLocalDataSource.getLessonUnits(tModuleId, ''),
        ).thenThrow(const DatabaseException('Test Exception'));
        // act
        final result = await repository.getLessonUnits(tModuleId, '');
        // assert
        expect(result, Left(DatabaseFailure('Test Exception')));
        verify(mockCourseLocalDataSource.getLessonUnits(tModuleId, ''));
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
    final UserLessonProgressEntity tUserLessonProgressEntity =
        tUserLessonProgressModel;

    test(
      'should return user lesson progress entity when the call to local data source is successful',
      () async {
        // arrange
        when(
          mockCourseLocalDataSource.getUserLessonProgress(tUserId, tLessonId),
        ).thenAnswer((_) async => tUserLessonProgressModel);
        // act
        final result = await repository.getUserLessonProgress(
          tUserId,
          tLessonId,
        );
        // assert
        expect(result, Right(tUserLessonProgressEntity));
        verify(
          mockCourseLocalDataSource.getUserLessonProgress(tUserId, tLessonId),
        );
      },
    );

    test(
      'should return DatabaseFailure when the call to local data source is unsuccessful',
      () async {
        // arrange
        when(
          mockCourseLocalDataSource.getUserLessonProgress(tUserId, tLessonId),
        ).thenThrow(const DatabaseException('Test Exception'));
        // act
        final result = await repository.getUserLessonProgress(
          tUserId,
          tLessonId,
        );
        // assert
        expect(result, Left(DatabaseFailure('Test Exception')));
        verify(
          mockCourseLocalDataSource.getUserLessonProgress(tUserId, tLessonId),
        );
      },
    );
  });

  group('markLessonAsCompleted', () {
    const tUserId = 'user_1';
    const tLessonId = 'lesson_1';

    test(
      'should return void when the call to local data source is successful',
      () async {
        // arrange
        when(
          mockCourseLocalDataSource.markLessonAsCompleted(tUserId, tLessonId),
        ).thenAnswer((_) async => Future.value());
        // act
        final result = await repository.markLessonAsCompleted(
          tUserId,
          tLessonId,
        );
        // assert
        expect(result, const Right(null));
        verify(
          mockCourseLocalDataSource.markLessonAsCompleted(tUserId, tLessonId),
        );
      },
    );

    test(
      'should return DatabaseFailure when the call to local data source is unsuccessful',
      () async {
        // arrange
        when(
          mockCourseLocalDataSource.markLessonAsCompleted(tUserId, tLessonId),
        ).thenThrow(const DatabaseException('Test Exception'));
        // act
        final result = await repository.markLessonAsCompleted(
          tUserId,
          tLessonId,
        );
        // assert
        expect(result, Left(DatabaseFailure('Test Exception')));
        verify(
          mockCourseLocalDataSource.markLessonAsCompleted(tUserId, tLessonId),
        );
      },
    );
  });
}
