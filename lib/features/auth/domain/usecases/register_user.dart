import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:sunnova_app/core/error/failures.dart';
import 'package:sunnova_app/core/usecases/usecase.dart';
import 'package:sunnova_app/features/auth/domain/entities/user_profile_entity.dart';
import 'package:sunnova_app/features/auth/domain/repositories/auth_repository.dart';

class RegisterUser implements UseCase<UserProfileEntity, RegisterParams> {
  final AuthRepository repository;

  RegisterUser(this.repository);

  @override
  Future<Either<Failure, UserProfileEntity>> call(RegisterParams params) async {
    return await repository.registerUser(params.email, params.password, params.displayName, params.gender);
  }
}

class RegisterParams extends Equatable {
  final String email;
  final String password;
  final String displayName;
  final String gender;

  const RegisterParams({
    required this.email,
    required this.password,
    required this.displayName,
    required this.gender,
  });

  @override
  List<Object?> get props => [email, password, displayName, gender];
}
