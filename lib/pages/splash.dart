import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:connectivity/connectivity.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: SplashScreen(
    seconds: 3,
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
        ),
      );
  }

  _checknet() async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      Text('لطفا اینترنت خود را متصل کنید');
    // } else if (result == ConnectivityResult.mobile) {
    //   Text('شما به اینترنت گوشی متصل هستید');
    // } else if (result == ConnectivityResult.wifi) {
    //   Text('شما به وایفای متصل هستید');
    }
  }
}
