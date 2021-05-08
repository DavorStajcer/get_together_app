import 'package:flutter/material.dart';

class ServerError extends StatelessWidget {
  final String message;
  const ServerError(this.message, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(message),
    );
  }
}
