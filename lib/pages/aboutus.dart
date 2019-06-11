import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'درباره ما',
      home: Container(
        child: Image.asset('about-1.jpg'),
      ),
    );
  }
}
