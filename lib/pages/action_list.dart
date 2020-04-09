import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class ActionList extends StatefulWidget {
  @override
  _ActionListState createState() => _ActionListState();
}

class Disease {
  dynamic disease;
  bool isExpanded;

  Disease(this.disease, this.isExpanded);
}

class _ActionListState extends State<ActionList> {
  dynamic diseases_list;
  String url = 'https://my-json-server.typicode.com/WanderDouglas/db-checkapp/disseas';

  @override
  Widget build(BuildContext context) {
    //Map data = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('CheckApp'),
      ),
      drawer: Drawer(),
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
              child: Text("Ações recomendadas")
          ),
          FutureBuilder(
            future: http.get(url),
            builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  diseases_list = jsonDecode(snapshot.data.body).map((d) => Disease(d, false)).toList();
                  print("Chamei o build");
                  return SingleChildScrollView(
                    child: Container(
                      child: ExpansionPanelList(
                        expansionCallback: (index, isExpanded) {
                          setState(() {
                            diseases_list[index].isExpanded =  !diseases_list[index].isExpanded;
                          });
                        },
                        children: diseases_list.map<ExpansionPanel>((d) {
                          return ExpansionPanel(
                            headerBuilder: (context, isExpanded) {
                              return ListTile(title: Text(d.disease['name']));
                            },
                            body: Text("Ação")
                          );
                        }).toList(),
                      )
                    )
                  );

              }
                else {
                  return Center(child: CircularProgressIndicator());
                }
            },
          )


        ],
      ),
    );
  }




}
