import 'package:flutter/material.dart';
import 'package:get_together_app/features/make_event/presentation/widgets/event_button_with_back_icon.dart';
import 'package:get_together_app/features/make_event/presentation/widgets/location_chooser.dart';

class ChooseLocationScreen extends StatelessWidget {
  final Function() goFowards;
  final Function() goBack;
  const ChooseLocationScreen(
      {Key? key, required this.goFowards, required this.goBack})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.055),
      child: Column(
        children: [
          Flexible(
            flex: 10,
            child: LocationChooser(),
          ),
          Flexible(
            flex: 1,
            child: Container(
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          Flexible(
            flex: 2,
            child: EventButtonWithBackIcon(
              text: "Set details",
              goBack: goBack,
              goFowards: goFowards,
            ),
          ),
        ],
      ),
    );
  }
}

/* 
,
 */