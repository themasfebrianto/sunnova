import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sunnova_app/core/error/failures.dart';
import 'package:sunnova_app/core/usecases/usecase.dart';
import 'package:sunnova_app/features/home/domain/entities/course_module_entity.dart';
import 'package:sunnova_app/features/home/domain/entities/user_game_stats_entity.dart';
import 'package:sunnova_app/features/home/domain/usecases/get_course_modules.dart';
import 'package:sunnova_app/features/home/domain/usecases/get_user_game_stats.dart';
import 'package:sunnova_app/features/home/presentation/notifiers/home_notifier.dart';

import 'home_notifier_test.mocks.dart';

@GenerateMocks([GetUserGameStats, GetCourseModules])
void main() {
  late HomeNotifier homeNotifier;
  late MockGetUserGameStats mockGetUserGameStats;
  late MockGetCourseModules mockGetCourseModules;

  setUp(() {
    mockGetUserGameStats = MockGetUserGameStats();
    mockGetCourseModules = MockGetCourseModules();
    homeNotifier = HomeNotifier(
      getUserGameStats: mockGetUserGameStats,
      getCourseModules: mockGetCourseModules,
    );
  });

  final tUserGameStats = UserGameStatsEntity(
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
  final tCourseModuleList = [tCourseModule];

  group('fetchUserStats', () {
    const tUserId = 'user_1';

    test(
      'should set state to loading and then loaded with user stats on successful fetch',
      () async {
        // arrange
        when(mockGetUserGameStats(any))
            .thenAnswer((_) async => Right(tUserGameStats));
        // act
        await homeNotifier.fetchUserStats(tUserId);
        // assert
        expect(homeNotifier.state.isLoading, false);
        expect(homeNotifier.state.userStats, tUserGameStats);
        expect(homeNotifier.state.errorMessage, null);
        verify(mockGetUserGameStats(GetUserGameStatsParams(userId: tUserId)));
        verifyNoMoreInteractions(mockGetUserGameStats);
      },
    );

    test(
      'should set state to loading and then error on failed fetch',
      () async {
        // arrange
        when(mockGetUserGameStats(any))
            .thenAnswer((_) async => Left(DatabaseFailure('Error')));
        // act
        await homeNotifier.fetchUserStats(tUserId);
        // assert
        expect(homeNotifier.state.isLoading, false);
        expect(homeNotifier.state.userStats, null);
        expect(homeNotifier.state.errorMessage, 'Error');
        verify(mockGetUserGameStats(GetUserGameStatsParams(userId: tUserId)));
        verifyNoMoreInteractions(mockGetUserGameStats);
      },
    );
  });

  group('fetchCourseModules', () {
    test(
      'should set state to loading and then loaded with course modules on successful fetch',
      () async {
        // arrange
        when(mockGetCourseModules(any))
            .thenAnswer((_) async => Right(tCourseModuleList));
        // act
        await homeNotifier.fetchCourseModules();
        // assert
        expect(homeNotifier.state.isLoading, false);
        expect(homeNotifier.state.modules, tCourseModuleList);
        expect(homeNotifier.state.errorMessage, null);
        verify(mockGetCourseModules(NoParams()));
        verifyNoMoreInteractions(mockGetCourseModules);
      },
    );

    test(
      'should set state to loading and then error on failed fetch',
      () async {
        // arrange
        when(mockGetCourseModules(any))
            .thenAnswer((_) async => Left(DatabaseFailure('Error')));
        // act
        await homeNotifier.fetchCourseModules();
        // assert
        expect(homeNotifier.state.isLoading, false);
        expect(homeNotifier.state.modules, []);
        expect(homeNotifier.state.errorMessage, 'Error');
        verify(mockGetCourseModules(NoParams()));
        verifyNoMoreInteractions(mockGetCourseModules);
      },
    );
  });
}
