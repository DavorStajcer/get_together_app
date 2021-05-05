import 'package:equatable/equatable.dart';

class UserDataPublic extends Equatable {
  final String userId;
  final String username;
  final String imageUrl;

  UserDataPublic({
    required this.userId,
    required this.imageUrl,
    required this.username,
  });

  @override
  List<Object> get props => [userId, username, imageUrl];
}

class UserDataPrivate extends Equatable {
  final String email;
  final String password;

  UserDataPrivate({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}
