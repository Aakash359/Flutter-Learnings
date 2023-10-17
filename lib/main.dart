import 'package:flutter/material.dart';
import 'package:flutter_application_1/splash.dart';
import '/home.dart';
import '/login.dart';
import '/splash.dart';

void main() {
  runApp(const MyWidget());
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      theme: ThemeData(fontFamily: "lato"),
      routes: {
        // When navigating to the "/" route, build the HomeScreen widget.
        '/': (context) => Login(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        // '/login': (context) => Login(),
      },
    );
  }
}
