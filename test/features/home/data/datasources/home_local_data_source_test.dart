import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sunnova_app/core/db/database_helper.dart';
import 'package:sunnova_app/core/error/exceptions.dart' as app_exceptions; // Alias our custom exception
import 'package:sunnova_app/features/home/data/datasources/home_local_data_source.dart';
import 'package:sunnova_app/features/home/data/models/course_module_model.dart';
import 'package:sunnova_app/features/home/data/models/user_game_stats_model.dart';

import 'home_local_data_source_test.mocks.dart';

@GenerateMocks([DatabaseHelper])
void main() {
  late HomeLocalDataSourceImpl dataSource;
  late MockDatabaseHelper mockDatabaseHelper;

  setUp(() {
    sqfliteFfiInit();
    mockDatabaseHelper = MockDatabaseHelper();
    dataSource = HomeLocalDataSourceImpl(databaseHelper: mockDatabaseHelper);
  });

  const tUserId = 'user_1'; // Moved tUserId here

  group('getUserGameStats', () {
    final tUserGameStatsModel = UserGameStatsModel(
      userName: 'Test User',
      xp: 100,
      level: 1,
      currentXp: 100,
      xpToNextLevel: 200,
      currentStreak: 5,
      longestStreak: 10,
      lessonsCompleted: 2,
      quizzesPassed: 1,
      totalXp: 100,
    );

    test(
      'should return UserGameStatsModel when data is found',
      () async {
        // arrange
        when(mockDatabaseHelper.getUserGameStats(tUserId))
            .thenAnswer((_) async => tUserGameStatsModel.toMap());
        // act
        final result = await dataSource.getUserGameStats(tUserId);
        // assert
        expect(result, tUserGameStatsModel);
        verify(mockDatabaseHelper.getUserGameStats(tUserId));
      },
    );

    test(
      'should throw DatabaseException when data is not found',
      () async {
        // arrange
        when(mockDatabaseHelper.getUserGameStats(tUserId))
            .thenAnswer((_) async => null);
        // act
        final call = dataSource.getUserGameStats;
        // assert
        expect(
          () => call(tUserId),
          throwsA(isA<app_exceptions.DatabaseException>()),
        );
        verify(mockDatabaseHelper.getUserGameStats(tUserId));
      },
    );

    test(
      'should throw DatabaseException when database operation fails',
      () async {
        // arrange
        when(mockDatabaseHelper.getUserGameStats(tUserId))
            .thenThrow(Exception());
        // act
        final call = dataSource.getUserGameStats;
        // assert
        expect(
          () => call(tUserId),
          throwsA(isA<app_exceptions.DatabaseException>()),
        );
        verify(mockDatabaseHelper.getUserGameStats(tUserId));
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

    test(
      'should return List<CourseModuleModel> when data is found',
      () async {
        // arrange
        when(mockDatabaseHelper.getAllCourseModules())
            .thenAnswer((_) async => [tCourseModuleModel.toMap()]);
        // act
        final result = await dataSource.getCourseModules();
        // assert
        expect(result, [tCourseModuleModel]);
        verify(mockDatabaseHelper.getAllCourseModules());
      },
    );

    test(
      'should throw DatabaseException when database operation fails',
      () async {
        // arrange
        when(mockDatabaseHelper.getAllCourseModules()).thenThrow(Exception());
        // act
        final call = dataSource.getCourseModules;
        // assert
        expect(
          () => call(),
          throwsA(isA<app_exceptions.DatabaseException>()),
        );
        verify(mockDatabaseHelper.getAllCourseModules());
      },
    );
  });

  group('saveUserGameStats', () {
    final tUserGameStatsModel = UserGameStatsModel(
      userName: 'Test User',
      xp: 100,
      level: 1,
      currentXp: 100,
      xpToNextLevel: 200,
      currentStreak: 5,
      longestStreak: 10,
      lessonsCompleted: 2,
      quizzesPassed: 1,
      totalXp: 100,
    );

    test(
      'should call insertUserGameStats on DatabaseHelper',
      () async {
        // arrange
        when(mockDatabaseHelper.insertUserGameStats(any))
            .thenAnswer((_) async => 1);
        // act
        await dataSource.saveUserGameStats(tUserGameStatsModel);
        // assert
        verify(mockDatabaseHelper.insertUserGameStats(tUserGameStatsModel.toMap()));
      },
    );

    test(
      'should throw DatabaseException when database operation fails',
      () async {
        // arrange
        when(mockDatabaseHelper.insertUserGameStats(any))
            .thenThrow(Exception());
        // act
        final call = dataSource.saveUserGameStats;
        // assert
        expect(
          () => call(tUserGameStatsModel),
          throwsA(isA<app_exceptions.DatabaseException>()),
        );
        verify(mockDatabaseHelper.insertUserGameStats(tUserGameStatsModel.toMap()));
      },
    );
  });

  group('saveCourseModules', () {
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
    final tCourseModuleList = [tCourseModuleModel];

    test(
      'should call insertCourseModule for each module on DatabaseHelper',
      () async {
        // arrange
        when(mockDatabaseHelper.insertCourseModule(any))
            .thenAnswer((_) async => 1);
        // act
        await dataSource.saveCourseModules(tCourseModuleList);
        // assert
        verify(mockDatabaseHelper.insertCourseModule(tCourseModuleModel.toMap()));
        verifyNoMoreInteractions(mockDatabaseHelper);
      },
    );

    test(
      'should throw DatabaseException when database operation fails',
      () async {
        // arrange
        when(mockDatabaseHelper.insertCourseModule(any))
            .thenThrow(Exception());
        // act
        final call = dataSource.saveCourseModules;
        // assert
        expect(
          () => call(tCourseModuleList),
          throwsA(isA<app_exceptions.DatabaseException>()),
        );
        verify(mockDatabaseHelper.insertCourseModule(tCourseModuleModel.toMap()));
        verifyNoMoreInteractions(mockDatabaseHelper);
      },
    );
  });
}
