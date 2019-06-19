import 'package:flutter/material.dart';

import '../buyticket.dart';

class HotelPage extends StatelessWidget {
  const HotelPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

   void _showModalSheet() {
      showModalBottomSheet(
          context: context,
          builder: (builder) {
            return Material(child: BuyTicket());
          });
    }

    return Scaffold(
          body: Container(
        child: Center(
         child: 
          Container(
            margin: EdgeInsets.symmetric(vertical: 15),
            child: MaterialButton(
              onPressed: _showModalSheet,
              minWidth: 300,
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Text(
                'رزرو تور',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              elevation: 2,
              color: Theme.of(context).accentColor,
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            ),
          ),
        ),
      ),
    );
  }
}