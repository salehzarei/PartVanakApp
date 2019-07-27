import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:hello_flutter/drawer.dart';

import 'dart:async';
import 'package:flutter/services.dart';
import 'package:uni_links/uni_links.dart';

import 'package:scoped_model/scoped_model.dart';
import './scoped_model.dart';
import './model/passenger_model.dart';
import 'package:url_launcher/url_launcher.dart';

class ChekOut extends StatefulWidget {
  final List<PassengerModel> passengerlist;

  const ChekOut({Key key, this.passengerlist}) : super(key: key);

  @override
  _ChekOutState createState() => _ChekOutState();
}

enum UniLinksType { string, uri }

class _ChekOutState extends State<ChekOut> {
  int _single_price = 0;
  int _adult_price = 0;
  int _child_price = 0;
  int _child_price_bed = 0;
  int _baby_price = 0;
  String _currency = '';
  int _singleCount = 0;
  int _adultCount = 0;
  int _childCount = 0;
  int _childbedCount = 0;
  int _babyCount = 0;
  int _totalPrice = 0;
  int _currrentStep = 0;
  bool _visible = false;
  bool _finalStep = false;
  GlobalKey<FormState> _key;
  TextEditingController _phone = TextEditingController();
  TextEditingController _mobile = TextEditingController();
  TextEditingController _email = TextEditingController();

  @override
  void initState() {
    super.initState();

    initPlatformState();

    /// خواندن مدل هتل انتخاب شده برای مقداردهی اولیه قیمت ها
    MainModel _model = ScopedModel.of(context);
    _model.tourelist.forEach((toure) {
      toure.accommodation.forEach((acc) {
        if (acc.accommodation_id.toString() == _model.tmpCartData['HotelID']) {
          _single_price = acc.singel_price;
          _adult_price = acc.adult_price;
          _child_price = acc.child_price;
          _child_price_bed = acc.child_price_bed;
          _baby_price = acc.baby_price;
        }
      });
      if (toure.id.toString() == _model.tmpCartData['ToureID']) {
        _currency = toure.currency;
      }
    });

    /// خواندن تعداد افراد و رده سنی آنها
    widget.passengerlist.forEach((passen) {
      switch (passen.type) {
        case "a":
          {
            _singleCount++;
          }
          break;

        case "b":
          {
            _adultCount++;
          }
          break;

        case "c":
          {
            _childbedCount++;
          }
          break;

        case "d":
          {
            _babyCount++;
          }
          break;
      }
    });

    _totalPrice = _single_price * _singleCount +
        _adult_price * _adultCount +
        _child_price_bed * _childbedCount +
        _child_price * _childCount +
        _baby_price * _babyCount;
  }

  /// پکیج تبدیل قیمت به نقاط هزارگان
  changemony(int price) {
    return MoneyMaskedTextController(
            precision: 0,
            thousandSeparator: '.',
            decimalSeparator: '',
            initialValue: double.parse(price.toString()))
        .text;
  }

  sendToServer() {
    MainModel _model = ScopedModel.of(context);
    _model
        .sendDataToServer(
            cell: _mobile.text, email: _email.text, tell: _phone.text)
        .then((_) => _launchURL(_model.serverCartResponse));
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      _ackAlert(context, 'ارسال اطلاعات به سرور');
      await launch(url);
    } else {
      _ackAlert(context, 'خطا در اتصال به سرور');
      throw 'Could not launch ' + url;
    }
  }

