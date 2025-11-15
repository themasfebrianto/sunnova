import 'package:dartz/dartz.dart';
import 'package:sunnova_app/core/error/exceptions.dart';
import 'package:sunnova_app/core/error/failures.dart';
import 'package:sunnova_app/features/home/data/datasources/home_local_data_source.dart';
import 'package:sunnova_app/features/home/domain/entities/course_module_entity.dart';
import 'package:sunnova_app/features/home/domain/entities/user_game_stats_entity.dart';
import 'package:sunnova_app/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeLocalDataSource localDataSource;

  HomeRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, UserGameStatsEntity>> getUserGameStats(String userId) async {
    try {
      final userGameStatsModel = await localDataSource.getUserGameStats(userId);
      return Right(userGameStatsModel);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<CourseModuleEntity>>> getCourseModules() async {
    try {
      final courseModuleModels = await localDataSource.getCourseModules();
      return Right(courseModuleModels);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }
}
