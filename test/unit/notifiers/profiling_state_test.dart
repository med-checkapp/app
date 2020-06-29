import 'package:test/test.dart';
import 'package:check_app/Notifiers/profiling_state.dart';


void main() {

  test('Start a profile with empty data', () {
    final ps = ProfilingState();
    expect(ps.getIdade() || ps.getSexo(), false);
  });

  test('Clear age field', () {
    final ps = ProfilingState();
    ps.clearIdade();
    expect(ps.getIdade() , false);
  });

   test('Fill age field', () {
    final ps = ProfilingState();
    ps.fillIdade();
    expect(ps.getIdade() , true);
  });

  test('Change sex field', () {
    final ps = ProfilingState();
    final bool aux = ps.getSexo();
    //ps.changeSexo();
    expect(aux , !ps.getSexo());
  });
 
}