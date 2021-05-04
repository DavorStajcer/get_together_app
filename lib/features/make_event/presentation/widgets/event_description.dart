import 'package:flutter/material.dart';

class EventDescription extends StatefulWidget {
  EventDescription({Key? key}) : super(key: key);

  @override
  _EventDescriptionState createState() => _EventDescriptionState();
}

class _EventDescriptionState extends State<EventDescription> {
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      padding: EdgeInsets.only(bottom: 30),
      child: TextField(
        controller: _descriptionController,
        decoration: new InputDecoration(
          border: new OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                const Radius.circular(15.0),
              ),
              borderSide: BorderSide.none),
          filled: true,
          hintStyle: new TextStyle(color: Color.fromRGBO(255, 175, 150, 1)),
          hintText: "Type event description...",
          fillColor: Colors.white,
        ),
        maxLines: 15,
      ),
    );
  }
}
