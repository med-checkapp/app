import 'package:check_app/Notifiers/profiling_state.dart';
import 'package:flutter/material.dart';
import 'package:check_app/pages/profiling.dart';
import 'package:provider/provider.dart';
import 'package:check_app/pages/actions_list.dart';
import 'package:check_app/constants.dart';
import 'package:check_app/pages/wiki.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        return MaterialPageRoute(
            builder: (ctx) => ChangeNotifierProvider<ProfilingState>(
                  create: (ctx) => ProfilingState(),
                  child: Profiling(),
                ));
      case actionsListRoute:
        return MaterialPageRoute(
            builder: (ctx) => ActionsList(settings.arguments));
      case wikiRoute:
        return MaterialPageRoute(
            builder: (ctx) => Wiki(settings.arguments)
        );
      default:
        return MaterialPageRoute(
            builder: (ctx) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
