part of 'auth_mode_cubit.dart';

abstract class AuthModeState extends Equatable {
  final AuthModeColors authModeColors;
  const AuthModeState(this.authModeColors);

  @override
  List<Object> get props => [authModeColors];
}

class AuthModeLogIn extends AuthModeState {
  AuthModeLogIn() : super(LogInColors());
}

class AuthModeSignUp extends AuthModeState {
  AuthModeSignUp() : super(SignUpColors());
}

abstract class AuthModeColors extends Equatable {
  final Color logIn;
  final Color singUp;
  AuthModeColors({this.logIn, this.singUp});

  @override
  List<Object> get props => [logIn, singUp];
}

class LogInColors extends AuthModeColors {
  LogInColors()
      : super(
            logIn: Color.fromRGBO(158, 158, 158, 1),
            singUp: Colors.transparent);
}

class SignUpColors extends AuthModeColors {
  SignUpColors() : super(logIn: Colors.transparent, singUp: Colors.grey);
}
