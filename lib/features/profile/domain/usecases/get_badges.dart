import 'package:dartz/dartz.dart';
import 'package:sunnova_app/core/error/failures.dart';
import 'package:sunnova_app/core/usecases/usecase.dart';
import 'package:sunnova_app/features/profile/domain/entities/badge_entity.dart';
import 'package:sunnova_app/features/profile/domain/repositories/profile_repository.dart';

class GetBadges extends UseCase<List<BadgeEntity>, NoParams> {
  final ProfileRepository repository;

  GetBadges(this.repository);

  @override
  Future<Either<Failure, List<BadgeEntity>>> call(NoParams params) async {
    return await repository.getBadges();
  }
}
