import 'dart:io';

import 'package:equatable/equatable.dart';

abstract class Parameters extends Equatable {}

class AuthenticationParameters extends Equatable {
  final String email;
  final String password;

  AuthenticationParameters(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

class NoParameters extends Equatable {
  @override
  List<Object> get props => [];
}

class LogInParameters extends AuthenticationParameters {
  LogInParameters({String email, String password}) : super(email, password);
}

class SignUpParameters extends AuthenticationParameters {
  final File image;
  final String username;

  SignUpParameters({File image, String username, String email, String password})
      : this.image = image,
        this.username = username,
        super(email, password);

  @override
  List<Object> get props => [email, password, image, username];
}
