import 'package:flutter/material.dart';

class EditAndSettings extends StatelessWidget {
  final double picHeight;
  const EditAndSettings({Key? key, required this.picHeight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Flexible(
            flex: 1,
            child: Container(
              height: picHeight,
              padding:
                  EdgeInsets.only(top: picHeight * 0.6, right: picHeight * 0.2),
              alignment: Alignment.center,
              child: Icon(Icons.edit),
            ),
          ),
          Expanded(
              child: Container(
            width: picHeight,
            height: picHeight,
            padding: EdgeInsets.only(bottom: 15), //mimic the picture size
          )),
          Flexible(
            flex: 1,
            child: Container(
              height: picHeight,
              padding:
                  EdgeInsets.only(top: picHeight * 0.6, left: picHeight * 0.2),
              alignment: Alignment.center,
              child: Icon(
                Icons.settings,
                color: Color.fromRGBO(40, 53, 147, 1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
