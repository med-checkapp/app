import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  home: Scaffold(
    body: Center(
      child: Text(
        "CheckApp",
        style: TextStyle(
          fontSize: 32.0,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.5,
          color: Colors.green[200],
        ),
      )
    ),
  ),
));

