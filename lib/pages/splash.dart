import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:hello_flutter/model/tourefilter_model.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';
import '../scoped_model.dart';

/// بررسی توکن کاربر و صفحه اسپلش

class Splash extends StatefulWidget {
  MainModel model;
  Splash({this.model});

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  int splashtime = 3;
  bool isconnect = true;

  ToureFilterModel fetchSpecialToure = ToureFilterModel(special: '1');
  @override
  void initState() {
    super.initState();
    checkinternet();

    widget.model.getToken().whenComplete(() {
      if (widget.model.userToken != null) widget.model.loadingUserData();
      widget.model.getTourData(filter: fetchSpecialToure);

      setState(() {
        splashtime = 0;
        _firebaseMessaging.getToken();

        print('firebaseMessaging token');
        print(_firebaseMessaging);
      });
    });
  }

  String linkurl = 'http://partvanak.com/';
  launchURL(String linkurl) async {
    if (await canLaunch(linkurl)) {
      await launch(linkurl);
    } else {
      throw 'Could not launch $linkurl';
    }
  }

  checkinternet() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
      }
    } on SocketException catch (_) {
      print('not connected');
      setState(() {
        isconnect = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isconnect
        ? SplashScreen(
            seconds: splashtime,
            navigateAfterSeconds: '/homepage',
            title: Text(
              'آژانس مسافرتی پارت ونک',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  color: Colors.white),
            ),
            image: Image.asset('images/logo.png'),
            backgroundColor: Theme.of(context).appBarTheme.color,
            styleTextUnderTheLoader: TextStyle(),
            photoSize: 100.0,
            loaderColor: Colors.red,
            loadingText: Text(
              'صبر کنید',
              style: TextStyle(color: Colors.white),
            ),
          )
        : Scaffold(
            body: Center(
              child: Container(
                color: Colors.white70,
                child: Padding(
                  padding: EdgeInsets.only(top: 160, left: 40, right: 15),
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        Container(
                            child: Image.asset(
                          'images/notnet.jpg',
                          height: 300,
                        )),
                        SizedBox(
                          height: 60,
                        ),
                        Container(
                          child: Text(
                            'دسترسی به اینترنت امکان پذیر نیست',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                          child: Text(
                            'اینترنت خود را متصل کنید و مجدادا تلاش کنید',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                            child: Column(
                          children: <Widget>[
                            Image.asset('images/logo.png'),
                            GestureDetector(
                              child: Text('www.partvanak.com'),
                              onTap: () => launchURL(linkurl),
                            )
                          ],
                        ))
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
