import 'package:flutter/material.dart';
import 'package:get_together_app/core/widgets/user_star_rating.dart';
import 'package:get_together_app/features/profile_overview/presentation/widgets/rating.dart';

class FriendsAndRating extends StatelessWidget {
  const FriendsAndRating({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("10"),
              Text("Friends"),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: VerticalDivider(),
          ),
          UserStarRating(),
        ],
      ),
    );
  }
}
