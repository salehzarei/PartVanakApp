import 'package:flutter/material.dart';
import 'package:hello_flutter/model/tourefilter_model.dart';
import 'package:splashscreen/splashscreen.dart';
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
  int splashtime = 3;
  bool isconnect = true ;

  ToureFilterModel fetchSpecialToure = ToureFilterModel(special: '1');
  @override
  void initState() {
    super.initState();
    chekinternet();
    widget.model.getToken().whenComplete(() {
      if (widget.model.userToken != null) widget.model.loadingUserData();
      widget.model.getTourData(filter: fetchSpecialToure);

      setState(() {
        splashtime = 0;
      });
    });
  }

  chekinternet() async {
    try {
      final result = await InternetAddress.lookup('firparvaz.ir');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
      }
    } on SocketException catch (_) {
      print('not connected');
      setState(() {
       isconnect = false ; 
      });
      widget.model.ackAlert(context , massage: 'دسترسی به سایت مقدور نیست . اینترنت گوشی را چک کنید' ,);
    }
  }

  @override
  Widget build(BuildContext context) {
    return isconnect ? SplashScreen(
      seconds: splashtime,
      navigateAfterSeconds: '/homepage',
      title: Text(
        'آژانس مسافرتی پارت ونک',
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 18.0, color: Colors.white),
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
    ) : Container(
        color: Colors.grey.shade200,
      );
  }
}
