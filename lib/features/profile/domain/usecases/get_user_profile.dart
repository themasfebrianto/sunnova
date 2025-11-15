import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:sunnova_app/core/error/failures.dart';
import 'package:sunnova_app/core/usecases/usecase.dart';
import 'package:sunnova_app/features/auth/domain/entities/user_profile_entity.dart';
import 'package:sunnova_app/features/profile/domain/repositories/profile_repository.dart';

class GetUserProfile extends UseCase<UserProfileEntity, GetUserProfileParams> {
  final ProfileRepository repository;

  GetUserProfile(this.repository);

  @override
  Future<Either<Failure, UserProfileEntity>> call(GetUserProfileParams params) async {
    return await repository.getUserProfile(params.id);
  }
}

class GetUserProfileParams extends Equatable {
  final String id;

  const GetUserProfileParams({required this.id});

  @override
  List<Object?> get props => [id];
}