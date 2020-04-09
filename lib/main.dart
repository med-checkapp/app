import 'package:check_app/Notifiers/profiling_state.dart';
import 'package:flutter/material.dart';
import 'package:check_app/pages/profiling.dart';
import 'package:provider/provider.dart';
import 'package:check_app/pages/action_list.dart';


void main() => runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) {
        return ChangeNotifierProvider<ProfilingState>(
          create: (context) => ProfilingState(),
          child: Profiling(),
        );
      },
      '/actionList': (context) => ActionList(),
    },
  ),
);

