import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:check_app/models/wiki.dart';
import 'package:check_app/services/wiki.dart';
import 'package:check_app/pages/wiki_web_view.dart';

class WikiPage extends StatefulWidget {
  final Map<String, dynamic> args;
  WikiPage(this.args);

  @override
  _WikiPageState createState() => _WikiPageState();
}

class _WikiPageState extends State<WikiPage> {
  Future<Wiki> _futureWiki;
  String capitalize(String s) => s.length > 1
      ? "${s[0].toUpperCase()}${s.substring(1)}"
      : s[0].toUpperCase();

  // Future<void> _launchLink(String url, context) async {
  //   if (await canLaunch(url)) {
  //   } else
  //     throw 'Could not open $url';
  // }

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
          title: Text("CheckApp"),
        ),
        body: TabBarView(
          children: wiki.content
              .map<Html>(
                (k) => Html(
                  padding: EdgeInsets.all(20.0),
                  data: k.body,
                  onLinkTap: (url) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WikiWebView(
                            """https://www.sheffield.ac.uk/FRAX/tool.aspx?country=55"""),
                      ),
                    );
                    //_launchLink(url, context);
                  },
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //Map data = ModalRoute.of(context).settings.arguments;
    return FutureBuilder(
      future: _futureWiki,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _showTabs(snapshot.data);
        } else if (snapshot.hasError) {
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
                ),
              ),
            ),
          );
        }
        return Scaffold(
          appBar: AppBar(),
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
