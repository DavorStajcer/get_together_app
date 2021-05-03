import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_together_app/core/util/background_drawing.dart';
import 'package:get_together_app/features/authentication/di/authentication_di.dart';
import 'package:get_together_app/features/make_event/presentation/blocs/event_card_order_cubit/event_card_order_cubit.dart';
import 'package:get_together_app/features/make_event/presentation/screens/choose_event_type.dart';
import 'package:get_together_app/features/make_event/presentation/screens/choose_location.dart';

enum EventScreen { choose_event_type, choose_location, set_detailes }

class EventHomeScreen extends StatefulWidget {
  EventHomeScreen({Key? key}) : super(key: key);

  @override
  _EventHomeScreenState createState() => _EventHomeScreenState();
}

class _EventHomeScreenState extends State<EventHomeScreen> {
  late final PageController _pc;

  @override
  void initState() {
    _pc = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pc.dispose();
    super.dispose();
  }

  void goFoward() {
    _pc.nextPage(duration: Duration(milliseconds: 500), curve: Curves.easeOut);
  }

  void goBack() {
    _pc.previousPage(
        duration: Duration(milliseconds: 500), curve: Curves.easeOut);
  }

  @override
  Widget build(BuildContext context) {
    //final screenSize = MediaQuery.of(context).size;
    return BlocProvider<EventCardOrderCubit>(
      create: (context) => getIt<EventCardOrderCubit>(),
      child: SafeArea(
        child: CustomPaint(
          painter: BackgroundDrawing(context),
          child: Column(
            children: [
              Flexible(
                flex: 1,
                child: Container(
                  alignment: Alignment.topCenter,
                  padding: EdgeInsets.only(top: 5),
                  child: Text(
                    "GeTogether",
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 35,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Flexible(
                flex: 5,
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: Colors.transparent,
                  child: PageView(
                    physics: NeverScrollableScrollPhysics(),
                    controller: _pc,
                    children: [
                      ChooseEventTypeScreen(
                          goFowards: goFoward, goBack: goBack),
                      ChooseLocationScreen(goFowards: goFoward, goBack: goBack),
                    ],
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: SizedBox(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