///// Deep Link Test

  String _latestLink = 'Unknown';
  Uri _latestUri;
  UniLinksType _type = UniLinksType.string;
  StreamSubscription _sub;

  // Platform messages are asynchronous, so we initialize in an async method.
  initPlatformState() async {
    print("Run initPlatformState");
    if (_type == UniLinksType.string) {
      await initPlatformStateForStringUniLinks();
    } else {
      await initPlatformStateForUriUniLinks();
    }
  }

  /// An implementation using a [String] link
  initPlatformStateForStringUniLinks() async {
    print("initPlatformStateFor...");
    // Attach a listener to the links stream
    _sub = getLinksStream().listen((String link) {
      if (!mounted) return;
      setState(() {
        _latestLink = link ?? 'Unknown';
        _latestUri = null;
        try {
          if (link != null) _latestUri = Uri.parse(link);
        } on FormatException {}
      });
    }, onError: (err) {
      if (!mounted) return;
      setState(() {
        _latestLink = 'Failed to get latest link: $err.';
        _latestUri = null;
      });
    });
    // Attach a second listener to the stream
    getLinksStream().listen((String link) {
      print('got link: $link');
    }, onError: (err) {
      print('got err: $err');
    });

    // Get the latest link
    String initialLink;
    Uri initialUri;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      initialLink = await getInitialLink();
      print('initial link: $initialLink');
      if (initialLink != null) initialUri = Uri.parse(initialLink);
    } on PlatformException {
      initialLink = 'Failed to get initial link.';
      initialUri = null;
    } on FormatException {
      initialLink = 'Failed to parse the initial link as Uri.';
      initialUri = null;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _latestLink = initialLink;
      _latestUri = initialUri;
    });
  }

  /// An implementation using the [Uri] convenience helpers
  initPlatformStateForUriUniLinks() async {
    print("Run  initPlatformStateForUriUniLinks");
    // Attach a listener to the Uri links stream
    _sub = getUriLinksStream().listen((Uri uri) {
      if (!mounted) return;
      setState(() {
        _latestUri = uri;
        _latestLink = uri?.toString() ?? 'Unknown';
      });
    }, onError: (err) {
      if (!mounted) return;
      setState(() {
        _latestUri = null;
        _latestLink = 'Failed to get latest link: $err.';
      });
    });

    // Attach a second listener to the stream
    getUriLinksStream().listen((Uri uri) {
      print('got uri: ${uri?.path} ${uri?.queryParametersAll}');
    }, onError: (err) {
      print('got err: $err');
    });

    // Get the latest Uri
    Uri initialUri;
    String initialLink;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      initialUri = await getInitialUri();
      print('initial uri: ${initialUri?.path}'
          ' ${initialUri?.queryParametersAll}');
      initialLink = initialUri?.toString();
    } on PlatformException {
      initialUri = null;
      initialLink = 'Failed to get initial uri.';
    } on FormatException {
      initialUri = null;
      initialLink = 'Bad parse the initial link as Uri.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _latestUri = initialUri;
      _latestLink = initialLink;
    });
  }

////

