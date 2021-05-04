import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_together_app/core/util/background_drawing.dart';
import 'package:get_together_app/core/widgets/get_together_title.dart';
import 'package:get_together_app/features/profile_overview/presentation/widgets/profile_card.dart';
import 'package:get_together_app/features/profile_overview/presentation/widgets/user_events_and_log_out.dart';
import '../../../authentication/presentation/bloc/auth_bloc/auth_bloc.dart';
import '../../../home/presentation/home_screen.dart';

class ProfileOverviewScreen extends StatelessWidget {
  const ProfileOverviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final profilePicHeight = screenSize.width * 0.25;
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        final String? routeName = ModalRoute.of(context)!.settings.name;
        if (state is AuthSuccessfull &&
            routeName != null &&
            routeName == HomeScreenWidget.route) Navigator.of(context).pop();
      },
      child: SafeArea(
        child: CustomPaint(
          painter: BackgroundDrawing(context),
          child: Column(
            children: [
              Flexible(
                flex: 2,
                child: GetTogetherTitle(
                  textColor: Colors.white.withOpacity(0.9),
                ),
              ),
              Flexible(
                flex: 6,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: 450,
                  ),
                  child: Container(
                    width: screenSize.width * 0.75,
                    height: double.infinity,
                    child: ProfileCard(picHeight: profilePicHeight),
                  ),
                ),
              ),
              Flexible(
                flex: 2,
                child: UserEventsAndLogOut(
                  screenSize: screenSize,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
