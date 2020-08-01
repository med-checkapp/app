import 'package:check_app/models/action_info.dart';

class Disease {
  final String id;
  final String name;
  final String description;
  final List<ActionInfo> actions;

  Disease({this.id, this.name, this.description, this.actions});

  factory Disease.fromJson(Map<String, dynamic> json) {
    return Disease(
        id: json['_id'],
        name: json['name'],
        description: json["description"] ?? "",
        actions: json["actions"]
            .map<ActionInfo>((action) => ActionInfo.fromJson(action))
            .toList());
  }
}
