import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:check_app/constants.dart';
import 'dart:async';

class WikiWebView extends StatefulWidget {
  final Map<String, dynamic> inputValues;

  WikiWebView(this.inputValues);

  @override
  _WikiWebViewState createState() => _WikiWebViewState();
}

class _WikiWebViewState extends State<WikiWebView> {
  WebViewController _pageController;
  bool finishedCalculate = false;
  String resultado = "";

  String m;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.inputValues);
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Visibility(
              visible: finishedCalculate,
              child: Text(resultado),
              replacement: CircularProgressIndicator(),
            ),
          ),
          Container(
            height: 0,
            child: Visibility(
              maintainState: true,
              visible: false,
              child: WebView(
                initialUrl:
                    "https://www.sheffield.ac.uk/FRAX/tool.aspx?country=55",
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (controller) {
                  _pageController = controller;
                  _pageController.clearCache();
                },
                javascriptChannels: <JavascriptChannel>{
                  JavascriptChannel(
                      name: 'Salve',
                      onMessageReceived: (JavascriptMessage result) {
                        print("hahaha");
                        setState(() {
                          resultado = result.message;
                          finishedCalculate = true;
                        });
                      })
                },
                onPageFinished: (_) {
<<<<<<< HEAD
                  _pageController.evaluateJavascript(_parse());

                  _pageController.evaluateJavascript(
                      "window.document.querySelector('input[type=submit]').click()");
                  print("cu1234");
                  _pageController.evaluateJavascript("""
                    var target = window.document.querySelector('#ctl00_ContentPlaceHolder1_updResult')
                    var observer = new MutationObserver(function(mutations) {
                      var alvo = window.document.querySelector('#ctl00_ContentPlaceHolder1_lbrs1');
=======
                  _pageController.evaluateJavascript("""
                    let target = window.document.querySelector('#ctl00_ContentPlaceHolder1_updResult')
                    let observer = new MutationObserver(function(mutations) {
                      let alvo = window.document.querySelector('#ctl00_ContentPlaceHolder1_lbrs1');
>>>>>>> 8955a17f08d4143715864850961694610a7d919c
                      Salve.postMessage(alvo.innerHTML);
                    });
                    var config = { attributes: true, childList: true, characterData: true };
                    observer.observe(target, config);
                  """);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _parse() {
    String string = "";
    String querySelector = "window.document.querySelector";
    fraxFormFields.forEach((key, value) {
      switch (value["type"]) {
        case "bool":
          String id = "${value['id']}${widget.inputValues[key] ? 1 : 2}";
          string += "$querySelector('input[id\$=_$id]').checked=true;\n";
          break;
        case "text":
          string +=
              "$querySelector('input[id\$=_${value['id']}]').value=${widget.inputValues[key]};\n";
          break;
        case "select":
          String id = "${value['id']}${widget.inputValues[key]}";
          string += "$querySelector('input[id\$=_$id]').checked=true;\n";
          break;
        default:
      }
    });
    return string;
  }
}
