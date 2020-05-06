import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:check_app/constants.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:check_app/models/wiki.dart';
import 'package:check_app/services/wiki.dart';

class WikiPage extends StatefulWidget {
  final Map<String, dynamic> args;
  WikiPage(this.args);

  @override
  _WikiPageState createState() => _WikiPageState();
}

class _WikiPageState extends State<WikiPage> {
  Future<Wiki> _futureWiki;
  String capitalize(String s) =>
      s.length > 1 ? s[0].toUpperCase() + s.substring(1) : s[0].toUpperCase();

  Future<void> _launchLink(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: true, forceWebView: true);
    } else
      throw 'Could not open $url';
  }

  @override
  void initState() {
    super.initState();
    _futureWiki = getWikiById(widget.args["wikiId"]);
  }

  DefaultTabController _showTabs(wiki) {
    return DefaultTabController(
      length: wiki.content.length,
      child: Scaffold(
        appBar: AppBar(
            bottom: TabBar(
                //indicatorSize: TabBarIndicatorSize.label,
                isScrollable: true,
                tabs: wiki.content
                    .map<Tab>((k) => Tab(text: capitalize(k.name)))
                    .toList()),
            title: Text("CheckApp")),
        body: TabBarView(
            children: wiki.content
                .map<Html>((k) => Html(
                    padding: EdgeInsets.all(20.0),
                    data: k.body,
                    onLinkTap: (url) {
                      _launchLink(url);
                    }))
                .toList()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //Map data = ModalRoute.of(context).settings.arguments;
    return FutureBuilder(
      future: _futureWiki,
      builder: (context, snapshot) {
        if (snapshot.hasData)
          return _showTabs(snapshot.data);
        else if (snapshot.hasError)
          return Scaffold(
            appBar: AppBar(),
            body: Center(
                child: Center(
                    child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "🥺",
                  style: TextStyle(fontSize: 125),
                ),
                Text(
                  "Conteúdo não disponível.",
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ))),
          );
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
