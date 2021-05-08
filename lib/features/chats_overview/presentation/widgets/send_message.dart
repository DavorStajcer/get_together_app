import 'package:flutter/material.dart';

class SendMessage extends StatelessWidget {
  const SendMessage({Key? key}) : super(key: key);

  InputBorder _buildInputPorder() => OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.0),
        borderSide: BorderSide(color: Colors.white, style: BorderStyle.solid),
      );

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 7,
          child: TextFormField(
            decoration: InputDecoration(
              hintText: "Message",
              hintStyle: TextStyle(
                color: Theme.of(context).primaryColor.withOpacity(0.3),
              ),
              focusedBorder: _buildInputPorder(),
              enabledBorder: _buildInputPorder(),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
        ),
        Flexible(
          flex: 2,
          child: IconButton(
              color: Theme.of(context).primaryColor,
              icon: Icon(Icons.send),
              onPressed: () {
                //TODO: Send a message
              }),
        )
      ],
    );
  }
}
