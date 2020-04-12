import 'package:check_app/Notifiers/profiling_state.dart';
import 'package:flutter/material.dart';
import 'package:check_app/pages/profiling.dart';
import 'package:provider/provider.dart';
import 'package:check_app/pages/actions-list.dart';
import 'package:check_app/constants.dart';

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
      default:
        return MaterialPageRoute(
            builder: (ctx) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
