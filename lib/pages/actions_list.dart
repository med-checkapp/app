import 'package:check_app/components/diseases_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:check_app/config_size.dart';
import 'package:check_app/models/diseases.dart';
import 'package:check_app/services/diseases.dart';

class ActionsList extends StatefulWidget {
  final Map<String, dynamic> profile;

  ActionsList(this.profile);

  @override
  _ActionsListState createState() => _ActionsListState();
}

class _ActionsListState extends State<ActionsList> {
  Future<List<Disease>> futureDisease;
  final Map<int, bool> expandedTiles = {};

  @override
  void initState() {
    super.initState();
    futureDisease = getDiseasesByProfileTarget(
        sex: widget.profile["sexo"], age: widget.profile["idade"].toString());
  }

  FutureBuilder _futureBuilder() {
    return FutureBuilder(
      future: futureDisease,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return DiseasesList(snapshot.data);
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

    return Scaffold(
      appBar: AppBar(
        title: Text("Doenças relacionadas"),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              height: SizeConfig.blockSizeVertical * 5,
              padding: EdgeInsets.all(5),
              color: Color.fromRGBO(143, 255, 214, 0.5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    "Sexo: ${widget.profile['sexo']}",
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    "Idade: ${widget.profile['idade']}",
                    style: TextStyle(fontSize: 20),
                  )
                ],
              ),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                    child: Text(
                      "Ações sugeridas para o profile",
                      style: TextStyle(
                          fontSize: 21,
                          decorationStyle: TextDecorationStyle.solid),
                    ),
                  ),
                  Container(
                    child: _futureBuilder(),
                    height: SizeConfig.blockSizeVertical * 70,
                  ),
                ],
              ),
              margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
            ),
          ],
        ),
        alignment: Alignment.center,
        color: Colors.white30,
      ),
    );
  }
}
