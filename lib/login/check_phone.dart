import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CheckPhone extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('تایید شماره همراه'),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 30, left: 25),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Container(
                  child: Text(
                    'کد ارسال شده را وارد کنید',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.only(top: 25, left: 15, right: 30),
                child: Column(
                  children: <Widget>[
                    _phonecode(),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        print('ارسال مجدد کد تایید');
                      },
                      child: Text('ارسال مجدد کد تایید'),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    RaisedButton(
                        textColor: Colors.white,
                        child: Text('تایید'),
                        onPressed: () => print('ارسال شد')),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _phonecode() {
    return TextFormField(
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
      ),
      keyboardType: TextInputType.number,
      maxLength: 4,
      validator: (String value) {
        if (value.isEmpty) {
          return 'این فیلد ضروریست ';
        }
      },
      onSaved: (String value) {},
    );   
  }
}
