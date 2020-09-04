import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../constants.dart';

class Informative extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          Html(
            padding: EdgeInsets.all(20.0),
            data: texto_informativo_osteo,
            onLinkTap: (url) {
              //_launchLink(url, context);
            },
          ),
          ListTile(
            leading: Container(
              height: 20.0,
              width: 20.0,
              decoration: BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
              ),
            ),
            title: Text("Preencha o resultado do questionario frax ao lado"),
          ),
        ],
      ),
    );
  }
}
