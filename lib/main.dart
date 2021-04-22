import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_together_app/core/error/failure.dart';
import 'package:get_together_app/features/authentication/di/authentication_di.dart';
import 'package:get_together_app/features/authentication/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:get_together_app/features/authentication/presentation/bloc/auth_check_bloc/authentication_check_bloc.dart';
import 'package:get_together_app/features/authentication/presentation/screens/authentication_screen.dart';
import 'package:get_together_app/features/authentication/presentation/screens/home_screen.dart';
import 'package:get_together_app/features/authentication/presentation/screens/splash_screen.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  init(); //init getIt
  runApp(GetTogetherApp());
}

class GetTogetherApp extends StatefulWidget {
  const GetTogetherApp({Key key}) : super(key: key);

  @override
  _GetTogetherAppState createState() => _GetTogetherAppState();
}

class _GetTogetherAppState extends State<GetTogetherApp> {
  AuthenticationCheckBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = getIt<AuthenticationCheckBloc>();
    bloc?.add(ApplicationStarted());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primaryColor: Color.fromRGBO(255, 109, 64, 1)),
        home: BlocProvider<AuthBloc>(
            create: (_) => getIt<AuthBloc>(),
            child: BlocProvider<AuthenticationCheckBloc>(
              create: (_) => getIt<AuthenticationCheckBloc>(),
              child: BlocConsumer<AuthenticationCheckBloc,
                      AuthenticationCheckState>(
                  bloc: bloc,
                  listener: (context, state) {
                    if (state is ServerErrorState)
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: Text("Automatic atuhentication failed."),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    child: Text("Ok"),
                                  ),
                                ],
                              ));
                  },
                  builder: (context, state) {
                    print("STATE -> $state");
                    if (state is AuthenticationCheckInitialState)
                      return SplashScreen();

                    if (state is UserLoggedInState) return HomeScreen();
                    return AuthScreen();
                  }),
            )),
        routes: {
          HomeScreen.route: (_) => HomeScreen(),
          AuthScreen.route: (_) => AuthScreen(),
        });
  }
}
