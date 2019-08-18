import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/services.dart';
import './drawer.dart';
import './scoped_model.dart';
import './model/passenger_model.dart';

class ChekOut extends StatefulWidget {
  final List<PassengerModel> passengerlist;

  const ChekOut({Key key, this.passengerlist}) : super(key: key);

  @override
  _ChekOutState createState() => _ChekOutState();
}

class _ChekOutState extends State<ChekOut> {
  int _single_price = 0;
  int _adult_price = 0;
  int _child_price = 0;
  int _child_price_bed = 0;
  int _baby_price = 0;
  int _adultCount = 0;
  int _childCount = 0;
  int _childbedCount = 0;
  int _babyCount = 0;
  int _totalPrice = 0;
  int _currrentStep = 0;
  int _singleCount = 0;
  String _currency = '';
  int _bankId;
  bool _visible = false;
  bool _finalStep = false;
  StepState _stepState = StepState.indexed;
  GlobalKey<FormState> _key;
  TextEditingController _phone = TextEditingController();
  TextEditingController _mobile = TextEditingController();
  TextEditingController _email = TextEditingController();

  @override
  void initState() {
    super.initState();

    /// خواندن مدل هتل انتخاب شده برای مقداردهی اولیه قیمت ها
    MainModel _model = ScopedModel.of(context);
    _model.getBankData().whenComplete(() {
      if (_model.bankList.length != 0) {
        _bankId = _model.bankList[0].bankid;
      } else
        print('هیج بانکی وجود ندارد');
    });

    /// مقدار دهی اولین درگاه بانکی

    /// مقدار دهی اولیه قیمت تورها
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

    /// اگرکاربر لاگین کرده باشد شماره تماس و ایمیل در مرحله آخر ثبت می شود

    if (_model.userToken.length != 0) {
      _model.loadingUserData().whenComplete(() {
        setState(() {
          _phone.text = _model.userProfile.tell;
          _email.text = _model.userProfile.email;
          _mobile.text = _model.userProfile.cell;
        });
      });
    }

    /// خواندن تعداد افراد و رده سنی آنها
    widget.passengerlist.forEach((passen) {
      switch (passen.type) {
        case "a":
          {
            setState(() {
              _singleCount++;
            });
          }
          break;

        case "b":
          {
            setState(() {
              _adultCount++;
            });
          }
          break;

        case "c":
          {
            setState(() {
              _childbedCount++;
            });
          }
          break;

        case "d":
          {
            setState(() {
              _babyCount++;
            });
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
      if (index < 3) {
        _currrentStep++;
        _visible = true;
      }
      if (index + 1 == 3) _finalStep = true;
    });
  }

  /// تپ کردن روی هر مورد
  _onStepTapped(index) {
    setState(() {
      _currrentStep = index;
      if (index < 3 && index > 0) {
        _visible = true;
        _finalStep = false;
      } else if (index == 0)
        _visible = false;
      else if (index == 3) _finalStep = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (context, child, model) {
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
                                onPressed: () => model.sendDataToServer(context,
                                    cell: _mobile.text,
                                    email: _email.text,
                                    tell: _phone.text,
                                    bankId: _bankId),
                                child: model.isLoading
                                    ? CircularProgressIndicator()
                                    : Text('پرداخت صورتحساب'),
                              )
                            : Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                        otherPassenger(
                            context, widget.passengerlist, _currrentStep),
                        factor(_currrentStep,
                            adult_price:
                                model.fixPrice(_adult_price.toString()),
                            adultCount: _adultCount,
                            baby_price: model.fixPrice(_baby_price.toString()),
                            babyCount: _babyCount,
                            child_price_bed:
                                model.fixPrice(_child_price_bed.toString()),
                            childbedCount: _childbedCount,
                            currency: _currency,
                            single_price:
                                model.fixPrice(_single_price.toString()),
                            singleCount: _singleCount,
                            totalPrice: model.fixPrice(_totalPrice.toString())),
                        contactinfo(context, _email, _mobile, _phone, _key,
                            _currrentStep),
                        Step(
                            state: _currrentStep <= 3
                                ? StepState.indexed
                                : StepState.complete,
                            title: Text('انتخاب درگاه بانکی'),
                            content: model.bankList.length != 0
                                ? ButtonBar(
                                    alignment: MainAxisAlignment.start,
                                    children: List.generate(
                                        model.bankList.length,
                                        (index) => Wrap(
                                              crossAxisAlignment:
                                                  WrapCrossAlignment.center,
                                              children: <Widget>[
                                                Radio(
                                                  value: model
                                                      .bankList[index].bankid,
                                                  groupValue: _bankId,
                                                  onChanged: (val) {
                                                    setState(() {
                                                      _bankId = model
                                                          .bankList[val].bankid;
                                                    });
                                                  },
                                                ),
                                                Text('درگاه بانکی ' +
                                                    model.bankList[index]
                                                        .bankTitle),
                                              ],
                                            )))
                                : Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Text(
                                      'هیج بانکی ثبت نشده است',
                                      style: TextStyle(color: Colors.redAccent),
                                    ),
                                  ))
                      ]))),
        );
      },
    );
  }
}

