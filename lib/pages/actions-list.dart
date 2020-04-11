import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ActionsList extends StatefulWidget {
  @override
  _ActionsListState createState() => _ActionsListState();
}

class _ActionsListState extends State<ActionsList> {
  Future<List<Disease>> futureDisease;
  final Map<int, bool> expandedTiles = {};

  @override
  void initState() {
    super.initState();
    futureDisease = fetchDisease();
  }

  bool _initiallyExpanded(index) {
    return expandedTiles[index] != null ? expandedTiles[index] : false;
  }

  void _onExpansionChanged(bool state, index) {
    if (state) {
      setState(() {
        expandedTiles[index] = true;
        expandedTiles.forEach((key, val) {
          if (key != index) expandedTiles[key] = false;
        });
      });
    }
  }

  List<Widget> _actionList(actions) {
    // return actions
    //     .map<Widget>((action) => ListTile(
    //         subtitle: Text(action["disclaimer"]),
    //         key: PageStorageKey(action["_id"]),
    //         title: Text(action["name"])))
    //     .toList();

    return actions
        .map<Widget>(
          (action) => Card(
              child: Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.fromLTRB(20, 5, 0, 0),
                  width: double.maxFinite,
                  height: 150,
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        action["disclaimer"],
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(action["name"]),
                    )
                  ]))),
        )
        .toList();
  }

  ListView _diseasesList(diseases) {
    return ListView.builder(
        padding: EdgeInsets.all(15),
        itemCount: diseases.length,
        itemBuilder: (context, index) {
          var disease = diseases[index];
          return ExpansionTile(
            initiallyExpanded: _initiallyExpanded(index),
            onExpansionChanged: (state) => _onExpansionChanged(state, index),
            key: GlobalKey(),
            title: Text(
              disease.name,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
            ),
            subtitle: Text(disease.description),
            children: _actionList(disease.actions),
          );
        });
  }

  FutureBuilder _futureBuilder() {
    return FutureBuilder(
      future: futureDisease,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _diseasesList(snapshot.data);
        } else if (snapshot.hasError) {
          print(snapshot.error);
          return Center(child: Text("Error"));
        }
        return CircularProgressIndicator();
      },
    );
  }

  Future<List<Disease>> fetchDisease() async {
    final response = await http.get("http://localhost:3000/diseases");

    if (response.statusCode == 200)
      return json
          .decode(response.body)
          .map<Disease>((item) => Disease.fromJson(item))
          .toList();
    else
      throw Exception('Faild to get Disease');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Doenças relacionadas"),
      ),
      body: Container(
          child: Column(children: [
            Container(
              child: Text(
                "Perfil (descrever o perfil aqui)",
                style: TextStyle(fontSize: 20),
              ),
              margin: EdgeInsets.fromLTRB(0, 50, 0, 10),
            ),
            Container(
                child: _futureBuilder(),
                height: MediaQuery.of(context).size.height * 0.60)
          ]),
          alignment: Alignment.center,
          color: Colors.white10),
    );
  }
}

class Disease {
  final String id;
  final String name;
  final String description;
  final List<dynamic> actions;

  Disease({this.id, this.name, this.description, this.actions});

  factory Disease.fromJson(Map<String, dynamic> json) {
    return Disease(
        id: json['_id'],
        name: json['name'],
        description: "",
        actions: json["actions"]);
  }
}
