import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hello_flutter/toureDetile.dart';
import 'package:hello_flutter/toureList.dart';
import './homepage.dart';

main() {
  runApp(MaterialApp(
      title: 'First Application in Pishgaman',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        backgroundColor: Colors.amber,
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
            display4: TextStyle(fontSize: 14 , fontWeight: FontWeight.w400),
            display3: TextStyle(fontSize: 11 , fontWeight: FontWeight.w400 , color:Color(0xFFD8B945) ),
            caption: TextStyle(color: Color(0xFF19335C)),
            subhead: TextStyle(
                color: Color(0xFFD8B945),
                fontSize: 15,
                fontWeight: FontWeight.bold),
            headline: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            subtitle: TextStyle(color: Colors.grey.shade600, fontSize: 10)),
      ),
      initialRoute: '/',
      routes: {
        //  '/': (context) => HomePage(),
        '/': (context) => ToureDetilePage(),
        '/tourelist': (context) => ToureListPage(),
        '/touredetile': (context) => ToureDetilePage()
      }));
}
