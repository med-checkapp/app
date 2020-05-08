import 'package:test/test.dart';
import 'dart:convert';
import 'package:check_app/models/tab.dart';
import 'package:check_app/Notifiers/profiling_state.dart';


void main() {

  test('Start a profile with empty data', () {
    final ps = ProfilingState();
    expect(ps.getIdade() || ps.getSexo(), false);
  });

  test('Clear age field', () {
    final ps = ProfilingState();
    ps.esvaziarIdade();
    expect(ps.getIdade() , false);
  });

   test('Fill age field', () {
    final ps = ProfilingState();
    ps.preencherIdade();
    expect(ps.getIdade() , true);
  });

  test('Change sex field', () {
    final ps = ProfilingState();
    final bool aux = ps.getSexo();
    ps.changeSexo();
    expect(aux , !ps.getSexo());
  });
 
}