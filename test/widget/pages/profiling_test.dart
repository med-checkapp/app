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

    var emptySexField = find.byType(DropdownButton);
    DropdownButton<dynamic> a = emptySexField.evaluate().first.widget;
    expect(a.value, null);
  });

  testWidgets('Choose male', (WidgetTester tester) async {
    // Create the widget by telling the tester to build it.
    await tester.pumpWidget(makeTestable(ChangeNotifierProvider<ProfilingState>(
      create: (ctx) => ProfilingState(),
      child: Profiling(),
    )));

    var emptySexField = find.byType(DropdownButton);
    await tester.tap(emptySexField);
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(ValueKey("Masculino")).last);
    await tester.pumpAndSettle();
    DropdownButton<dynamic> a = emptySexField.evaluate().first.widget;
    expect(a.value, 'Masculino');
  });

  testWidgets('Choose female', (WidgetTester tester) async {
    // Create the widget by telling the tester to build it.
    await tester.pumpWidget(makeTestable(ChangeNotifierProvider<ProfilingState>(
      create: (ctx) => ProfilingState(),
      child: Profiling(),
    )));

    var emptySexField = find.byType(DropdownButton);
    await tester.tap(emptySexField);
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(ValueKey('Feminino')).last);
    await tester.pumpAndSettle();
    DropdownButton<dynamic> a = emptySexField.evaluate().first.widget;
    expect(a.value, 'Feminino');
  });

  testWidgets('Only sex field filled does not submit button',
      (WidgetTester tester) async {
    // Create the widget by telling the tester to build it.
    await tester.pumpWidget(makeTestable(ChangeNotifierProvider<ProfilingState>(
      create: (ctx) => ProfilingState(),
      child: Profiling(),
    )));

    var emptySexField = find.byType(DropdownButton);
    await tester.tap(emptySexField);
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(ValueKey('Feminino')).last);
    await tester.pumpAndSettle();
    RaisedButton rb = find.byType(RaisedButton).evaluate().last.widget;
    expect(rb.enabled, false);
  });

  testWidgets('Only age field filled does not submit button',
      (WidgetTester tester) async {
    // Create the widget by telling the tester to build it.
    await tester.pumpWidget(makeTestable(ChangeNotifierProvider<ProfilingState>(
      create: (ctx) => ProfilingState(),
      child: Profiling(),
    )));

    await tester.enterText(find.byType(TextFormField), "42");
    await tester.pumpAndSettle();
    RaisedButton rb = find.byType(RaisedButton).evaluate().last.widget;
    expect(rb.enabled, false);
  });

  testWidgets('Age and sex filleds enables submit button',
      (WidgetTester tester) async {
    // Create the widget by telling the tester to build it.
    await tester.pumpWidget(makeTestable(ChangeNotifierProvider<ProfilingState>(
      create: (ctx) => ProfilingState(),
      child: Profiling(),
    )));

    var emptySexField = find.byType(DropdownButton);
    await tester.tap(emptySexField);
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(ValueKey('Feminino')).last);
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField), "42");
    await tester.pumpAndSettle();
    RaisedButton rb = find.byType(RaisedButton).evaluate().last.widget;
    expect(rb.enabled, true);
  });
}
