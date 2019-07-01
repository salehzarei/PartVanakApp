import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hello_flutter/buyticket.dart';
import 'package:hello_flutter/toureDetile.dart';
import 'package:hello_flutter/toureList.dart';
import 'package:scoped_model/scoped_model.dart';
import './homepage.dart';
import './pages/contact.dart';
import './pages/aboutus.dart';
import './scoped_model.dart';
import './pages/webview.dart';

main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  MainModel model = MainModel();
  runApp(ScopedModel<MainModel>(
    model: model,
    child: MaterialApp(
        title: 'Ticket and Toure Reservsion',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          backgroundColor: Colors.amber,
          primaryColor: Color(0xFF19335C),
          accentColor: Color(0xFFD8B945),
          cardColor: Color(0xFFD8B945),
          iconTheme: IconThemeData(color: Color(0xFF19335C)),
          appBarTheme: AppBarTheme(
              color: Color(0xFF19335C),
              textTheme: TextTheme(
                  display1: TextStyle(color: Color(0xFF19335C), fontSize: 20))),
          fontFamily: 'IRANSans',
          textTheme: TextTheme(
              title: TextStyle(fontWeight: FontWeight.bold),
              display2: TextStyle(fontSize: 20, fontWeight: FontWeight.w400 , color:Color(0xFFD8B945) ),
              display4: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              display3: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFFD8B945)),
              caption: TextStyle(color: Color(0xFF19335C)),
              subhead: TextStyle(
                  color: Color(0xFFD8B945),
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
              headline: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
              subtitle: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => HomePage(model: model),
           //'/': (context) => LinkifyExample(),


          '/aboutus': (context) => AboutUs(model),
          '/internaltourelist': (context) => ToureListPage( toureType: 1,),
          '/foreigntourelist': (context) => ToureListPage(toureType: 2,),
          '/touredetile': (context) => ToureDetilePage(),
          '/buyticket': (context) => BuyTicket(),
        
          '/contact': (context) => ContactPage(model),
          '/flyinfoSite': (context) => Webview(
                title: 'اطلاعات پرواز فرودگاه های کشور',
                url: 'https://fids.airport.ir/',
              ),
          '/tollpayment': (context) => Webview(
                title:  'پرداخت عوارض خروج از کشور',
                url: 'https://sadadpsp.ir/tollpayment',
              ),
        }),
  ));
}
