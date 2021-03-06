import 'package:check_app/pages/more_info.dart';
import 'package:check_app/pages/results.dart';
import 'package:check_app/notifiers/profiling_state.dart';
import 'package:flutter/material.dart';
import 'package:check_app/pages/profiling.dart';
import 'package:provider/provider.dart';
import 'package:check_app/pages/actions_list.dart';
import 'package:check_app/constants.dart';
import 'package:check_app/pages/wiki_page.dart';
import 'package:check_app/pages/diseases_selection.dart';
import 'package:check_app/pages/frax.dart';

class RouterConfig {
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
            builder: (ctx) => WikiPage(settings.arguments));
      case diseasesSelection:
        return MaterialPageRoute(
            builder: (ctx) => DiseasesSelection(settings.arguments));
      case fraxRoute:
        return MaterialPageRoute(builder: (ctx) => Frax());
      case moreInfoRoute:
        return MaterialPageRoute(
            builder: (ctx) => MoreInfo(settings.arguments));
      case resultsRoute:
        return MaterialPageRoute(builder: (ctx) => Results());
      default:
        return MaterialPageRoute(
            builder: (ctx) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
