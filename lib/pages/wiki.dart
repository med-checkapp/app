import 'package:flutter/material.dart';

class Wiki extends StatelessWidget {

  String capitalize(String s) => s.length > 1? s[0].toUpperCase() + s.substring(1): s[0].toUpperCase();


  @override
  Widget build(BuildContext context) {
    Map data = {
      "geral": "DMO",
      "razoes": "razoes",
      "clinico": "clinico",
      "ferramentas": "ferramentas",
      "outros": "outros"
    };
    //Map data = ModalRoute.of(context).settings.arguments;
    print(data.keys.length);
    return DefaultTabController(
      length: data.keys.length,
      child: Scaffold(

        appBar: AppBar(
            bottom: TabBar(
              tabs: data.keys.map((k) => Tab(text: capitalize(k))).toList()
            ),
            title: Text("CheckApp")),
        drawer: Drawer(),
        body: TabBarView(
          children: data.values.map((k) => Tab(text: capitalize(k))).toList(),
        ),

      ),
    );
  }
}
