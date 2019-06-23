import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

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
  int _totalPrice = 0 ;

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

  @override
  Widget build(BuildContext context) {
    List<DataRow> listpassanger = widget.passengerlist
        .map((i) => DataRow(cells: [
              DataCell(Text(i.name + " " + i.family,
                  style: Theme.of(context).textTheme.subtitle)),
              DataCell(Text(i.melicode,
                  style: Theme.of(context).textTheme.subtitle)),
              DataCell(
                  Text(i.brith, style: Theme.of(context).textTheme.subtitle)),
            ]))
        .toList();

//// استخراج اطلاعات

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('صورتحساب',
            style: TextStyle(color: Colors.white, fontSize: 20)),
      ),
      body: Container(
        padding: EdgeInsets.all(5.0),
        child: Container(
          child: ListView(
            children: <Widget>[
              Card(
                child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    padding: EdgeInsets.all(10.0),
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
                                  child: Text(widget.passengerlist[0].name,
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
                                  child: Text(widget.passengerlist[0].melicode,
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
                                  child: Text(widget.passengerlist[0].sex,
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
                                  child: Text(widget.passengerlist[0].brith,
                                      textDirection: TextDirection.rtl,
                                      textAlign: TextAlign.right))
                            ],
                          ),
                        ),
                      ],
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  'مشخصات سایر مسافرین',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).accentColor),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8, bottom: 5),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columns: [
                          DataColumn(
                            label: Text('نام',
                                style: Theme.of(context).textTheme.headline),
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
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  'صورتحساب هزینه ها',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).accentColor),
                ),
              ),
              Card(
                child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    padding: EdgeInsets.all(10.0),
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
                                  child: Text('هزینه هر بزرگسال',
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
                                child: Text(
                                    '${changemony(_single_price)} $_currency ',
                                    textDirection: TextDirection.rtl,
                                    textAlign: TextAlign.left),
                              ),
                            ],
                          ),
                        ),
                        ////// نوجوان
                       _adultCount  != 0
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  textDirection: TextDirection.rtl,
                                  children: <Widget>[
                                    Expanded(
                                        flex: 2,
                                        child: Text('هزینه هر نوجوان',
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
                                      child: Text(
                                          '${changemony(_adult_price)} $_currency ',
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
                                        child: Text('هزینه هر کودک',
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
                                        child: Text('هزینه هر نوزاد',
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
                                      child: Text(
                                          '${changemony(_baby_price)} $_currency ',
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
                                  child: Text('جمع کل هزینه ها',
                                      textDirection: TextDirection.rtl,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
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
                                child: Text(
                                    '${changemony(_totalPrice)} $_currency ',
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                    textDirection: TextDirection.rtl,
                                    textAlign: TextAlign.left),
                              ),
                            ],
                          ),
                        )
                      ],
                    )),
              ),
              Padding(
                padding: EdgeInsets.only(top: 25),
                child: MaterialButton(
                  onPressed: () => {},
                  minWidth: 300,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    'خرید و پرداخت',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  elevation: 2,
                  color: Theme.of(context).accentColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 25),
                child: MaterialButton(
                  onPressed: () => {},
                  minWidth: 300,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    'ویرایش',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  elevation: 2,
                  color: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
