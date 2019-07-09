import 'package:flutter/material.dart';
import 'package:hello_flutter/drawer.dart';

class ResetPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        drawer: MyDrawer(),
        appBar: AppBar(
          centerTitle: true,
          title: Text('بازیابی رمز ورود'),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.arrow_forward,
                color: Colors.white,
              ),
              onPressed: () => Navigator.pop(context),
            )
          ],
        ),
        body: Stack(
          //fit: StackFit.expand,
          children: <Widget>[
            // Container(
            //     child: Image.asset(
            //   'images/air.jpg',
            //   fit: BoxFit.cover,
            // )),
            Container(
              child: Padding(
                padding: const EdgeInsets.only(
                     left: 15, right: 15),
                child: SingleChildScrollView(
                  child: Container(
                    child: Form(
                      child: Column(
                        children: <Widget>[
                          _username(),
                          SizedBox(
                            height: 10,
                          ),
                          _password(),
                          SizedBox(
                            height: 10,
                          ),
                          _repeatpassword(),
                          Padding(
                            padding: const EdgeInsets.only(right: 80),
                            child: Row(
                              children: <Widget>[
                                RaisedButton(
                                    textColor: Colors.white,
                                    child: Text('ارسال '),
                                    onPressed: () =>  Navigator.pushNamed(
                                        context, '/checkphone')),
                                SizedBox(
                                  width: 10,
                                ),
                                RaisedButton(
                                    textColor: Colors.white,
                                    child: Text('انصراف'),
                                    onPressed: () => Navigator.pushNamed(
                                        context, '/homepage')),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _username() {
  return TextFormField(
    decoration: InputDecoration(
        labelText: 'شماره همراه', filled: true, fillColor: Colors.white),
    keyboardType: TextInputType.text,
    validator: (String value) {
      if (value.isEmpty) {
        return 'این فیلد ضروریست ';
      }
    },
    onSaved: (String value) {},
  );
}

//
Widget _password() {
  return TextFormField(
    decoration: InputDecoration(
        labelText: 'رمز عبور', filled: true, fillColor: Colors.white),
    keyboardType: TextInputType.text,
    validator: (String value) {
      if (value.isEmpty) {
        return 'این فیلد ضروریست ';
      }
    },
    onSaved: (String value) {},
  );
}

Widget _repeatpassword() {
  return TextFormField(
    decoration: InputDecoration(
        labelText: 'تکرار روز عبود', filled: true, fillColor: Colors.white),
    keyboardType: TextInputType.text,
    validator: (String value) {
      if (value.isEmpty) {
        return 'این فیلد ضروریست ';
      }
    },
    onSaved: (String value) {},
  );
}
