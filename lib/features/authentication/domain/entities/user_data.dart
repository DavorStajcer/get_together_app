import 'package:equatable/equatable.dart';

class UserData extends Equatable {
  final String email;
  final String password;

  UserData(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}
