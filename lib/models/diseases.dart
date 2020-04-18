import 'package:check_app/models/actions.dart';

class Disease {
  final String id;
  final String name;
  final String description;
  final List<Action> actions;

  Disease({this.id, this.name, this.description, this.actions});

  factory Disease.fromJson(Map<String, dynamic> json) {
    return Disease(
        id: json['_id'],
        name: json['name'],
        description: json["description"] ?? "",
        actions: json["actions"]
            .map<Action>((action) => Action.fromJson(action))
            .toList());
  }
}
