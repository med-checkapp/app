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
    futureDisease = fetchDisease(widget.profile);
  }

  bool _initiallyExpanded(index) {
    return expandedTiles[index] != null ? expandedTiles[index] : false;
  }

  void _onExpansionChanged(bool state, int index) {
    if (state) {
      setState(() {
        expandedTiles[index] = true;
        expandedTiles.forEach((key, val) {
          if (key != index) expandedTiles[key] = false;
        });
      });
    }
  }

  List<Widget> _actionsList(actions) {
    return actions
        .map<Widget>(
          (action) => Card(
            child: Container(
                padding: EdgeInsets.fromLTRB(20, 5, 0, 0),
                width: SizeConfig.screenWidth,
                height: SizeConfig.blockSizeVertical * 10,
                color: Colors.white12,
                child: Column(children: [
                  ListTile(
                    leading: Icon(IconData(0xe57b, fontFamily: 'MaterialIcons'),
                        color: Colors.amber),
                    title: Text(action.name,
                        style: TextStyle(
                          fontSize: 18,
                        )),
                    subtitle: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Text(
                        action.disclaimer,
                      ),
                    ),
                  ),
                ])),
          ),
        )
        .toList();
  }

  ListView _diseasesList(diseases) {
    return ListView.builder(
        padding: EdgeInsets.all(1),
        itemCount: diseases.length,
        itemBuilder: (context, index) {
          var disease = diseases[index];
          return ExpansionTile(
            initiallyExpanded: _initiallyExpanded(index),
            onExpansionChanged: (state) => _onExpansionChanged(state, index),
            key: GlobalKey(),
            title: Text(
              disease.name,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w300),
            ),
            subtitle: Text(disease.description),
            children: _actionsList(disease.actions),
          );
        });
  }

  FutureBuilder _futureBuilder() {
    return FutureBuilder(
      future: futureDisease,
      builder: (context, snapshot) {
        if (snapshot.hasData)
          return _diseasesList(snapshot.data);
        else if (snapshot.hasError) return Center(child: Text("Error"));
        return Center(child: CircularProgressIndicator());
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
            child: Column(children: [
              Container(
                height: SizeConfig.blockSizeVertical * 5,
                padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                color: Color.fromRGBO(143, 255, 214, 0.5),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: Text(
                      "Sexo: ${widget.profile['sexo']}",
                      style: TextStyle(fontSize: 20),
                    )),
                    Expanded(
                        child: Text(
                      "Idade: ${widget.profile['idade']}",
                      style: TextStyle(fontSize: 20),
                    ))
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
              )
            ]),
            alignment: Alignment.center,
            color: Colors.white30));
  }
}
