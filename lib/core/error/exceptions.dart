import 'package:equatable/equatable.dart';

abstract class Exception extends Equatable {
  @override
  List<Object> get props => [];
}

class ServerException extends Exception {}

class CashException extends Exception {}

class ParsingException extends Exception {}

class NetworkException extends Exception {}

class AuthenticationException extends Exception {
  final String code;
  AuthenticationException(this.code);

  @override
  List<Object> get props => [];
}
