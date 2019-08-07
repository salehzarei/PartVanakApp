import 'package:flutter/material.dart';

class CheckUpdate extends StatefulWidget {
  @override
  _CheckUpdateState createState() => _CheckUpdateState();
}

class _CheckUpdateState extends State<CheckUpdate> {
  int lastversion = 1;
  int newversion = 2;

  @override
  void initState() {
    super.initState();
    // updatecheck(lastversion);
  }

  updatecheck(int lastversion) {
    if (lastversion < newversion) {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return Directionality(
              textDirection: TextDirection.rtl,
              child: AlertDialog(
                title: Text('بروزرسانی'),
                content: Text('نرم افزار خود را بروز کنید'),
                actions: <Widget>[
                  FlatButton(
                    onPressed: () {
                      //Navigator.pushNamed(context, /homePage);
                      print('بستن');
                    },
                    child: Text('بستن'),
                  ),
                  FlatButton(
                    onPressed: () {
                      print('بروزرسانی');
                    },
                    child: Text('بروزرسانی'),
                  )
                ],
                
              ),
            );
          });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('data'),
      ),
      body: Center(
              child: RaisedButton(
          onPressed: () {
            updatecheck(lastversion);
          },
          child: Text('بروزرسانی'),
        ),
      ),
    );
  }
}
