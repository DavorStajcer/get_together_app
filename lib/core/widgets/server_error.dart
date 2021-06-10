import 'package:flutter/material.dart';
import 'package:get_together_app/features/make_event/presentation/widgets/event_button.dart';

class ServerErrorWidget extends StatelessWidget {
  final String message;
  final Function() onReload;
  const ServerErrorWidget(
    this.message, {
    Key? key,
    required this.onReload,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Flexible(
            flex: 5,
            child: Center(
              child: Icon(
                Icons.error_outline,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          Flexible(
              flex: 1,
              child: EventButton(text: "Refresh page", navigate: onReload)),
        ],
      ),
    );
  }
}
