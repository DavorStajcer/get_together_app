import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get_together_app/core/widgets/user_star_rating.dart';

class UsernameAndRating extends StatelessWidget {
  final int rating;
  final int numberOfPeople;
  final String adminUsername;

  const UsernameAndRating({
    Key? key,
    required this.rating,
    required this.adminUsername,
    required this.numberOfPeople,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 50,
          height: 16,
          child: AutoSizeText(
            "$numberOfPeople people",
            style: TextStyle(color: Colors.grey),
          ),
        ),
        Container(
          width: double.infinity,
          alignment: Alignment.center,
          height: 30,
          child: FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(
              adminUsername,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
        ),
        UserStarRating(rating: 5),
      ],
    );
  }
}
