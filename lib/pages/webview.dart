import 'package:flutter/material.dart';
import 'package:hello_flutter/drawer.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Webview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          centerTitle: true,
          title: Text('Webview'),
          backgroundColor: Theme.of(context).appBarTheme.color,
          iconTheme:
              Theme.of(context).iconTheme.copyWith(color: Color(0xFFD8B945)),
          elevation: 5.0,
        ),
        
        drawer: MyDrawer(),
        body: Container(
            color: Colors.white,
            child: WebView(
              initialUrl: 'https://pub.dev',
              javascriptMode: JavascriptMode.unrestricted,
              
            )),
      ),
    );
  }
}
