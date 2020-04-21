import 'package:check_app/models/tab.dart';

class Wiki {
  final List<Tab> content;

  Wiki({this.content});

  factory Wiki.fromJson(Map<String, dynamic> json) {
    return Wiki(
      content: json['content']
          .map<Tab>((tab) => Tab.fromJson(tab))
          .toList());
  }
}