import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WikiWebView extends StatelessWidget {
  final String url;

  WikiWebView(this.url);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: WebView(
        initialUrl: url,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
