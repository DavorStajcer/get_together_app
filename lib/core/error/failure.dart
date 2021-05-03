import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  Failure(this.message);
  @override
  List<Object> get props => [];
}

class ServerFailure extends Failure {
  ServerFailure(String message) : super(message);
}

class CashFailure extends Failure {
  CashFailure(String message) : super(message);
}

class ParsingFailure extends Failure {
  ParsingFailure(String message) : super(message);
}

class LocationFailure extends Failure {
  LocationFailure(String message) : super(message);
}

class NetworkFailure extends Failure {
  NetworkFailure(String message) : super(message);
}

class AuthenticationFailure extends Failure {
  AuthenticationFailure(String message) : super(message);
}
