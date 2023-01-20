import 'package:flutter/material.dart';
import 'package:snowfall_app/routes/about_app.dart';
import 'package:snowfall_app/routes/exit_app.dart';
import 'package:snowfall_app/routes/home_page.dart';

void main() {
  runApp(
    MaterialApp(
      title: "Snowall App",
      initialRoute: "/",
      routes: {
        "/": (context) => HomePage(),
        // "/signIn":(context) => SignIn(),
        // "/signUp":(context) => SignUp(),
        "/about": (context) => const AboutApp(),
        "/exit": (context) => const ExitApp()
      },
    ),
  );
}