Step otherPassenger(
    BuildContext context, List<PassengerModel> passengerList, _stepState) {
  return Step(
      state: _stepState <= 0 ? StepState.indexed : StepState.complete,
      title: Text('مشخصات ${passengerList.length} مسافر این تور'),
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

Step factor(_stepState,
    {int singleCount,
    single_price,
    currency,
    adultCount,
    childbedCount,
    child_price_bed,
    babyCount,
    baby_price,
    adult_price,
    totalPrice}) {
  // return Step(
  //   title: Text('data'),
  //   content: Column(
  //     children: <Widget>[
  //       Text(singleCount.toString()),
  //       Text(single_price),
  //       Text(currency),
  //       Text(adultCount.toString()),
  //       Text(childbedCount.toString()),
  //       Text(totalPrice),
  //       Text(adult_price),
  //       Text(baby_price),
  //       Text(babyCount.toString())
  //     ],
  //   )
  // );
  return Step(
    state: _stepState <= 1 ? StepState.indexed : StepState.complete,
    title: Text('صورتحساب هزینه ها براساس نفرات'),
    content: Column(
      children: <Widget>[
        ////// بزرگسال
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
                  singleCount.toString(),
                  textAlign: TextAlign.left,
                ),
              ),
              Text(
                'x ',
                textAlign: TextAlign.center,
              ),
              Expanded(
                flex: 3,
                child: Text('$single_price $currency ',
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.left),
              ),
            ],
          ),
        ),

        ////// نوجوان
        adultCount != 0
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
                        adultCount.toString(),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Text(
                      'x ',
                      textAlign: TextAlign.center,
                    ),
                    Expanded(
                      flex: 3,
                      child: Text('$adult_price $currency ',
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
        ////کودک با تخت
        childbedCount != 0
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
                        childbedCount.toString(),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Text(
                      'x ',
                      textAlign: TextAlign.center,
                    ),
                    Expanded(
                      flex: 3,
                      child: Text('$child_price_bed $currency ',
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
        babyCount != 0
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
                        babyCount.toString(),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Text(
                      'x ',
                      textAlign: TextAlign.center,
                    ),
                    Expanded(
                      flex: 3,
                      child: Text('$baby_price $currency ',
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
        ////
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
                child: Text('$totalPrice $currency ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.left),
              ),
            ],
          ),
        )
      ],
    ),
  );
}

Step contactinfo(
    BuildContext context, _email, _mobile, _phone, Key _key, _stepState) {
  return Step(
      state: _stepState <= 2 ? StepState.indexed : StepState.complete,
      title: Text('ثبت اطلاعات تماس'),
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
