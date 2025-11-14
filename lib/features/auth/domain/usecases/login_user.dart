import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:sunnova_app/core/error/failures.dart';
import 'package:sunnova_app/core/usecases/usecase.dart';
import 'package:sunnova_app/features/auth/domain/entities/user_entity.dart';
import 'package:sunnova_app/features/auth/domain/repositories/user_repository.dart';

class LoginUser extends UseCase<UserEntity, LoginUserParams> {
  final UserRepository repository;

  LoginUser(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(LoginUserParams params) async {
    return await repository.loginUser(params.email, params.password);
  }
}

class LoginUserParams extends Equatable {
  final String email;
  final String password;

  const LoginUserParams({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}
