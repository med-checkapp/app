class TargetProfile {
  final String sex;
  final int minAge;
  final int maxAge;

  TargetProfile({this.sex, this.minAge, this.maxAge});
  factory TargetProfile.fromJson(json) {
    return TargetProfile(
        sex: json["sex"], minAge: json["minAge"], maxAge: json["maxAge"]);
  }
}
