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
      appBar: AppBar(),
      body: WebView(
        initialUrl: url,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (controller) {
          _pageController = controller;
        },
        javascriptChannels: <JavascriptChannel>{
          JavascriptChannel(
            name: 'Salve',
            onMessageReceived: (JavascriptMessage result) {
              print(result.message);
            },
          ),
        },
        onPageStarted: (_) {
          _pageController
              .evaluateJavascript("""document.onreadystatechange = function () {
                  if (document.readyState == 'interactive') {
                    document.querySelector('.tool-title').innerHTML = 'Questionario'
                  }
                }
                
              """);
        },
        onPageFinished: (_) {
          _pageController.evaluateJavascript("""

                // seleciona o nó alvo
                var target = document.querySelector('#ContentPlaceHolder1_updResult');
                
                // cria uma nova instância de observador
                var observer = new MutationObserver(function(mutations) {
                  var alvo = document.querySelector('#ContentPlaceHolder1_lbbmi');
                  Salve.postMessage(alvo.innerHTML);
            
                });
                
                // configuração do observador:
                var config = { attributes: true, childList: true, characterData: true };
                
                // passar o nó alvo, bem como as opções de observação
                observer.observe(target, config);
              """);
        },
      ),
    );
  }
}
