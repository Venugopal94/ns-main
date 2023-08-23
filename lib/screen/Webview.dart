import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:robustremedy/screen/TransactionResult.dart';
import 'package:webview_flutter/webview_flutter.dart';


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


  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Payment')),
        body: WebView(onPageStarted: (url)
          {
            print("url "+url);
            Uri uri=Uri.parse(url);
            if(uri.host=="localhost")
              {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>TransactionResult(uri,this.widget.token,this.widget.data) ));
              }
            print(uri);
            // print("Uri host"+uri.host);
            // print("Uri path"+uri.path);
            // print("Uri queryparameter"+uri.queryParameters.toString());

            // if(Uri.parse(url).)
            //   {
            //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>TransactionResult() ));
            //   }
            },
          initialUrl: this.widget.url,
          javascriptMode: JavascriptMode.unrestricted,

        )
    );
  }

  @override
  void initState() {
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    super.initState();
  }
}
