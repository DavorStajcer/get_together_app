import 'package:flutter/material.dart';
import 'package:get_together_app/features/make_event/presentation/widgets/event_button.dart';

class EventButtonWithBackIcon extends StatelessWidget {
  final String text;
  final Function() goBack;
  final Function() goFowards;
  const EventButtonWithBackIcon(
      {Key? key,
      required this.text,
      required this.goBack,
      required this.goFowards})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: Row(
        children: [
          IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: goBack),
          Expanded(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              child: EventButton(
                text: text,
                navigate: goFowards,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
