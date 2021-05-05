import 'package:equatable/equatable.dart';
import 'package:get_together_app/features/profile_overview/domain/entities/user_profile_data.dart';

abstract class UserProfileModel {
  Map<String, dynamic> toJsonMap();
}

class UserProfileDataModel extends UserProfileData implements UserProfileModel {
  UserProfileDataModel({
    required String username,
    required String city,
    required String country,
    required String description,
    required int friendsCount,
    required int rating,
    required int numberOfVotes,
  }) : super(
          username: username,
          city: city,
          country: country,
          description: description,
          friendsCount: friendsCount,
          rating: rating,
          numberOfVotes: numberOfVotes,
        );

  factory UserProfileDataModel.fromJsonMap(Map<String, dynamic> jsonMap) =>
      UserProfileDataModel(
        username: jsonMap["username"],
        city: jsonMap["city"],
        country: jsonMap["country"],
        description: jsonMap["description"],
        friendsCount: jsonMap["friendsCount"],
        rating: jsonMap["rating"],
        numberOfVotes: jsonMap["numberOfVotes"],
      );

  Map<String, dynamic> toJsonMap() => {
        "username": username,
        "city": city,
        "country": country,
        "description": description,
        "friendsCount": friendsCount,
        "rating": rating,
        "numberOfVotes": numberOfVotes,
      };
}
