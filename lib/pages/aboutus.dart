import 'package:flutter/material.dart';
import 'package:hello_flutter/model/about_model.dart';
import 'package:scoped_model/scoped_model.dart';
import '../scoped_model.dart';
import '../drawer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AboutUs extends StatefulWidget {
  final MainModel model;
  const AboutUs(this.model);

  @override
  State<StatefulWidget> createState() {
    return _AboutUsState();
  }
}

class _AboutUsState extends State<AboutUs> {
  @override
  void initState() {
    widget.model.getAboutData();
    super.initState();
  }

  Widget _buildManagement(String data) {
    Widget _content = Container(width: 0, height: 0);
    if (data.length > 0) {
      _content = Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          textDirection: TextDirection.rtl,
          children: <Widget>[
            Expanded(
              child: Text(
                'نام متصدی :',
                textDirection: TextDirection.rtl,
                style: TextStyle(color: Colors.white),
              ),
            ),
            Expanded(
              child: Text(
                '${data}',
                textDirection: TextDirection.rtl,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      );
    }
    return _content;
  }

  Widget _buildCell(List<dynamic> data) {
    Widget _content = Container(width: 0, height: 0);
    if (data.isNotEmpty) {
      _content = Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          textDirection: TextDirection.rtl,
          children: <Widget>[
            Expanded(
              child: Text(
                ' تلفن همراه :',
                textDirection: TextDirection.rtl,
                style: TextStyle(color: Colors.white),
              ),
            ),
            Expanded(
              child: Text(
                data.join(','),
                textDirection: TextDirection.rtl,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      );
    }

    return _content;
  }

  Widget _buildTell(List<dynamic> data) {
    Widget _content = Container(width: 0, height: 0);
    if (data.isNotEmpty) {
      _content = Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          textDirection: TextDirection.rtl,
          children: <Widget>[
            Expanded(
              child: Text(
                ' تلفن ثابت :',
                textDirection: TextDirection.rtl,
                style: TextStyle(color: Colors.white),
              ),
            ),
            Expanded(
              child: Text(
                data.join(','),
                textDirection: TextDirection.rtl,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      );
    }
    return _content;
  }

  Widget _buildEmail(String data) {
    Widget _content = Container(width: 0, height: 0);
    if (data.length > 1) {
      _content = Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          textDirection: TextDirection.rtl,
          children: <Widget>[
            Expanded(
              child: Text(
                ' پست الکترونیک :',
                textDirection: TextDirection.rtl,
                style: TextStyle(color: Colors.white),
              ),
            ),
            Expanded(
              child: Text(
                '${data}',
                textDirection: TextDirection.rtl,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      );
    }
    return _content;
  }

  Widget _buildWeb(String data) {
    Widget _content = Container(width: 0, height: 0);
    if (data.length > 0) {
      _content = Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          textDirection: TextDirection.rtl,
          children: <Widget>[
            Expanded(
              child: Text(
                ' آدرس سایت :',
                textDirection: TextDirection.rtl,
                style: TextStyle(color: Colors.white),
              ),
            ),
            Expanded(
              child: InkWell(
                  onTap: () => _launchURL('${data}'),
                  child: Text(
                    '${data}',
                    textDirection: TextDirection.rtl,
                    style: TextStyle(color: Colors.white),
                  )),
            ),
          ],
        ),
      );
    }
    return _content;
  }

  Widget _buildAddress(String data) {
    Widget _content = Container(width: 0, height: 0);
    if (data != '') {
      _content = Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          textDirection: TextDirection.rtl,
          children: <Widget>[
            Expanded(
              child: Text(
                ' آدرس :',
                textDirection: TextDirection.rtl,
                style: TextStyle(color: Colors.white),
              ),
            ),
            Expanded(
              child: Text(
                '${data}',
                textDirection: TextDirection.rtl,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      );
    }
    return _content;
  }

  Widget _builSocialNetwork(BuildContext context, List<Social> social) {
    List<Widget> _list = [];
    Widget content = Container(
      width: 0.0,
      height: 0.0,
    );
    if (social.length > 0) {
      social.forEach((Social s) {
        _list.add(
          InkWell(
              onTap: () => _launchURL(s.link), child: Image.network(s.icon)),
        );
        _list.add(
          SizedBox(
            width: 15,
          ),
        );
      });
      content = Padding(
        padding: const EdgeInsets.only(top: 640, left: 15, right: 15),
        child: Material(
          color: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Theme.of(context).accentColor.withOpacity(0.7)),
            height: 50,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _list,
              ),
            ),
          ),
        ),
      );
    }
    return content;
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        if (model.isLoading) {
          return Center(child: CircularProgressIndicator());
        } else {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Stack(
              children: <Widget>[
                Container(
                  child: Image.network(
                    model.aboutmodel.back,
                    fit: BoxFit.cover,
                  ),
                ),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Scaffold(
                      drawer: MyDrawer(),
                      backgroundColor: Colors.transparent,
                      appBar: AppBar(
                        actions: <Widget>[
                          IconButton(
                            icon: Icon(
                              Icons.arrow_forward,
                              color: Theme.of(context).appBarTheme.color,
                            ),
                            onPressed: () => Navigator.pop(context),
                          )
                        ],
                        elevation: 0.0,
                        backgroundColor: Colors.transparent,
                        centerTitle: true,
                        iconTheme: Theme.of(context).iconTheme,
                        title: Text(
                          'درباره ما',
                          style: Theme.of(context).textTheme.title,
                        ),
                      ),
                      body: Stack(children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 80, bottom: 60, left: 15, right: 15),
                          child: ListView(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 10, right: 10, left: 10),
                                child: RichText(
                                    //textAlign: TextAlign.justify,
                                    textDirection: TextDirection.rtl,
                                    overflow: TextOverflow.fade,
                                    text: TextSpan(
                                        text: " ${model.aboutmodel.about}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .body1
                                            .copyWith(
                                                color: Colors.white,
                                                fontSize: 15))),
                              ),

                              _buildManagement(model.aboutmodel.name),
                              _buildCell(model.aboutmodel.cell),
                              _buildTell(model.aboutmodel.tell),
                              _buildWeb(model.aboutmodel.web),
                              _buildEmail(model.aboutmodel.email),
                              _buildAddress(model.aboutmodel.address),
                                  Container(
                                      height: 300,
                                      child: WebView(
                                        initialUrl: Uri.dataFromString(
                                                '<html><body><iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3215.430086183154!2d59.579547315701774!3d36.301875980054355!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x0%3A0x0!2zMzbCsDE4JzA2LjgiTiA1OcKwMzQnNTQuMyJF!5e0!3m2!1sen!2sde!4v1562842754779!5m2!1sen!2sde" width="400" height="300" frameborder="0" style="border:0" allowfullscreen></iframe></body></html',
                                                mimeType: 'text/html')
                                            .toString(),
                                        javascriptMode:
                                            JavascriptMode.unrestricted,
                                            
                                      )),
                                ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Container(
                            height: 80,
                            alignment: Alignment.center,
                            color: Colors.transparent,
                            child: Image.asset(
                              'images/logo.png',
                            ),
                          ),
                        ),
                        _builSocialNetwork(context, model.aboutmodel.social),
                      ])),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
