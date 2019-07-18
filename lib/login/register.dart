import 'package:flutter/material.dart';
import 'package:hello_flutter/drawer.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _regKeyForm = GlobalKey<FormState>();
  TextEditingController _name = TextEditingController();
  TextEditingController _family = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _mobile = TextEditingController();
  TextEditingController _pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        drawer: MyDrawer(),
        appBar: AppBar(
          centerTitle: true,
          title: Text('ثبت نام'),
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
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: SingleChildScrollView(
                  child: Container(
                    child: Form(
                      key: _regKeyForm,
                      child: Column(
                        children: <Widget>[
                          _fname(_name),
                          SizedBox(
                            height: 10,
                          ),
                          _familyname(_family),
                          SizedBox(
                            height: 10,
                          ),
                          _femail(_email),
                          SizedBox(
                            height: 10,
                          ),
                          _phone(_mobile),
                          SizedBox(
                            height: 10,
                          ),
                          _password(_pass),
                          SizedBox(
                            height: 10,
                          ),
                          _repeatpassword(_pass),
                          Padding(
                            padding: const EdgeInsets.only(right: 80),
                            child: Row(
                              children: <Widget>[
                                RaisedButton(
                                    textColor: Colors.white,
                                    child: Text('ارسال '),
                                    onPressed: () {
                                      if (_regKeyForm.currentState.validate()) {
                                        print(
                                            "User : ${_name.text}  ${_family.text}  ${_email.text}  ${_mobile.text}  ${_pass.text}");
                                      }
                                    }),
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

Widget _fname(name) {
  return TextFormField(
    controller: name,
    decoration: InputDecoration(
        labelText: 'نام ', filled: true, fillColor: Colors.white),
    keyboardType: TextInputType.text,
    validator: (String value) {
      if (value.isEmpty) {
        return 'این فیلد ضروریست ';
      }
    },
    onSaved: (String value) {},
  );
}

Widget _familyname(family) {
  return TextFormField(
    controller: family,
    decoration: InputDecoration(
        labelText: 'نام خانوادگی', filled: true, fillColor: Colors.white),
    keyboardType: TextInputType.text,
    validator: (String value) {
      if (value.isEmpty) {
        return 'این فیلد ضروریست ';
      }
    },
    onSaved: (String value) {},
  );
}

Widget _femail(email) {
  return TextFormField(
    controller: email,
    decoration: InputDecoration(
        labelText: 'ایمیل', filled: true, fillColor: Colors.white),
    keyboardType: TextInputType.emailAddress,
    validator: (String value) {
      if (value.isEmpty) {
        return 'این فیلد ضروریست ';
      }
    },
    onSaved: (String value) {},
  );
}

Widget _phone(phone) {
  return TextFormField(
    controller: phone,
    maxLength: 11,
    decoration: InputDecoration(
      counterText: '',
        labelText: 'شماره همراه', filled: true, fillColor: Colors.white),
    keyboardType: TextInputType.phone,
    validator: (String value) {
      if (value.length != 11) {
        return 'شماره تلفن باید 11 رقم باشد';
      }
    },
    onSaved: (String value) {},
  );
}

Widget _password(pass) {
  return TextFormField(
    controller: pass,
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

Widget _repeatpassword(TextEditingController pass) {
  return TextFormField(
    decoration: InputDecoration(
        labelText: 'تکرار رمز عبور', filled: true, fillColor: Colors.white),
    keyboardType: TextInputType.text,
    validator: (String value) {
      if (value.isEmpty || value != pass.text) {
        return 'رمز وارد شده مغایرت دارد با رمز بالا ';
      }
    },
    onSaved: (String value) {},
  );
}
