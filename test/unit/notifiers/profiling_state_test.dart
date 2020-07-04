import 'package:test/test.dart';
import 'package:check_app/Notifiers/profiling_state.dart';

void main() {
  test('Start a profile with empty data', () {
    final ps = ProfilingState();
    expect(ps.idade || ps.sexo, false);
  });

  test('Clear age field', () {
    final ps = ProfilingState();
    ps.clearAge();
    expect(ps.idade, false);
  });

  test('Fill age field', () {
    final ps = ProfilingState();
    ps.fillAge();
    expect(ps.idade, true);
  });

  test('Change sex field', () {
    final ps = ProfilingState();
    final bool aux = ps.sexo;
    ps.fillSex();
    expect(aux, !ps.sexo);
  });
}
