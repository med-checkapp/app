import 'package:test/test.dart';
import 'package:check_app/pages/profiling.dart';


void main() {

  test('Return true for a valid age', () {
    final p = Profiling();
    final state = p.createState();
    dynamic result = state.validate(120, "Feminino");
    expect(result['isValid'], true);
  });

  test('Return false for an invalid age', () {
    final p = Profiling();
    final state = p.createState();
    dynamic result = state.validate(140, "Feminino");
    dynamic result2 = state.validate(-2, "Feminino");
    expect(result['isValid'] && result2['isValid'], false);
  });

  test('Return true for a valid sex', () {
   final p = Profiling();
    final state = p.createState();
    dynamic result = state.validate(42, "Feminino");
    expect(result['isValid'], true);
  });

  test('Return true for an invalid sex', () {
    final p = Profiling();
    final state = p.createState();
    dynamic result = state.validate(42, "femea");
    expect(result['isValid'], false);
  });
 
}