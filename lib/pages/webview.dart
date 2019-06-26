import 'package:flutter/material.dart';
import 'package:hello_flutter/drawer.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Webview extends StatefulWidget {
  String title;
  String url;
  Webview({this.title, this.url});

  @override
  _WebviewState createState() => _WebviewState();
}

class _WebviewState extends State<Webview> {
  bool _pageload = true;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            centerTitle: true,
            title: Text(widget.title),
            backgroundColor: Theme.of(context).appBarTheme.color,
            iconTheme:
                Theme.of(context).iconTheme.copyWith(color: Color(0xFFD8B945)),
            elevation: 5.0,
          ),
          drawer: MyDrawer(),
          body: Container(
              color: Colors.black,
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  WebView(
                      initialUrl: widget.url,
                      javascriptMode: JavascriptMode.unrestricted,
                      onPageFinished: (s) {
                        setState(() {
                          _pageload = false;
                        });
                      }),
                  Visibility(
                    child: Center(
                      child: SpinKitFadingCube(
                        color: Colors.white,
                        size: 50.0,
                      ),
                    ),
                    visible: _pageload,
                  )
                ],
              ))),
    );
  }
}