import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

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
    return DefaultTabController(
      length: data.keys.length,
      child: Scaffold(
        appBar: AppBar(
            bottom: TabBar(
              //indicatorSize: TabBarIndicatorSize.label,
              isScrollable: true,
              tabs: data.keys.map((k) => Tab(text: capitalize(k))).toList()
            ),
            title: Text("CheckApp")),
        drawer: Drawer(),
        body: TabBarView(
          children: data.values.map((k) => Html(data: """<center> <strong>${capitalize(k)}</strong></center>""")).toList()

        ),
      ),
    );
  }
}
