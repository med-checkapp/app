

class Tab {
  final String name;
  final String body;

  Tab({this.name, this.body});

  factory Tab.fromJson(Map<String, dynamic> json) {
    return Tab(
        name: json['name']?? "",
        body: json['body'] ?? "");
  }
}