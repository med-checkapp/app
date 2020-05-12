import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

const String homeRoute = '/';
const String actionsListRoute = '/actions-list';
const String wikiRoute = '/wiki';
const String serverUrl = 'ratel.ime.usp.br:3001';

Widget makeTestable(Widget widget) {
  return MediaQuery(data: MediaQueryData(), child: MaterialApp(home: widget));
}