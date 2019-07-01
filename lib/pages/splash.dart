import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: SplashScreen(
          seconds: 6,
          navigateAfterSeconds: '/homepage',
          title: Text(
            'به نرم افزار آژانس مسافرتی پارت ونک خوش آمدید',
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
        ),
      );
  }
}
