import '../../domain/entities/user_data.dart';

class UserDataModel extends UserData {
  UserDataModel(String email, String password) : super(email, password);

  factory UserDataModel.fromJsonMap(Map<String, dynamic> jsonMap) =>
      UserDataModel(jsonMap["email"], jsonMap["password"]);

  Map<String, dynamic> toJsonMap() => {
        "email": this.email,
        "password": this.password,
      };
}
