import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sunnova_app/core/error/exceptions.dart';
import 'package:sunnova_app/core/error/failures.dart';
import 'package:sunnova_app/features/home/data/datasources/home_local_data_source.dart';
import 'package:sunnova_app/features/home/data/models/course_module_model.dart';
import 'package:sunnova_app/features/home/data/models/user_game_stats_model.dart';
import 'package:sunnova_app/features/home/data/repositories/home_repository_impl.dart';
import 'package:sunnova_app/features/home/domain/entities/course_module_entity.dart';
import 'package:sunnova_app/features/home/domain/entities/user_game_stats_entity.dart';

import 'home_repository_impl_test.mocks.dart';

@GenerateMocks([HomeLocalDataSource])
void main() {
  late HomeRepositoryImpl repository;
  late MockHomeLocalDataSource mockHomeLocalDataSource;

  setUp(() {
    mockHomeLocalDataSource = MockHomeLocalDataSource();
    repository = HomeRepositoryImpl(
      localDataSource: mockHomeLocalDataSource,
    );
  });

  group('getUserGameStats', () {
    const tUserId = 'user_1';
    final tUserGameStatsModel = UserGameStatsModel(
      xp: 100,
      level: 1,
      currentStreak: 5,
      longestStreak: 10,
      lessonsCompleted: 2,
      quizzesPassed: 1,
    );
    final UserGameStatsEntity tUserGameStatsEntity = tUserGameStatsModel;

    test(
      'should return user game stats entity when the call to local data source is successful',
      () async {
        // arrange
        when(mockHomeLocalDataSource.getUserGameStats(tUserId))
            .thenAnswer((_) async => tUserGameStatsModel);
        // act
        final result = await repository.getUserGameStats(tUserId);
        // assert
        expect(result, Right(tUserGameStatsEntity));
        verify(mockHomeLocalDataSource.getUserGameStats(tUserId));
      },
    );

    test(
      'should return DatabaseFailure when the call to local data source is unsuccessful',
      () async {
        // arrange
        when(mockHomeLocalDataSource.getUserGameStats(tUserId))
            .thenThrow(const DatabaseException('Test Exception'));
        // act
        final result = await repository.getUserGameStats(tUserId);
        // assert
        expect(result, Left(DatabaseFailure('Test Exception')));
        verify(mockHomeLocalDataSource.getUserGameStats(tUserId));
      },
    );
  });

  group('getCourseModules', () {
    final tCourseModuleModel = CourseModuleModel(
      id: 'mod1',
      title: 'Test Module',
      description: 'Test Description',
      imageUrl: 'test.png',
      requiredXpToUnlock: 0,
      isLocked: false,
      totalLessons: 5,
      completedLessons: 0,
    );
    final List<CourseModuleModel> tCourseModuleList = [tCourseModuleModel];
    final List<CourseModuleEntity> tCourseModuleEntityList = [tCourseModuleModel];

    test(
      'should return list of course module entities when the call to local data source is successful',
      () async {
        // arrange
        when(mockHomeLocalDataSource.getCourseModules())
            .thenAnswer((_) async => tCourseModuleList);
        // act
        final result = await repository.getCourseModules();
        // assert
        expect(result.isRight(), true);
        result.fold((failure) => fail('Expected Right, got Left'),
            (list) => expect(list, tCourseModuleEntityList));
        verify(mockHomeLocalDataSource.getCourseModules());
      },
    );

    test(
      'should return DatabaseFailure when the call to local data source is unsuccessful',
      () async {
        // arrange
        when(mockHomeLocalDataSource.getCourseModules())
            .thenThrow(const DatabaseException('Test Exception'));
        // act
        final result = await repository.getCourseModules();
        // assert
        expect(result, Left(DatabaseFailure('Test Exception')));
        verify(mockHomeLocalDataSource.getCourseModules());
      },
    );
  });
}
