import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';

class ConnectionCheck extends StatefulWidget {
  @override
  _ConnectivityState createState() => _ConnectivityState();
}

class _ConnectivityState extends State<ConnectionCheck> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: RaisedButton(
          child: Text('click'),
          onPressed: _checkinternetconnectivity,
        ),
      ),
    );
  }

  _checkinternetconnectivity() async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      _showDialog('لطفا اینترنت خود را متصل کنید');
    } else if (result == ConnectivityResult.mobile) {
      _showDialog('شما به اینترنت گوشی متصل هستید');
    } else if (result == ConnectivityResult.wifi) {
      _showDialog('شما به وایفای متصل هستید');
    }
  }

  _showDialog(text) {
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: AlertDialog(
              backgroundColor: Colors.red,
              // title: Text(title),
              content: Text(text),
              actions: <Widget>[
                FlatButton(
                  child: Text('بستن'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
          );
        });
  }
}
