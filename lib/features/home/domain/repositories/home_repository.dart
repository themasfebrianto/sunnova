import 'package:dartz/dartz.dart';
import 'package:sunnova_app/core/error/failures.dart';
import 'package:sunnova_app/features/home/domain/entities/user_game_stats_entity.dart';
import 'package:sunnova_app/features/home/domain/entities/course_module_entity.dart';

abstract class HomeRepository {
  Future<Either<Failure, UserGameStatsEntity>> getUserGameStats(String userId);
  Future<Either<Failure, List<CourseModuleEntity>>> getCourseModules();
}
