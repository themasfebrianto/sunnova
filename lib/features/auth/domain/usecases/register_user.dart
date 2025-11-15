import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:sunnova_app/core/error/failures.dart';
import 'package:sunnova_app/core/usecases/usecase.dart';
import 'package:sunnova_app/features/auth/domain/entities/user_entity.dart';
import 'package:sunnova_app/features/auth/domain/repositories/user_repository.dart';

class RegisterUser extends UseCase<UserEntity, RegisterUserParams> {
  final UserRepository repository;

  RegisterUser(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(RegisterUserParams params) async {
    return await repository.registerUser(
        params.name, params.email, params.password, params.gender);
  }
}

class RegisterUserParams extends Equatable {
  final String name;
  final String email;
  final String password;
  final String gender;

  const RegisterUserParams({
    required this.name,
    required this.email,
    required this.password,
    required this.gender,
  });

  @override
  List<Object?> get props => [name, email, password, gender];
}