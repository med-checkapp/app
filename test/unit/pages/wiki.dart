import 'package:test/test.dart';
import 'package:check_app/pages/wiki_page.dart';


void main() {

  test('Return a capitalized string', () {
    final w = WikiPage({});
    final state = w.createState();
    String result = state.capitalize("feminino");
    expect(result, "Feminino");
  });

 
}