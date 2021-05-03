import 'package:flutter/material.dart';
import 'package:get_together_app/features/profile_overview/presentation/widgets/edit_and_settings.dart';
import 'package:get_together_app/features/profile_overview/presentation/widgets/friends_and_rating.dart';
import 'package:get_together_app/features/profile_overview/presentation/util/profile_card_clipper.dart';
import 'package:get_together_app/features/profile_overview/presentation/widgets/profile_picture.dart';

class ProfileCard extends StatelessWidget {
  final double picHeight;
  const ProfileCard({
    Key? key,
    required this.picHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        ClipPath(
          clipper: ProfileCardClipper(picHeight: picHeight),
          child: Card(
            child: Column(
              children: [
                EditAndSettings(picHeight: picHeight),
                Container(
                  width: double.infinity,
                  height: 20,
                  alignment: Alignment.center,
                  child: Text(
                    "Davor Štajcer",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 15,
                  alignment: Alignment.center,
                  child: FittedBox(
                    fit: BoxFit.fitHeight,
                    child: Text(
                      "Konya, Turkey",
                    ),
                  ),
                ),
                Divider(),
                Expanded(
                  child: Column(
                    children: [
                      Flexible(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: SingleChildScrollView(
                            child: Text(
                                "me long text. Some me long text. Some me long text. Some me long text. Some me long text. Some me long text. Some me long text. Some me long text. Some me long text. Some me long text. Some me long text. Some me long text. Some me long text. Some me long text. Some me long text. Some me long text. Some me long text. Some  Some long text. Some long text. Some long text. Some long text. Some long text. Some long text. Some long text. Some long text. Some long text. "),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: FriendsAndRating(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        ProfilePicture(picHeight: picHeight),
      ],
    );
  }
}
