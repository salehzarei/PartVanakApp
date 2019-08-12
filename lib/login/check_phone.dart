import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hello_flutter/scoped_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CheckPhone extends StatefulWidget {
  String phonenumber;
  CheckPhone({this.phonenumber});

  @override
  _CheckPhoneState createState() => _CheckPhoneState();
}

class _CheckPhoneState extends State<CheckPhone> {
  TextEditingController _code = TextEditingController();
  TextEditingController _pass = TextEditingController();
  TextEditingController _passagain = TextEditingController();
  final _key = GlobalKey<FormState>();

  Future<void> reset(
      String code, String pass, String phone, MainModel model) async {
    final result = await model.resetPassword(code, pass, phone);
    if (result != '') {
      model.ackAlert(context, massage: result);
    } else {
      Navigator.pushNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (context, child, model) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text('تایید شماره همراه'),
            ),
            body: SingleChildScrollView(
              child: Padding(
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
                      padding:
                          const EdgeInsets.only(top: 25, left: 15, right: 30),
                      child: Container(
                        height: 400,
                        child: Form(
                          key: _key,
                          child: ListView(
                            children: <Widget>[
                              TextFormField(
                                controller: _code,
                                decoration: InputDecoration(
                                  labelText: 'کد چهاررقمی پیامک شده',
                                  counterText: '',
                                ),
                                maxLength: 4,
                                style: TextStyle(fontSize: 15),
                                keyboardType: TextInputType.phone,
                                validator: (value){
                                  if(value.isEmpty){
                                    return 'ورود کد چهاررقمی ضروری است';
                                  }return null;
                                },
                              ),
                              TextFormField(
                                controller: _pass,
                                obscureText: true,
                                decoration: InputDecoration(
                                  labelText: 'رمز عبور جدید را وارد کنید',
                                  counterText: '',
                                ),
                                maxLength: 11,
                                style: TextStyle(fontSize: 15),
                                keyboardType: TextInputType.phone,
                                validator: (value){
                                  if(value.isEmpty || value.length < 5 ){
                                    return 'ورود رمز عبور حداقل 5 کارکتر ضروری است';
                                  } return null;
                                },
                              ),
                              TextFormField(
                                controller: _passagain,
                                obscureText: true,
                                decoration: InputDecoration(
                                  labelText: 'تکرار مجدد رمز عبور',
                                  counterText: '',
                                ),
                                maxLength: 11,
                                style: TextStyle(fontSize: 15),
                                keyboardType: TextInputType.phone,
                                validator: (value){
                                  if(value != _pass.text ){
                                    return 'رمز وارد شده با بالا مغایرت دارد';
                                  }return null;
                                },
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              RaisedButton(
                                  textColor: Colors.white,
                                  child: Text('تغییر رمز عبور'),
                                  onPressed: () {
                                    if(_key.currentState.validate()) reset(_code.text, _pass.text,
                                        widget.phonenumber, model);
                                  }),
                              SizedBox(
                                height: 10,
                              ),
                              Center(
                                child: GestureDetector(
                                  onTap: () => model
                                      .getVerificationCode(widget.phonenumber),
                                  child: Text('ارسال مجدد کد تایید'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
