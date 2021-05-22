import 'package:flutter/material.dart';

class ServerErrorWidget extends StatelessWidget {
  final String message;
  const ServerErrorWidget(this.message, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(message),
    );
  }
}
