import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const String route = "/home_screen";

  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  AnimationController someAnimationController;
  Animation someAnimation;

  @override
  void initState() {
    someAnimationController =
        AnimationController(duration: Duration(seconds: 3), vsync: this);
    someAnimation =
        Tween<double>(begin: 300.0, end: 70.0).animate(someAnimationController)
          ..addListener(() {
            setState(() {});
          });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Text("LOGUT"),
        onPressed: () async {
          await FirebaseAuth.instance.signOut();
          Navigator.of(context).pop();
        },
        backgroundColor: Colors.grey,
      ),
      body: Center(
        child: Container(
          width: someAnimation.value,
          height: 70,
          //  alignment: FractionalOffset.center,
          child: ElevatedButton(
            onPressed: () async {
              print("PRESSED");
              try {
                await someAnimationController.forward();
                await someAnimationController.reverse();
                print("animations done apperently");
              } on TickerCanceled {
                log("Ticker cancelled");
              }
            },
            child: someAnimation.value < 100
                ? CircularProgressIndicator(
                    backgroundColor: Colors.white,
                  )
                : Text("Animation"),
          ),
        ),
      ),
    );
  }
}
