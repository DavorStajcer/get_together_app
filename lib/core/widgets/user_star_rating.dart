import 'package:flutter/material.dart';

class UserStarRating extends StatelessWidget {
  const UserStarRating({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _starColor = Theme.of(context).primaryColor;
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Container(
        child: Row(
          children: [
            Icon(
              Icons.star,
              color: _starColor,
            ),
            Icon(
              Icons.star,
              color: _starColor,
            ),
            Icon(
              Icons.star,
              color: _starColor,
            ),
            Icon(
              Icons.star,
              color: _starColor,
            ),
            Icon(
              Icons.star,
              color: _starColor,
            ),
            Text(
              "(20)",
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
