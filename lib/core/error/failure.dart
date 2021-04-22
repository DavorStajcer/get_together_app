import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object> get props => [];
}

class ServerFailure extends Failure {}

class CashFailure extends Failure {}

class ParsingFailure extends Failure {}

class NetworkFailure extends Failure {}

class AuthenticationFailure extends Failure {
  final String message;
  AuthenticationFailure(this.message);
  @override
  List<Object> get props => [message];
}
