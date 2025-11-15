import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:sunnova_app/core/error/failures.dart';
import 'package:sunnova_app/core/usecases/usecase.dart';
import 'package:sunnova_app/features/auth/domain/entities/user_profile_entity.dart';
import 'package:sunnova_app/features/auth/domain/repositories/auth_repository.dart';

class LoginUser implements UseCase<UserProfileEntity, LoginParams> {
  final AuthRepository repository;

  LoginUser(this.repository);

  @override
  Future<Either<Failure, UserProfileEntity>> call(LoginParams params) async {
    return await repository.loginUser(params.email, params.password);
  }
}

class LoginParams extends Equatable {
  final String email;
  final String password;

  const LoginParams({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}
