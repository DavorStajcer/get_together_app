import 'package:flutter/material.dart';
import 'package:get_together_app/core/util/date_formater.dart';
import 'package:get_together_app/features/make_event/presentation/widgets/date_time_picker_text.dart';
import 'package:get_together_app/features/make_event/presentation/widgets/event_button.dart';
import 'package:get_together_app/features/make_event/presentation/widgets/event_button_with_back_icon.dart';

class EventDetailsScreen extends StatefulWidget {
  final Function() goFowards;
  final Function() goBack;
  EventDetailsScreen({Key? key, required this.goFowards, required this.goBack})
      : super(key: key);

  @override
  _EventDetailsState createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetailsScreen> {
  final TextEditingController _descriptionController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.055),
      color: Colors.green,
      child: Column(
        children: [
          Flexible(
            flex: 3,
            child: Container(
              height: double.infinity,
              child: Row(
                children: [
                  Flexible(
                    flex: 4,
                    child: DateTimePickerText(
                      text: DateFormater.getDotFormat(_selectedDate),
                    ),
                  ),
                  Flexible(flex: 1, child: Container()),
                  Flexible(
                    flex: 3,
                    child: DateTimePickerText(
                      text: _selectedTime.format(context),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 9,
            child: Container(
              height: double.infinity,
              padding: EdgeInsets.only(bottom: 30),
              child: TextField(
                decoration: new InputDecoration(
                  border: new OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(15.0),
                      ),
                      borderSide: BorderSide.none),
                  filled: true,
                  hintStyle: new TextStyle(color: Colors.grey[800]),
                  hintText: "Type event description...",
                  fillColor: Colors.white70,
                ),
                maxLines: 15,
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: EventButtonWithBackIcon(
              text: "Set details",
              goBack: widget.goBack,
              goFowards: widget.goFowards,
            ),
          ),
        ],
      ),
    );
  }
}
