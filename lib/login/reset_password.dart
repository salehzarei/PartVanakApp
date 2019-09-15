import 'package:flutter/material.dart';
import 'package:hello_flutter/drawer.dart';
import 'package:scoped_model/scoped_model.dart';

import '../scoped_model.dart';
import 'check_phone.dart';

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  MainModel model;
  TextEditingController _phoneNumber = TextEditingController();
  final _mobilekey = GlobalKey<FormState>();

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
        body: ScopedModelDescendant<MainModel>(
          builder: (context, child, model) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Form(
                  key: _mobilekey,
                  child: TextFormField(
                    controller: _phoneNumber,
                    decoration: InputDecoration(
                        labelText: 'شماره همراه',
                        counterText: '',
                        filled: true,
                        fillColor: Colors.white),
                    maxLength: 11,
                    style: TextStyle(fontSize: 20),
                    keyboardType: TextInputType.phone,
                    validator: (val) {
                      if (val.isEmpty || val.length < 11) {
                        return 'وارد کردن شماره موبایل 11 رقمی ضروری است';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RaisedButton(
                          textColor: Colors.white,
                          child: Text('ارسال'),
                          onPressed: () {
                            if (_mobilekey.currentState.validate()) {
                              model
                                  .getVerificationCode(_phoneNumber.text,
                                      resetPass: '1')
                                  .whenComplete(() => {
                                        if (model.error == true)
                                          {
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return Directionality(
                                                    textDirection:
                                                        TextDirection.rtl,
                                                    child: AlertDialog(
                                                      title: Text('شرمنده'),
                                                      content: Text(
                                                          '${model.errorMassage}'),
                                                      actions: <Widget>[
                                                        FlatButton(
                                                          onPressed: () =>
                                                              Navigator.of(
                                                                      context)
                                                                  .pop(),
                                                          child: Text('بستن'),
                                                        ),
                                                      ],
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      20.0))),
                                                    ),
                                                  );
                                                })
                                          }
                                        else
                                          {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        CheckPhone(
                                                          phonenumber:
                                                              _phoneNumber.text,
                                                        )))
                                          }
                                      });
                            }
                          }),
                      SizedBox(
                        width: 10,
                      ),
                      RaisedButton(
                          textColor: Colors.white,
                          child: Text('انصراف'),
                          onPressed: () =>
                              Navigator.pushNamed(context, '/homepage')),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
