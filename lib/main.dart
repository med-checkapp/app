import 'package:check_app/Notifiers/profiling_state.dart';
import 'package:flutter/material.dart';
import 'package:check_app/pages/profiling.dart';
import 'package:check_app/Notifiers/profiling_state.dart';
import 'package:provider/provider.dart';


void main() => runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) {
        return ChangeNotifierProvider<ProfilingState>(
          create: (context) => ProfilingState(),
          child: Profiling(),
        );
      },
    },
  ),
);

