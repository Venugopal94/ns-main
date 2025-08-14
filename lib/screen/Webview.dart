import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:robustremedy/screen/TransactionResult.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../themes/light_color.dart';


class WebViewLoad extends StatefulWidget {

  String url="";
  String token;
  var data;

  WebViewLoad(this.url,this.token,this.data){
    print("datawebview"+data.toString());
  }

  WebViewLoadUI createState() => WebViewLoadUI();

}


class WebViewLoadUI extends State<WebViewLoad>{
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            CircularProgressIndicator.adaptive(
              value: progress.toDouble(),
            );
          },
          onPageStarted: (String url) {
            print("url "+url);
            Uri uri=Uri.parse(url);
            if(url.contains("/order-status.php"))
            {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>TransactionResult(uri,this.widget.token,this.widget.data) ));
            }
            print(uri);
            // print("Uri host"+uri.host);
            // print("Uri path"+uri.path);
            print("Uri queryparameter"+uri.queryParameters.toString());

            // if(Uri.parse(url).)
            //   {
            //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>TransactionResult() ));
            //   }
          },
          onPageFinished: (String url) {
            Uri uri=Uri.parse(url);
            if(url.contains("/order-status.php"))
            {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>TransactionResult(uri,this.widget.token,this.widget.data) ));
            }
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(this.widget.url));
  }
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            title: Text('Payment', style: TextStyle(fontFamily: "Roboto",)),
          backgroundColor: LightColor.yellowColor,
          foregroundColor: LightColor.midnightBlue,
        ),
        body: WebViewWidget(controller: _controller,)
    );
  }
}
