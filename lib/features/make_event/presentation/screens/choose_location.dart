import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_together_app/features/authentication/di/authentication_di.dart';
import 'package:get_together_app/features/make_event/presentation/blocs/maps_location_cubit/maps_location_cubit.dart';
import 'package:get_together_app/features/make_event/presentation/widgets/event_button.dart';
import 'package:get_together_app/features/make_event/presentation/widgets/event_maps.dart';

class ChooseLocationScreen extends StatelessWidget {
  final Function() goFowards;
  final Function() goBack;
  const ChooseLocationScreen(
      {Key? key, required this.goFowards, required this.goBack})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return BlocProvider<MapsLocationCubit>(
        create: (context) => getIt<MapsLocationCubit>(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.055),
          child: Column(
            children: [
              Flexible(
                flex: 10,
                child: EventMaps(),
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
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  child: Row(
                    children: [
                      IconButton(
                          icon: Icon(
                            Icons.arrow_back,
                            color: Theme.of(context).primaryColor,
                          ),
                          onPressed: goBack),
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          height: double.infinity,
                          child: EventButton(
                            text: "Descritpion",
                            navigate: goFowards,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
