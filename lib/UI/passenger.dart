import 'package:flutter/material.dart';

class Passenger extends StatefulWidget {
  final List personcount;

  const Passenger({Key key, this.personcount}) : super(key: key);

  @override
  _PassengerState createState() => _PassengerState();
}

class _PassengerState extends State<Passenger> {
  
  @override
  Widget build(BuildContext context) {
    print(widget.personcount);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.personcount.toString()),
      ),
     
    );
  }
}
