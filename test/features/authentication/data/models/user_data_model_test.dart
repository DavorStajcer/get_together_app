//@dart=2.6

import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:get_together_app/features/authentication/data/models/user_data_model.dart';
import 'package:get_together_app/features/authentication/domain/entities/user_data.dart';

import '../../../../fixtures/fixture_string_converter.dart';

void main() {
  UserDataModel tUserData;

  setUp(() {
    tUserData = UserDataModel("testEmail", "testPassword");
  });

  test("should be an instance of UserData", () {
    expect(tUserData, isInstanceOf<UserData>());
  });

  test("should convert itself to a json Map", () {
    final map = tUserData.toJsonMap();
    final expected = json.decode(getStringJsonFromFixture(
        "user_data_fixture.json")); //when you do json.encode(map) and when you compare it with the getStringJsonFromFixture() it is not completly eaqual bcs of some string stuff, but it looks good
    expect(map, expected);
  });

  test("should make new instance from json map", () {
    final jsonMap =
        json.decode(getStringJsonFromFixture("user_data_fixture.json"));
    final instance = UserDataModel.fromJsonMap(jsonMap);
    expect(instance, tUserData);
  });
}
