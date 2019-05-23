import 'package:flutter/material.dart';

class ContactPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
      return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("تماس با ما"),
      ),body: Center(child: Text('Contact Page'),)
      );
  }
}