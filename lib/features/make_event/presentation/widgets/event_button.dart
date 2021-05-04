import 'package:flutter/material.dart';

class EventButton extends StatelessWidget {
  final String text;
  final Function() navigate;
  const EventButton({Key? key, required this.text, required this.navigate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(
        text,
        style: TextStyle(
          color: Theme.of(context).primaryColor.withOpacity(0.6),
        ),
      ),
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40), side: BorderSide.none),
        ),
        backgroundColor: MaterialStateProperty.all(
          Colors.white,
        ),
        elevation: MaterialStateProperty.all(0),
        overlayColor: MaterialStateProperty.resolveWith(
          (states) {
            return states.contains(MaterialState.pressed)
                ? Theme.of(context).primaryColor.withOpacity(0.1)
                : null;
          },
        ),
      ),
      onPressed: () {
        navigate();
      },
    );
  }
}
