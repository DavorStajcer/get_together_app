import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_together_app/features/authentication/di/authentication_di.dart';
import 'package:get_together_app/features/authentication/presentation/bloc/auth_bloc/auth_bloc.dart';

import 'package:get_together_app/features/authentication/presentation/bloc/form_bloc/form_bloc.dart';

import 'package:get_together_app/features/authentication/presentation/screens/home_screen.dart';
import 'package:get_together_app/features/authentication/presentation/widgets/auth_button.dart';
import 'package:get_together_app/features/authentication/presentation/widgets/auth_form.dart';
import 'package:get_together_app/features/authentication/presentation/widgets/auth_mode_picker.dart';

class AuthScreen extends StatelessWidget {
  static final String route = "/auth_screen";
  AuthScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: BlocProvider<FormBloc>(
          create: (_) => getIt<FormBloc>(),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: screenSize.height),
            child: BlocListener<AuthBloc, AuthState>(
              listener: (context, state) async {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                if (state is AuthFailed) {
                  await showDialog(
                      context: context,
                      builder: (dialogContext) => AlertDialog(
                            content: Text(state.message),
                            actions: [
                              TextButton(
                                  onPressed: () =>
                                      Navigator.of(dialogContext).pop(),
                                  child: Text("Ok"))
                            ],
                          ));
                }

                if (state is AuthSuccessfull) {
                  Navigator.of(context).pushNamed(HomeScreen.route);
                }
              },
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  AuthBackground(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      AuthForm(screenSize),
                      AuthButton(),
                    ],
                  ),
                  BottomAuthPicker(screenSize),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AuthBackground extends StatelessWidget {
  const AuthBackground({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("lib/assets/images/background_auth_image.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.black45,
        )
      ],
    );
  }
}
