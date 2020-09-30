import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WikiWebView extends StatelessWidget {
  final String url;
  WebViewController _pageController;
  String m;

  WikiWebView(this.url);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, true);
            print("valor clicado");
          },
        ),
      ),
      body: WebView(
        initialUrl: url,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
