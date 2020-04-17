import 'package:flutter/material.dart';
import 'package:check_app/router.dart';
import 'package:check_app/constants.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: Router.generateRoute,
      initialRoute: wikiRoute,
    );
  }
}
