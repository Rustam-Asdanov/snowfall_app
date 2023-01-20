import 'package:flutter/material.dart';
import 'package:snowfall_app/routes/about_app.dart';
import 'package:snowfall_app/routes/emergency_messages.dart';
import 'package:snowfall_app/routes/exit_app.dart';
import 'package:snowfall_app/routes/home_page.dart';
import 'package:snowfall_app/routes/sign_in.dart';

void main() {
  runApp(
    MaterialApp(
      title: "Snowall App",
      initialRoute: "/",
      routes: {
        "/": (context) => HomePage(),
        "/signIn":(context) => SignIn(),
        // "/signUp":(context) => SignUp(),
        "/messages":(context) => EmergencyMessages(),
        "/about": (context) => AboutApp(),
        "/exit": (context) => ExitApp()
      },
    ),
  );
}
