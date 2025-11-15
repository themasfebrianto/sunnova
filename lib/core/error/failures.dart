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
  ServerFailure([String? message]) : super(message);
}

class CacheFailure extends Failure {
  CacheFailure([String? message]) : super(message);
}

class DatabaseFailure extends Failure {
  DatabaseFailure([String? message]) : super(message);
}

class NetworkFailure extends Failure {
  NetworkFailure([String? message]) : super(message);
}
