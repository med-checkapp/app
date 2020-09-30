import 'package:check_app/pages/wiki_web_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../constants.dart';

class Informative extends StatefulWidget {
  @override
  _InformativeState createState() => _InformativeState();
}

class _InformativeState extends State<Informative> {
  bool showPercentage = false;

  @override
  Widget build(BuildContext context) {
    print("\nvalor dessa porra: $showPercentage\n");
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: <Widget>[
            Html(
              padding: EdgeInsets.all(20.0),
              data: texto_informativo_osteo,
              onLinkTap: (url) {
                //_launchLink(url, context);
              },
            ),
            FlatButton(
                color: Colors.teal[500],
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WikiWebView(
                          "http://www.sheffield.ac.uk/FRAX/tool.aspx?country=55"),
                    ),
                  ).then((_) => {
                        this.setState(() {
                          showPercentage = true;
                        })
                      });
                },
                child: Text("Abrir Calculadora")),
            if (showPercentage)
              TextField(
                onSubmitted: (rmf10) {
                  Navigator.pushNamed(
                    context,
                    moreInfoRoute,
                    arguments: {'rmf10': rmf10},
                  );
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Insira a porcentagem calculada",
                ),
              ),
          ],
        ),
      ),
    );
  }
}
