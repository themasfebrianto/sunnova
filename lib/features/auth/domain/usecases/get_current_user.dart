import 'package:dartz/dartz.dart';
import 'package:sunnova_app/core/error/failures.dart';
import 'package:sunnova_app/core/usecases/usecase.dart';
import 'package:sunnova_app/features/auth/domain/entities/user_profile_entity.dart';
import 'package:sunnova_app/features/auth/domain/repositories/auth_repository.dart';

class GetCurrentUser implements UseCase<UserProfileEntity, NoParams> {
  final AuthRepository repository;

  GetCurrentUser(this.repository);

  @override
  Future<Either<Failure, UserProfileEntity>> call(NoParams params) async {
    return await repository.getCurrentUser();
  }
}
