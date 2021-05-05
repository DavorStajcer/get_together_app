import 'package:flutter/material.dart';
import 'package:get_together_app/features/make_event/presentation/widgets/event_button.dart';

class JoinButton extends StatefulWidget {
  JoinButton({Key? key}) : super(key: key);

  @override
  _JoinButtonState createState() => _JoinButtonState();
}

class _JoinButtonState extends State<JoinButton> {
  @override
  Widget build(BuildContext context) {
    return EventButton(
      text: "Leave event",
      buttonColor: Theme.of(context).primaryColor.withOpacity(0.6),
      textColor: Colors.white,
      navigate: () {},
    );
  }
}
