import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:scoped_model/scoped_model.dart';
import '../drawer.dart';
import '../scoped_model.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _loginkeyform = GlobalKey<FormState>();
  TextEditingController _mobile = TextEditingController();
  TextEditingController _pass = TextEditingController();

    @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(builder: (context, child, model) {
      return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          drawer: MyDrawer(),
          appBar: AppBar(
            centerTitle: true,
            title: Text('ورود به اپلیکیشن'),
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
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
                child: ListView(
                  children: <Widget>[
                    Container(
                      child: Form(
                        key: _loginkeyform,
                        child: Column(
                          children: <Widget>[
                            _username(_mobile),
                            SizedBox(
                              height: 5,
                            ),
                            _password(_pass),
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 80, top: 10),
                              child: Row(
                                children: <Widget>[
                                  RaisedButton(
                                      textColor: Colors.white,
                                      child: Text('ورود'),
                                      onPressed: () {
                                        if (_loginkeyform.currentState
                                            .validate()) {
                                          model
                                              .loginData(
                                                  mobile: _mobile.text,
                                                  pass: _pass.text)
                                              .whenComplete(() {
                                            if (model.errorMassage == "") {
                                              model.getToken().whenComplete(() {
                                                if (model.userToken != null) {
                                                  Navigator.pushNamed(
                                                      context, '/');
                                                }
                                              });
                                            } else
                                              model.ackAlert(
                                                  context, massage: model.errorMassage );
                                          });
                                        }
                                      }),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  RaisedButton(
                                      textColor: Colors.white,
                                      child: Text('ثبت نام'),
                                      onPressed: () => Navigator.pushNamed(
                                          context, '/register')),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            GestureDetector(
                                child: Text(
                                  'رمز عبور خود را فراموش کردید؟',
                                  style: TextStyle(color: Colors.black),
                                ),
                                onTap: () => Navigator.pushNamed(
                                    context, '/resetpassword')),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

Widget _username(mobile) {
  return TextFormField(
    
    controller: mobile,
    maxLength: 11,
    style: TextStyle(color: Colors.black, fontSize: 20),
    decoration: InputDecoration(
        hintText: 'مثلا : 09154127181',
        counterText: '',
        hintStyle: TextStyle(color: Colors.grey.shade300),
        labelText: 'شماره همراه',
        filled: true,
        fillColor: Colors.white),
    keyboardType: TextInputType.phone,
    validator: (String value) {
      if (value.isEmpty) {
        return 'این فیلد ضروریست ';
      }
    },
    onSaved: (String value) {},
  );
}


Widget _password(pass) {
  return TextFormField(
    controller: pass,
    obscureText: true,
    style: TextStyle(color: Colors.black, fontSize: 20),
    decoration: InputDecoration(
        labelText: 'رمز عبور', filled: true, fillColor: Colors.white),
    keyboardType: TextInputType.number,
    validator: (String value) {
      if (value.isEmpty) {
        return 'این فیلد ضروریست ';
      }
    },
    onSaved: (String value) {},
  );
}
