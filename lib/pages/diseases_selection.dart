import 'package:check_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:check_app/services/diseases.dart';
import 'package:check_app/models/diseases.dart';
import 'package:check_app/components/diseases_list.dart';
import 'package:check_app/config_size.dart';

class DiseasesSelection extends StatefulWidget {
  final Map<String, dynamic> profile;

  DiseasesSelection(this.profile);

  @override
  _DiseasesSelectionState createState() => _DiseasesSelectionState();
}

class _DiseasesSelectionState extends State<DiseasesSelection> {
  Future<List<Disease>> futureDisease;
  static Map<String, bool> diseasesSelection;
  static List<Disease> diseases;

  void initState() {
    super.initState();
    futureDisease = getDiseasesByProfileTarget(
        sex: widget.profile["sexo"], age: widget.profile["idade"].toString());
    if (diseasesSelection != null) {
      diseasesSelection = null;
    }
  }

  ListView diseasesListView(dynamic data) {
    if (diseasesSelection == null) {
      diseasesSelection =
          Map.fromIterable(data, key: (e) => e.name, value: (e) => true);
      diseases = data;
    }
    return ListView(
      scrollDirection: Axis.vertical,
      children: diseasesSelection.keys
          .map((key) => CheckboxListTile(
              key: GlobalKey(),
              title: Text(key),
              value: diseasesSelection[key],
              onChanged: (bool value) {
                setState(() {
                  diseasesSelection[key] = value;
                });
              }))
          .toList(),
    );
  }

  FutureBuilder _futureBuilder() {
    return FutureBuilder(
      future: futureDisease,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return diseasesListView(snapshot.data);
        } else if (snapshot.hasError) {
          return Center(
            child: Text("Error"),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    print(SizeConfig.blockSizeVertical);
    return Scaffold(
        appBar: AppBar(
          title: Text("Doenças relaciondas"),
        ),
        body: Container(
            child: Column(children: [
          Container(
            height: SizeConfig.blockSizeVertical * 70,
            child: _futureBuilder(),
          ),
          RaisedButton(
            child: Text("Continuar"),
            onPressed: () {
              var keys =
                  diseasesSelection.keys.where((key) => diseasesSelection[key]);
              Navigator.pushNamed(context, actionsListRoute, arguments: {
                'selected_diseases': diseases
                    .where((disease) => keys.contains(disease.name))
                    .toList(),
                ...widget.profile
              });
            },
          )
        ])));
  }
}
