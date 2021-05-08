import 'package:flutter/material.dart';
import 'package:get_together_app/core/util/date_formater.dart';
import 'package:get_together_app/features/make_event/presentation/widgets/date_time_picker_button.dart';
import 'package:get_together_app/features/make_event/presentation/widgets/event_button_with_back_icon.dart';
import 'package:get_together_app/features/make_event/presentation/widgets/event_description.dart';

class EventDetailsScreen extends StatelessWidget {
  final Function() goFowards;
  final Function() goBack;
  EventDetailsScreen({Key? key, required this.goFowards, required this.goBack})
      : super(key: key);

  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.055),
      child: Column(
        children: [
          Flexible(
            flex: 9,
            child: EventDescription(),
          ),
          Flexible(
            flex: 3,
            child: Container(
              height: double.infinity,
              child: Row(
                children: [
                  Flexible(
                    flex: 4,
                    child: DateTimePickerButton(
                      pickerType: Picker.date,
                    ),
                  ),
                  Flexible(flex: 1, child: Container()),
                  Flexible(
                    flex: 3,
                    child: DateTimePickerButton(
                      pickerType: Picker.time,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: EventButtonWithBackIcon(
              text: "Make event",
              goBack: goBack,
              goFowards: goFowards,
            ),
          ),
        ],
      ),
    );
  }
}
