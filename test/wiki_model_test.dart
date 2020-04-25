import 'package:test/test.dart';
import 'package:check_app/models/wiki.dart';

void main() {
  test('Counter value should be incremented', () {
    final counter = Counter();

    counter.increment();

    expect(counter.value, 1);
  });
}