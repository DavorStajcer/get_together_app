import '../../domain/entities/user_data.dart';

abstract class UserDataModel {
  Map<String, dynamic> toJsonMap();
}

class UserModelPublic extends UserDataPublic implements UserDataModel {
  UserModelPublic({
    required String userId,
    required String username,
    required String imageUrl,
  }) : super(
          imageUrl: imageUrl,
          userId: userId,
          username: username,
        );

  factory UserModelPublic.fromJsonMap(Map<String, dynamic> jsonMap) =>
      UserModelPublic(
        userId: jsonMap["userId"],
        username: jsonMap["username"],
        imageUrl: jsonMap["imageUrl"],
      );

  Map<String, dynamic> toJsonMap() => {
        "userId": this.userId,
        "username": this.username,
        "imageUrl": this.imageUrl,
      };
}

class UserModelPrivate extends UserDataPrivate implements UserDataModel {
  UserModelPrivate({
    required String email,
    required String password,
  }) : super(
          email: email,
          password: password,
        );

  factory UserModelPrivate.fromJsonMap(Map<String, dynamic> jsonMap) =>
      UserModelPrivate(
        email: jsonMap["email"],
        password: jsonMap["password"],
      );

  Map<String, dynamic> toJsonMap() => {
        "email": this.email,
        "password": this.password,
      };
}