///// دکمه برگشت
  _onStepCancel(index) {
    setState(() {
      if (index > 0) _currrentStep--;
      if (index - 1 == 0) _visible = false;
    });
  }

  //// دکمه تایید
  _onStepContinue(index) {
    setState(() {
      if (index < 2) {
        _currrentStep++;
        _visible = true;
      }
      if (index + 1 == 2) _finalStep = true;
    });
  }

  /// تپ کردن روی هر مورد
  _onStepTapped(index) {
    setState(() {
      _currrentStep = index;
      if (index < 2 && index > 0) {
        _visible = true;
        _finalStep = false;
      } else if (index == 0)
        _visible = false;
      else if (index == 2) _finalStep = true;
    });
  }

  Future<void> _ackAlert(BuildContext context, String massage) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            title: Text(massage),
            actions: <Widget>[
              FlatButton(
                child: Text('بستن'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
//// استخراج اطلاعات
    print(_latestLink);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          drawer: MyDrawer(),
          appBar: AppBar(
            centerTitle: true,
            iconTheme: Theme.of(context)
                .iconTheme
                .copyWith(color: Theme.of(context).accentColor),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.arrow_forward),
                onPressed: () => Navigator.pop(context),
              )
            ],
            title: Text('صورتحساب',
                style: TextStyle(
                    color: Theme.of(context).accentColor, fontSize: 20)),
          ),
          body: Container(
              padding: EdgeInsets.all(5.0),
              child: Stepper(
                type: StepperType.vertical,
                currentStep: _currrentStep,
                controlsBuilder: (
                  BuildContext context, {
                  VoidCallback onStepContinue,
                  VoidCallback onStepCancel,
                }) {
                  return _finalStep
                      ? RaisedButton(
                          color: Colors.greenAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          onPressed: () {
                            // if (_key.currentState.validate()) {
                            //   _key.currentState.save();
                            sendToServer();
                            // }
                          },
                          child: const Text('پرداخت صورتحساب'),
                        )
                      : Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Visibility(
                              visible: _visible,
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                onPressed: onStepCancel,
                                child: const Text('برگشت'),
                              ),
                            ),
                            RaisedButton(
                              color: Theme.of(context).buttonColor,
                              onPressed: onStepContinue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: const Text('تایید'),
                            ),
                          ],
                        );
                },
                onStepCancel: () => _onStepCancel(_currrentStep),
                onStepContinue: () => _onStepContinue(_currrentStep),
                onStepTapped: (index) => _onStepTapped(index),
                steps: [
                  otherPassenger(context, widget.passengerlist),
                  factor(
                      context,
                      _singleCount,
                      changemony,
                      _single_price,
                      _currency,
                      _adultCount,
                      _childbedCount,
                      _child_price_bed,
                      _babyCount,
                      _baby_price,
                      _adult_price,
                      _totalPrice),
                  pay(context, _email, _mobile, _phone, _key),
                ],
              ))),
    );
  }
}

Step masterPerson(BuildContext context, passengerlist) {
  return Step(
    title: Text('مشخصات فرد اصلی'),
    isActive: true,
    content: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        padding: EdgeInsets.all(5.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: Text(
                'مشخصات خریدار اصلی',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).accentColor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                textDirection: TextDirection.rtl,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      'نام ونام خانوادگی',
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.right,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: Text(passengerlist[0].name,
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.right))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                textDirection: TextDirection.rtl,
                children: <Widget>[
                  Expanded(
                      child: Text('کدملی/پاسپورت ',
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.right)),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: Text(passengerlist[0].melicode,
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.right))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                textDirection: TextDirection.rtl,
                children: <Widget>[
                  Expanded(
                      child: Text('جنسیت',
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.right)),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: Text(passengerlist[0].sex,
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.right))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                textDirection: TextDirection.rtl,
                children: <Widget>[
                  Expanded(
                      child: Text('تاریخ تولد',
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.right)),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: Text(passengerlist[0].brith,
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.right))
                ],
              ),
            ),
          ],
        )),
  );
}

