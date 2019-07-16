import 'package:flutter/material.dart';

class Grouping extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Material(
              child: Container(
          color: Colors.white,
          width: 200,
          
          child: ListView(
          
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 25),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Container(
                  child: Text('ssss'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
