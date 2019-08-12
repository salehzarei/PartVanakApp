import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './pages/blog_list.dart';
import 'package:scoped_model/scoped_model.dart';

import './buyticket.dart';
import './toureDetile.dart';
import './toureList.dart';
import './homepage.dart';
import './pages/contact.dart';
import './pages/aboutus.dart';
import './scoped_model.dart';
import './pages/webview.dart';
import './pages/splash.dart';
import './login/login.dart';
import './login/reset_password.dart';
import './login/register.dart';
import './login/check_phone.dart';
import 'login/new_password.dart';
import 'login/profile.dart';


main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  MainModel model = MainModel();
  runApp(ScopedModel<MainModel>(
    model: model,
    child: MaterialApp(
        title: 'آژانس مسافرتی پارت ونک',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          backgroundColor: Colors.amber,
          primaryColor: Colors.grey.shade700,
          accentColor: Color(0xFFD8B945),
          cardColor: Color(0xFFD8B945),
          buttonColor: Color(0xFFD8B945),
         // iconTheme: IconThemeData(color: Color(0xFF19335C)),
         iconTheme: IconThemeData(color: Colors.grey),
          appBarTheme: AppBarTheme(
              //color: Color(0xFF19335C),
              color: Colors.grey.shade800,
              textTheme: TextTheme(
                  display1: TextStyle(color: Color(0xFF19335C), fontSize: 20))),
          fontFamily: 'IRANSans',
          textTheme: TextTheme(
              title: TextStyle(fontWeight: FontWeight.bold),
              display2: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFFD8B945)),
              display4: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              display3: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFFD8B945)),
              caption: TextStyle(color: Color(0xFF19335C)),
              subhead: TextStyle(
                  color: Colors.grey.shade700,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
              headline: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
              subtitle: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
        ),
        initialRoute: '/',
        routes: {
          // '/': (context) => DialogsExample(),
          '/': (context) => Splash(model: model),
          // '/': (context) => CheckUpdate(),
          '/profile': (context) => Profile(),
          '/bloglist': (context) => BlogList(),
          '/newpassword': (context) => NewPassword(),
         // '/firebase': (context) => Messagingwidget(),
          '/checkphone': (context) => CheckPhone(),
          '/login': (context) => Login(),
          '/register': (context) => Register(),
          '/resetpassword': (context) => ResetPassword(),
          '/homepage': (context) => HomePage(),
          '/aboutus': (context) => AboutUs(model),
          '/internaltourelist': (context) => ToureListPage(
                toureType: 1,
              ),
          '/foreigntourelist': (context) => ToureListPage(
                toureType: 2,
              ),
          '/onedaytourelist': (context) => ToureListPage(
                toureType: 3,
              ),
          '/lassecondtourelist': (context) => ToureListPage(
                toureType: 4,
              ),
          '/specialtourelist': (context) => ToureListPage(
                toureType: 5,
              ),
          '/touredetile': (context) => ToureDetilePage(),
          '/buyticket': (context) => BuyTicket(),

          '/contactUs': (context) => ContactPage(model),
          '/flyinfoSite': (context) => Webview(
                title: 'اطلاعات پرواز فرودگاه های کشور',
                url: 'https://fids.airport.ir/',
              ),
          '/tollpayment': (context) => Webview(
                title: 'پرداخت عوارض خروج از کشور',
                url: 'https://sadadpsp.ir/tollpayment',
              ),
        }),
  ));
  
}
