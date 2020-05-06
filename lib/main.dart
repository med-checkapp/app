import 'package:flutter/material.dart';
import 'package:check_app/router.dart';
import 'package:check_app/constants.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        buttonTheme: ButtonThemeData(
            buttonColor: Colors.teal, textTheme: ButtonTextTheme.primary),
        primaryColor: Colors.teal,
      ),
      onGenerateRoute: Router.generateRoute,
      initialRoute: homeRoute,
    );
  }
}