Step otherPassenger(BuildContext context, List<PassengerModel> passengerList) {
  return Step(
      title: Text('مشخصات سایر مسافرین'),
      isActive: true,
      content: Directionality(
        textDirection: TextDirection.rtl,
        child: SizedBox(
          height: passengerList.length < 3
              ? double.parse("${80 * passengerList.length}")
              : 250,
          width: 330,
          child: Scrollbar(
            child: ListView.builder(
              itemCount: passengerList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    passengerList[index].sex +
                        " " +
                        passengerList[index].name +
                        " " +
                        passengerList[index].family,
                  ),
                  isThreeLine: true,
                  leading: Text("${index + 1}"),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("کد ملی :" + " " + passengerList[index].melicode),
                      Text(
                        "تاریخ تولد: " + passengerList[index].brith,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ));
}

Step factor(
    BuildContext context,
    _singleCount,
    changemony,
    _single_price,
    _currency,
    _adultCount,
    _childbedCount,
    _child_price_bed,
    _babyCount,
    _baby_price,
    _adult_price,
    _totalPrice) {
  return Step(
    title: Text('صورتحساب هزینه ها'),
    isActive: true,
    content: Padding(
        padding: const EdgeInsets.only(top: 5),
        child: Column(
          children: <Widget>[
            //// بزرگسال
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                textDirection: TextDirection.rtl,
                children: <Widget>[
                  Expanded(
                      flex: 2,
                      child: Text('بزرگسال',
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.right)),
                  Expanded(
                    flex: 1,
                    child: Text(
                      ' X ${_singleCount.toString()}',
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text('${changemony(_single_price)} $_currency ',
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.left),
                  ),
                ],
              ),
            ),
            ////// نوجوان
            _adultCount != 0
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      textDirection: TextDirection.rtl,
                      children: <Widget>[
                        Expanded(
                            flex: 2,
                            child: Text('نوجوان',
                                textDirection: TextDirection.rtl,
                                textAlign: TextAlign.right)),
                        Expanded(
                          flex: 1,
                          child: Text(
                            ' X ${_adultCount.toString()}',
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text('${changemony(_adult_price)} $_currency ',
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.left),
                        ),
                      ],
                    ),
                  )
                : Visibility(
                    visible: false,
                    child: Container(),
                  ),
            //////کودک با تخت
            _childbedCount != 0
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      textDirection: TextDirection.rtl,
                      children: <Widget>[
                        Expanded(
                            flex: 2,
                            child: Text('کودک',
                                textDirection: TextDirection.rtl,
                                textAlign: TextAlign.right)),
                        Expanded(
                          flex: 1,
                          child: Text(
                            ' X ${_childbedCount.toString()}',
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                              '${changemony(_child_price_bed)} $_currency ',
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.left),
                        ),
                      ],
                    ),
                  )
                : Visibility(
                    visible: false,
                    child: Container(),
                  ),
            //////نوزاد
            _babyCount != 0
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      textDirection: TextDirection.rtl,
                      children: <Widget>[
                        Expanded(
                            flex: 2,
                            child: Text('نوزاد',
                                textDirection: TextDirection.rtl,
                                textAlign: TextAlign.right)),
                        Expanded(
                          flex: 1,
                          child: Text(
                            ' X ${_babyCount.toString()}',
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text('${changemony(_baby_price)} $_currency ',
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.left),
                        ),
                      ],
                    ),
                  )
                : Visibility(
                    visible: false,
                    child: Container(),
                  ),
            //////
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                textDirection: TextDirection.rtl,
                children: <Widget>[
                  Expanded(
                      flex: 2,
                      child: Text('جمع مبالغ',
                          textDirection: TextDirection.rtl,
                          style: TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.right)),
                  Expanded(
                    flex: 1,
                    child: Text(
                      '',
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text('${changemony(_totalPrice)} $_currency ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.left),
                  ),
                ],
              ),
            )
          ],
        )),
  );
}

Step pay(BuildContext context, _email, _mobile, _phone, Key _key) {
  return Step(
      title: Text('پرداخت صورتحساب'),
      content: Center(
          child: Form(
        key: _key,
        child: Column(
          children: <Widget>[
            TextField(
              controller: _email,
              decoration: InputDecoration(
                hintText: 'آدرس ایمیل',
                hintStyle: TextStyle(fontSize: 13),
                counterText: '',
              ),
              keyboardType: TextInputType.emailAddress,
              maxLength: 25,
            ),
            TextField(
              controller: _mobile,
              decoration: InputDecoration(
                hintText: 'شماره همراه',
                hintStyle: TextStyle(fontSize: 13),
                counterText: '',
              ),
              keyboardType: TextInputType.phone,
              maxLength: 11,
            ),
            TextFormField(
              controller: _phone,
              decoration: InputDecoration(
                hintText: 'شماره ثابت',
                hintStyle: TextStyle(fontSize: 13),
                counterText: '',
              ),
              keyboardType: TextInputType.phone,
              maxLength: 11,
            )
          ],
        ),
      )));
}
