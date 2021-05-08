import 'package:flutter/material.dart';

class NetworkError extends StatelessWidget {
  final String message;
  const NetworkError(this.message, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(message),
    );
  }
}
