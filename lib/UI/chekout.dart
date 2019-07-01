import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:hello_flutter/drawer.dart';

import 'package:scoped_model/scoped_model.dart';
import '../scoped_model.dart';
import '../model/passenger_model.dart';

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
  String _currency = '';
  int _singleCount = 0;
  int _adultCount = 0;
  int _childCount = 0;
  int _childbedCount = 0;
  int _babyCount = 0;
  int _totalPrice = 0;
  int _currrentStep = 0;
  bool _visible = false;

  @override
  void initState() {
    super.initState();

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
        print(toure.title);
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
    _model.sendDataToServer();
    _ackAlert(context);
  }

  Future<void> _ackAlert(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            title: Text('درگاه بانکی رو انتخاب کنید'),
            content:
                const Text('متاسفانه هنوز برای این قسمت تور قرار گرفته نشده'),
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
    List<DataRow> listpassanger = widget.passengerlist
        .map((i) => DataRow(cells: [
              DataCell(Text(i.sex + " " + i.name + " " + i.family,
                  style: Theme.of(context).textTheme.subtitle)),
              DataCell(Text(i.melicode,
                  style: Theme.of(context).textTheme.subtitle)),
              DataCell(
                  Text(i.brith, style: Theme.of(context).textTheme.subtitle)),
            ]))
        .toList();

//// استخراج اطلاعات

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
                controlsBuilder: (BuildContext context,
                    {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
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
                onStepCancel: () {
                  setState(() {
                    if (_currrentStep > 0) {
                      _currrentStep--;
                      _visible = true;
                    } else {
                      _visible = false;
                    }
                  });
                },
                onStepContinue: () {
                  setState(() {
                    if (_currrentStep < 2) {
                      _currrentStep++;
                      _visible = true;
                    }
                  });
                },
                onStepTapped: (index) {
                  setState(() {
                    _currrentStep = index;
                  });
                },
                steps: [
                  masterPerson(context, widget.passengerlist),
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
                  otherPassenger(context, listpassanger),
                  pay(context),
                  
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

Step otherPassenger(BuildContext context, List<DataRow> listpassanger) {
  
return Step(
        title: Text('مشخصات سایر مسافرین'),
        isActive: true,
        content: Directionality(
          textDirection: TextDirection.rtl,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: [
                DataColumn(
                  label:
                      Text('نام', style: Theme.of(context).textTheme.headline),
                ),
                DataColumn(
                  label: Text('کدملی',
                      style: Theme.of(context).textTheme.headline),
                ),
                DataColumn(
                  label: Text('تاریخ تولد',
                      style: Theme.of(context).textTheme.headline),
                ),
              ],
              rows: listpassanger,
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

Step pay(
  BuildContext context,
) {
  Step(
      title: Text('پرداخت صورتحساب'),
      content: Center(
        child: Text('هیج همراهی با این مسافر نیست'),
      ));
}
