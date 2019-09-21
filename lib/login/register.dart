import 'package:flutter/material.dart';
import 'package:hello_flutter/drawer.dart';
import 'package:scoped_model/scoped_model.dart';

import '../scoped_model.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _regKeyForm = GlobalKey<FormState>();
  int _stepindex = 0;
  int _indexState = 0;
  bool _visible = false;
  bool _nextvisible = false;
  Text _step1_subtitle =
      Text('لطفا جهت ثبت نام شماره تلفن همراه خود را وارد کنید');
  Text _step0_subtitle = Text('لطفا مشخصات خود را وارد کنید');
  Text _step2_subtitle = Text('لطفا کد چهاررقمی پیامک شده را وارد کنید');
  TextEditingController _name = TextEditingController();
  TextEditingController _family = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _mobile = TextEditingController();
  TextEditingController _pass = TextEditingController();
  TextEditingController _verificationCode = TextEditingController();

  //// دکمه تایید
  _onStepContinue(index, MainModel model) {
//// اگر در مرحله اول بود دستورات زیر رو انجام بده
    if (index == 0) {
      if (_regKeyForm.currentState.validate()) {
        setState(() {
          _stepindex = 1;
        });
      }
      setState(() {
        _indexState = 1;
        _nextvisible = false;
      });
    }

    //// اگر در مرحله دوم بود دستورات زیر رو انجام بده
    if (index == 1) {
      setState(() {
        _indexState = 1;
      });
      model.checkMobile(_mobile.text).whenComplete(() {
        if (model.errorMassage.length == 0) {
          model.getVerificationCode(_mobile.text);
          setState(() {
            _stepindex = 2;
            _nextvisible = false;
            _indexState = 2;
          });
        } else {
          setState(() {
            _indexState = 1;
            _step0_subtitle = Text(
              'خطا : ${model.errorMassage} ',
              style: TextStyle(color: Colors.red),
            );
          });
        }
      });
    }
//// اگر در مرحله سوم بود دستورات زیر رو انجام بده
    if (index == 2) {
      model
          .registerUser(
              name: _name.text,
              family: _family.text,
              email: _email.text,
              mobile: _mobile.text,
              code: _verificationCode.text,
              pass: _pass.text)
          .whenComplete(() {
        if (model.errorMassage.length == 0) {
          Navigator.pushNamed(context, '/login');
        } else {
          setState(() {
            _indexState = 1;
            _step2_subtitle = Text(
              'خطا : ${model.errorMassage} ',
              style: TextStyle(color: Colors.red),
            );
          });
        }
      });
    }
  }

  Widget _nextBTNWidget(int indexState) {
    switch (indexState) {
      case 0:
        {
          return Text('ذخیره اطلاعات');
        }
        break;

      case 1:
        {
          return Text('ارسال شماره');
        }
        break;
      case 2:
        {
          return Text('ثبت کلیه اطلاعات');
        }
        break;

      case 3:
        {
          return SizedBox(
            height: 15,
            child: CircularProgressIndicator(
              backgroundColor: Colors.white,
            ),
          );
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    MainModel model = ScopedModel.of(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        drawer: MyDrawer(),
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'ثبت نام',
            style: Theme.of(context).textTheme.display2,
          ),
          iconTheme: Theme.of(context)
              .iconTheme
              .copyWith(color: Theme.of(context).accentColor),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.arrow_forward,
                color: Theme.of(context).accentColor,
              ),
              onPressed: () => Navigator.pop(context),
            )
          ],
        ),
        body: Container(
          child: Stack(
            children: <Widget>[
              Stepper(
                currentStep: _stepindex,
                onStepContinue: () => _onStepContinue(_stepindex, model),
                controlsBuilder: (
                  BuildContext context, {
                  VoidCallback onStepContinue,
                  VoidCallback onStepCancel,
                }) {
                  return Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Visibility(
                        visible: _visible,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          onPressed: _visible ? onStepCancel : null,
                          child: const Text('برگشت'),
                        ),
                      ),
                      RaisedButton(
                        color: Theme.of(context).buttonColor,
                        onPressed: _nextvisible ? onStepContinue : null,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: _nextBTNWidget(_indexState),
                      ),
                    ],
                  );
                },
                steps: [
                  Step(
                      title: Text('ورود مشخصات'),
                      isActive: _stepindex == 0 ? true : false,
                      subtitle: _stepindex == 0
                          ? _step0_subtitle
                          : Text(
                              'حساب شما به نام ${_name.text} ${_family.text} ثبت خواهد شد'),
                      content: Form(
                        onChanged: () {
                          setState(() {
                            _nextvisible = true;
                          });
                        },
                        key: _regKeyForm,
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              controller: _name,
                              maxLength: 20,
                              style: TextStyle(
                                color: Colors.black,
                              ),
                              decoration: InputDecoration(
                                  counterText: '',
                                  hintText: 'نام',
                                  filled: true,
                                  fillColor: Colors.white),
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value.isEmpty)
                                  return 'وارد کردن نام ضروری است';
                              },
                            ),
                            TextFormField(
                              controller: _family,
                              maxLength: 20,
                              style: TextStyle(
                                color: Colors.black,
                              ),
                              decoration: InputDecoration(
                                  counterText: '',
                                  hintText: 'نام خانوادگی',
                                  filled: true,
                                  fillColor: Colors.white),
                              validator: (value) {
                                if (value.isEmpty)
                                  return 'وارد کردن نام خانوادگی ضروری است';
                              },
                              keyboardType: TextInputType.text,
                            ),
                            TextFormField(
                              controller: _email,
                              maxLength: 30,
                              style: TextStyle(
                                color: Colors.black,
                              ),
                              decoration: InputDecoration(
                                  counterText: '',
                                  hintText: 'آدرس ایمیل',
                                  filled: true,
                                  fillColor: Colors.white),
                              keyboardType: TextInputType.emailAddress,
                            ),
                            TextFormField(
                              controller: _pass,
                              maxLength: 20,
                              obscureText: true,
                              style: TextStyle(
                                color: Colors.black,
                              ),
                              decoration: InputDecoration(
                                  counterText: '',
                                  hintText: 'رمز عبور',
                                  filled: true,
                                  fillColor: Colors.white),
                              validator: (value) {
                                if (value.isEmpty)
                                  return 'واردکردن پسورد ضروری است';
                                if (value.length < 5)
                                  return 'وارد کردن حداقل 4 کارکتر اجباری است';
                              },
                              keyboardType: TextInputType.text,
                            ),
                            TextFormField(
                              maxLength: 20,
                              obscureText: true,
                              style: TextStyle(
                                color: Colors.black,
                              ),
                              decoration: InputDecoration(
                                  counterText: '',
                                  hintText: 'تکرار رمز عبور',
                                  filled: true,
                                  fillColor: Colors.white),
                              validator: (value) {
                                if (value != _pass.text)
                                  return 'رمز وارد شده با بالا مغایرت دارد';
                              },
                              keyboardType: TextInputType.text,
                            ),
                          ],
                        ),
                      ),
                      state: _stepindex <= 0
                          ? StepState.indexed
                          : StepState.complete),
                  Step(
                      title: Text('ورود شماره همراه'),
                      isActive: _stepindex == 1 ? true : false,
                      subtitle: _stepindex == 1
                          ? _step0_subtitle
                          : Text(
                              'شما با شماره همراه ${_mobile.text} ثبت نام کردید'),
                      content: TextField(
                        controller: _mobile,
                        onChanged: (value) {
                          if (value.length == 11)
                            setState(() {
                              _nextvisible = true;
                            });
                          else
                            setState(() {
                              _nextvisible = false;
                            });
                        },
                        maxLength: 11,
                        decoration: InputDecoration(
                            counterText: '',
                            hintText: '09xxxxxxxxx',
                            labelText: 'شماره همراه',
                            filled: true,
                            fillColor: Colors.white),
                        keyboardType: TextInputType.phone,
                      ),
                      state: _stepindex <= 1
                          ? StepState.indexed
                          : StepState.complete),
                  Step(
                      title: Text('کد هراز هویت'),
                      isActive: _stepindex == 2 ? true : false,
                      subtitle: _step2_subtitle,
                      content: TextField(
                        controller: _verificationCode,
                        onChanged: (value) {
                          if (value.length == 4)
                            setState(() {
                              _nextvisible = true;
                            });
                          else
                            setState(() {
                              _nextvisible = false;
                            });
                        },
                        maxLength: 4,
                        style: TextStyle(color: Colors.black, fontSize: 25),
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                            counterText: '',
                            hintText: '- - - -',
                            filled: true,
                            fillColor: Colors.white),
                        keyboardType: TextInputType.number,
                      ),
                      state: _stepindex <= 2
                          ? StepState.indexed
                          : StepState.complete),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
