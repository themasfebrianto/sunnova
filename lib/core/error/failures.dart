import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String? message; // Add message property
  const Failure([this.message, this.properties = const <dynamic>[]]);

  final List<dynamic> properties;

  @override
  List<Object?> get props => [message, ...properties];
}

// General failures
class ServerFailure extends Failure {
  const ServerFailure([super.message]);
}

class CacheFailure extends Failure {
  const CacheFailure([super.message]);
}

class DatabaseFailure extends Failure {
  const DatabaseFailure([super.message]);
}

class NetworkFailure extends Failure {
  const NetworkFailure([super.message]);
}

class AuthenticationFailure extends Failure {
  const AuthenticationFailure([super.message]);
}
