import 'package:flutter/material.dart';
import 'package:get_together_app/core/util/date_formater.dart';

enum Picker { date, time }

class DateTimePickerButton extends StatelessWidget {
  final Picker pickerType;
  const DateTimePickerButton({Key? key, required this.pickerType})
      : super(key: key);

  Future<void> _selectEventDate(
      BuildContext context, DateTime currentlySelectedDate) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: currentlySelectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2022),
      helpText: "Change event date",
      initialEntryMode: DatePickerEntryMode.input,
    );
    if (pickedDate != null && pickedDate != currentlySelectedDate)
      //TODO: change the date
      var a;
  }

  Future<void> _selectEventTime(
      BuildContext context, TimeOfDay currentlySelectedTime) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: currentlySelectedTime,
    );
  }

  @override
  Widget build(BuildContext context) {
    final DateFormater dateFormater = DateFormater();
    return Column(
      children: [
        Flexible(
          flex: 1,
          child: Container(),
        ),
        Flexible(
          flex: 3,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Container(
              height: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    flex: 2,
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Theme.of(context).primaryColor.withOpacity(0),
                            Theme.of(context).primaryColor.withOpacity(0.05),
                            Theme.of(context).primaryColor.withOpacity(0.1),
                            Theme.of(context).primaryColor.withOpacity(0.3),
                          ],
                          stops: [0.2, 0.4, 0.65, 1],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          tileMode: TileMode.repeated,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        pickerType == Picker.time
                            ? TimeOfDay.now().format(context)
                            : dateFormater.getDotFormat(DateTime.now()),
                        style: TextStyle(
                            color: Theme.of(context)
                                .primaryColor
                                .withOpacity(0.6)),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Container(
                      height: double.infinity,
                      width: double.infinity,
                      color: Theme.of(context).primaryColor.withOpacity(0.3),
                      child: IconButton(
                        icon: Icon(
                          Icons.replay_outlined,
                          color: Theme.of(context).primaryColor,
                        ),
                        onPressed: () => pickerType == Picker.time
                            ? _selectEventTime(context, TimeOfDay.now())
                            : _selectEventDate(context, DateTime.now()),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Flexible(
          flex: 1,
          child: Container(),
        ),
      ],
    );
  }
}

/* 
Theme(
    data: Theme.of(context).copyWith(
          primaryColor: Colors.amber,
        ),
    child: new Builder(
      builder: (context) => new IconButton(
                        icon: Icon(
                          Icons.replay_outlined,
                          color: Colors.white,
                        ),
                        onPressed: () => pickerType == Picker.time
                            ? _selectEventTime(context, TimeOfDay.now())
                            : _selectEventDate(context, DateTime.now()),
                      ),
          ),
    ),
  )
 */
