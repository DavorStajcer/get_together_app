import 'package:flutter/material.dart';

class AdminPicture extends StatelessWidget {
  const AdminPicture({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage("lib/assets/images/custom_marker.png"),
                ),
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage("lib/assets/images/custom_marker.png"),
                ),
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage("lib/assets/images/custom_marker.png"),
                ),
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
