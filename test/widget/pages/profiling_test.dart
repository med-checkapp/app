import 'package:check_app/Notifiers/profiling_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:check_app/pages/profiling.dart';
import 'package:check_app/constants.dart';
import 'package:provider/provider.dart';


void main() {

  testWidgets('Builds age field', (WidgetTester tester) async {
    // Create the widget by telling the tester to build it.
    await tester.pumpWidget(makeTestable(ChangeNotifierProvider<ProfilingState>(
      create: (ctx) => ProfilingState(),
      child: Profiling(),
    )));
    var textField = find.byType(TextFormField);

    expect(textField, findsOneWidget);
  });

  testWidgets('Builds sex field', (WidgetTester tester) async {
    // Create the widget by telling the tester to build it.
    await tester.pumpWidget(makeTestable(ChangeNotifierProvider<ProfilingState>(
      create: (ctx) => ProfilingState(),
      child: Profiling(),
    )));
    var sexField = find.byType(DropdownButtonHideUnderline);


    expect(sexField, findsOneWidget);
  });

  testWidgets('Age field starts empty', (WidgetTester tester) async {
    // Create the widget by telling the tester to build it.
    await tester.pumpWidget(makeTestable(ChangeNotifierProvider<ProfilingState>(
      create: (ctx) => ProfilingState(),
      child: Profiling(),
    )));

    var emptyTextField = find.text('');

    expect(emptyTextField, findsOneWidget);
  });

  testWidgets('Sex field starts empty', (WidgetTester tester) async {
    // Create the widget by telling the tester to build it.
    await tester.pumpWidget(makeTestable(ChangeNotifierProvider<ProfilingState>(
      create: (ctx) => ProfilingState(),
      child: Profiling(),
    )));

    var emptySexField2 = find.byType(DropdownButtonHideUnderline);
    print("Pão \n\n");
    print(emptySexField2);
    print("Pão \n\n");
    var emptySexField = find.descendant(of: find.byType(DropdownButtonHideUnderline),
                                            matching: find.byType(DropdownButton));
    expect(emptySexField , findsOneWidget);
  });

}