import 'package:flutter/material.dart';

class Rating extends StatelessWidget {
  const Rating({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            fit: FlexFit.tight,
            flex: 1,
            child: Row(
              children: [
                Icon(
                  Icons.star,
                ),
                Icon(
                  Icons.star,
                ),
                Icon(
                  Icons.star,
                ),
                Icon(
                  Icons.star,
                ),
                Icon(
                  Icons.star,
                ),
              ],
            ),
          ),
          Flexible(fit: FlexFit.tight, flex: 1, child: Text("10 votes"))
        ],
      ),
    );
  }
}
