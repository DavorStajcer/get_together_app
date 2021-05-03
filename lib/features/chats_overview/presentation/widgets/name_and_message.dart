import 'package:flutter/material.dart';

class NameAndMessage extends StatelessWidget {
  const NameAndMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                "Samantha Cruz",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 7),
                child: Text(
                  "Ive got your message. I want to tell you that you are not that OG as you think. I am CJ in real life motherfucker.",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
