import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.arrow_forward,
                  color: Theme.of(context).accentColor,
                ),
                onPressed: () => Navigator.pop(context),
              )
            ],
            centerTitle: true,
            title:
                Text(widget.title, style: Theme.of(context).textTheme.display2),
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
