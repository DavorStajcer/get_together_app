import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_together_app/features/authentication/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:get_together_app/features/make_event/presentation/widgets/event_button.dart';

class UserEventsAndLogOut extends StatelessWidget {
  final Size screenSize;
  const UserEventsAndLogOut({Key? key, required this.screenSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.125),
        child: Row(
          children: [
            Flexible(
              flex: 2,
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: double.infinity,
                child: EventButton(text: "Your events", navigate: () {}),
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(),
            ),
            Flexible(
                flex: 2,
                child: Container(
                  alignment: Alignment.center,
                  child: IconButton(
                    icon: Icon(Icons.logout),
                    onPressed: () {
                      BlocProvider.of<AuthBloc>(context).add(SignOutEvent());
                      if (ModalRoute.of(context)!.settings.name != "/")
                        Navigator.of(context).pop();
                    },
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
