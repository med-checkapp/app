import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ActionsList extends StatefulWidget {
  @override
  _ActionsListState createState() => _ActionsListState();
}

class _ActionsListState extends State<ActionsList> {
  Future<List<Disease>> futureDisease;
  @override
  void initState() {
    super.initState();

    futureDisease = fetchDisease();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Container(
          child: FutureBuilder(
            future: futureDisease,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      var data = snapshot.data[index];

                      return ExpansionTile(
                        key: PageStorageKey(data.id),
                        title: Text(data.name),
                        subtitle: Text(data.description),
                        children: ((data) {
                          List<ListTile> actions = [];
                          for (dynamic action in data) {
                            print(" hello $action");
                            actions.add(ListTile(
                                subtitle: Text(action["disclaimer"]),
                                key: PageStorageKey(action["_id"]),
                                title: Text(action["name"])));
                          }
                          return actions;
                        })(data.actions),
                      );
                    });
              } else if (snapshot.hasError) {
                print(snapshot);
                return Text("Error");
              }
              return CircularProgressIndicator();
            },
          ),
          alignment: Alignment(0, 0),
          color: Color.fromRGBO(143, 198, 198, 0.2),
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          margin: EdgeInsets.fromLTRB(30, 30, 20, 20),
        ),
        alignment: Alignment.center,
        color: Colors.white10);
  }

  Future<List<Disease>> fetchDisease() async {
    final response = await http.get("http://localhost:3000/disease");
    print(response.body);
    if (response.statusCode == 200) {
      List<Disease> diseases = [];
      json.decode(response.body)["diseases"].forEach((item) {
        diseases.add(Disease.fromJson(item));
      });
      return diseases;
    } else {
      throw Exception('Faild to get Disease');
    }
  }
}

class Disease {
  final String id;
  final String name;
  final String description;
  final List<dynamic> actions;

  Disease({this.id, this.name, this.description, this.actions});

  factory Disease.fromJson(Map<String, dynamic> json) {
    print(json);
    return Disease(
        id: json['_id'],
        name: json['name'],
        description: "",
        actions: json["actions"]);
  }
}
