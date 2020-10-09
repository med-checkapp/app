import 'package:check_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:check_app/services/diseases.dart';
import 'package:check_app/models/diseases.dart';
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

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("Doenças relaciondas"),
        ),
        body: Container(child: _futureBuilderDisease()));
  }

  FutureBuilder _futureBuilderDisease() {
    return FutureBuilder(
      future: futureDisease,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData &&
            snapshot.connectionState == ConnectionState.done) {
          return _diseasesSelection(snapshot.data);
        }

        return snapshot.hasError
            ? Center(
                child: Text("Error"),
              )
            : Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }

  Widget _diseasesSelection(dynamic data) {
    print(data);
    return Container(
      height: SizeConfig.blockSizeVertical * 100,
      child: Column(
        children: [
          Container(
              height: SizeConfig.blockSizeVertical * 70,
              child: _diseasesListView(data)),
          RaisedButton(
            child: Text("Continuar"),
            onPressed: data != null ? _onPressContinue : null,
          )
        ],
      ),
    );
  }

  ListView _diseasesListView(dynamic data) {
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

  void _onPressContinue() {
    var keys = diseasesSelection.keys.where((key) => diseasesSelection[key]);
    Navigator.pushNamed(context, actionsListRoute, arguments: {
      'selected_diseases':
          diseases.where((disease) => keys.contains(disease.name)).toList(),
      ...widget.profile
    });
  }
}
