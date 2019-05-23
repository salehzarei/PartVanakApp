import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hello_flutter/toureDetile.dart';
import 'package:hello_flutter/toureList.dart';
import './homepage.dart';
import './pages/contact.dart';

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
            display1: TextStyle(color: Color(0xFF19335C) ,fontSize: 20)
          )
        ),
        
        fontFamily: 'IRANSans',
        textTheme: TextTheme(
          title: TextStyle(fontWeight: FontWeight.bold),
          caption: TextStyle(color:Color(0xFF19335C)),
          subhead: TextStyle(color: Color(0xFFD8B945), fontSize: 15 , fontWeight: FontWeight.bold),
          headline: TextStyle( fontSize: 13 , fontWeight: FontWeight.bold),
          subtitle: TextStyle(color:Colors.grey.shade600 , fontSize: 10),

         )
       ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/tourelist' :(BuildContext context)=>ToureListPage(),
        '/touredetile' :(BuildContext context)=>ToureDetilePage(),
        '/contact' :(BuildContext context)=>ContactPage()
      }));
}
