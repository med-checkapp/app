import 'package:check_app/models/profile_targets.dart';

class Action {
  final String id;
  final String name;
  final String wikiId;
  final String formName;
  final String disclaimer;
  final List<TargetProfile> targetProfiles;

  Action(
      {this.id,
      this.name,
      this.wikiId,
      this.targetProfiles,
      this.formName,
      this.disclaimer});

  factory Action.fromJson(Map<String, dynamic> json) {
    return Action(
        id: json["_id"] ?? "",
        name: json["name"] ?? "",
        wikiId: json["wikiID"] ?? "",
        targetProfiles: json.containsKey("targetProfiles")
            ? json["targetProfiles"]
                .map<TargetProfile>((target) => TargetProfile.fromJson(target))
                .toList()
            : [],
        formName: json["formName"] ?? "",
        disclaimer: json["disclaimer"] ?? "");
  }
}
