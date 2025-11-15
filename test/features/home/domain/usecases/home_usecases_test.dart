import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sunnova_app/core/error/failures.dart';
import 'package:sunnova_app/core/usecases/usecase.dart';
import 'package:sunnova_app/features/home/domain/entities/course_module_entity.dart';
import 'package:sunnova_app/features/home/domain/entities/user_game_stats_entity.dart';
import 'package:sunnova_app/features/home/domain/repositories/home_repository.dart';
import 'package:sunnova_app/features/home/domain/usecases/get_course_modules.dart';
import 'package:sunnova_app/features/home/domain/usecases/get_user_game_stats.dart';

import 'home_usecases_test.mocks.dart';

@GenerateMocks([HomeRepository])
void main() {
  late GetUserGameStats getUserGameStats;
  late GetCourseModules getCourseModules;
  late MockHomeRepository mockHomeRepository;

  setUp(() {
    mockHomeRepository = MockHomeRepository();
    getUserGameStats = GetUserGameStats(mockHomeRepository);
    getCourseModules = GetCourseModules(mockHomeRepository);
  });

  final tUserGameStats = UserGameStatsEntity(
    xp: 100,
    level: 1,
    currentStreak: 5,
    longestStreak: 10,
    lessonsCompleted: 2,
    quizzesPassed: 1,
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

  group('GetUserGameStats', () {
    const tUserId = 'user_1';

    test(
      'should get user game stats from the repository',
      () async {
        // arrange
        when(mockHomeRepository.getUserGameStats(tUserId))
            .thenAnswer((_) async => Right(tUserGameStats));
        // act
        final result = await getUserGameStats(GetUserGameStatsParams(userId: tUserId));
        // assert
        expect(result, Right(tUserGameStats));
        verify(mockHomeRepository.getUserGameStats(tUserId));
        verifyNoMoreInteractions(mockHomeRepository);
      },
    );

    test(
      'should return failure when getting user game stats is unsuccessful',
      () async {
        // arrange
        when(mockHomeRepository.getUserGameStats(tUserId))
            .thenAnswer((_) async => Left(DatabaseFailure('Error')));
        // act
        final result = await getUserGameStats(GetUserGameStatsParams(userId: tUserId));
        // assert
        expect(result, Left(DatabaseFailure('Error')));
        verify(mockHomeRepository.getUserGameStats(tUserId));
        verifyNoMoreInteractions(mockHomeRepository);
      },
    );
  });

  group('GetCourseModules', () {
    test(
      'should get course modules from the repository',
      () async {
        // arrange
        when(mockHomeRepository.getCourseModules())
            .thenAnswer((_) async => Right(tCourseModuleList));
        // act
        final result = await getCourseModules(NoParams());
        // assert
        expect(result, Right(tCourseModuleList));
        verify(mockHomeRepository.getCourseModules());
        verifyNoMoreInteractions(mockHomeRepository);
      },
    );

    test(
      'should return failure when getting course modules is unsuccessful',
      () async {
        // arrange
        when(mockHomeRepository.getCourseModules())
            .thenAnswer((_) async => Left(DatabaseFailure('Error')));
        // act
        final result = await getCourseModules(NoParams());
        // assert
        expect(result, Left(DatabaseFailure('Error')));
        verify(mockHomeRepository.getCourseModules());
        verifyNoMoreInteractions(mockHomeRepository);
      },
    );
  });
}
