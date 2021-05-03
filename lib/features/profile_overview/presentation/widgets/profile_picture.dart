import 'package:flutter/material.dart';

class ProfilePicture extends StatelessWidget {
  final double picHeight;
  const ProfilePicture({Key? key, required this.picHeight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: picHeight,
      height: picHeight,
      padding: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          width: 1,
          color: Colors.black12,
        ),
        image: DecorationImage(
          fit: BoxFit.fill,
          image: NetworkImage("https://i.imgur.com/BoN9kdC.png"),
        ),
        color: Colors.grey,
      ),
    );
  }
}
