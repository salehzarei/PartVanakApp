import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import './UI/passenger.dart';
import './model/accommodation_model.dart';
import './scoped_model.dart';

class BuyTicket extends StatefulWidget {
  final Accommodation hotel;
  final int toureCapacity;
  const BuyTicket({Key key, this.hotel, this.toureCapacity}) : super(key: key);

  @override
  _BuyTicketState createState() => _BuyTicketState();
}

class _BuyTicketState extends State<BuyTicket> {
  int _bigPerson = 1;
  int _kids = 0;
  int _kidsbed = 0;
  int _baby = 0;
  bool _overflow = false;

  // لیست از تعداد نفرات مسافر - حروف a b c d مشخصه نوع افراد می باشد
  // یک نفر بزرگسال همیشه داخل لیست خواهد بود
  List<String> _personcountList = ['a'];

  @override
  void initState() {
    super.initState();

    /// ثبت آی دی هتل در لیست موقت خرید
    MainModel model = ScopedModel.of(context);
    model.tmpCartData['HotelID'] = widget.hotel.accommodation_id.toString();
  }

  @override
  Widget build(BuildContext context) {
    //// لیست را به ترتیب حروف الفبا مرتب میکنیم
    _personcountList.sort();

    /// اگر تعداد نفرات از ظرفیت زد بالا
    if (_personcountList.length > widget.toureCapacity) {
      setState(() {
        _overflow = true;
      });
    } else {
      setState(() {
        _overflow = false;
      });
    }

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                'لطفا تعداد نفرات را برای ${widget.hotel.hotel_title} مشخص کنید',
                textAlign: TextAlign.center,
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                    child: Wrap(
                        spacing: 10,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: <Widget>[
                      Text(
                        'بزرگسال',
                        style: Theme.of(context)
                            .textTheme
                            .headline
                            .copyWith(fontSize: 15),
                      ),
                      Text(
                        'افراد بالای 14 سال',
                        style: Theme.of(context)
                            .textTheme
                            .headline
                            .copyWith(fontSize: 11, color: Colors.grey),
                      )
                    ])),
                Expanded(
                    child: Row(children: <Widget>[
                  Expanded(
                    child: IconButton(
                        icon: Icon(Icons.add_circle),
                        color: Colors.green.shade300,
                        iconSize: 25,
                        onPressed: () {
                          setState(() {
                            _bigPerson++;
                            _personcountList.add('a');
                          });
                        }),
                  ),
                  Container(
                    width: 80,
                    alignment: Alignment.center,
                    child: Text(
                      '${_bigPerson.toString()} نفر',
                      style: Theme.of(context)
                          .textTheme
                          .headline
                          .copyWith(fontSize: 14, color: Colors.grey),
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                      icon: Icon(Icons.remove_circle),
                      color: Colors.red.shade300,
                      iconSize: 25,
                      onPressed: () {
                        if (_bigPerson > 1)
                          setState(() {
                            _bigPerson--;
                            _personcountList.remove('a');
                          });
                      },
                    ),
                  )
                ])),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                    child: Wrap(
                        spacing: 10,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: <Widget>[
                      Text(
                        'کودک',
                        style: Theme.of(context)
                            .textTheme
                            .headline
                            .copyWith(fontSize: 15),
                      ),
                      Text(
                        ' بدون تخت خواب',
                        style: Theme.of(context)
                            .textTheme
                            .headline
                            .copyWith(fontSize: 11, color: Colors.grey),
                      )
                    ])),
                Expanded(
                    child: Row(children: <Widget>[
                  Expanded(
                    child: IconButton(
                        icon: Icon(Icons.add_circle),
                        color: Colors.green.shade300,
                        iconSize: 25,
                        onPressed: () {
                          setState(() {
                            _kids++;
                            _personcountList.add('b');
                          });
                        }),
                  ),
                  Container(
                    width: 80,
                    alignment: Alignment.center,
                    child: Text(
                      '${_kids.toString()} نفر',
                      style: Theme.of(context)
                          .textTheme
                          .headline
                          .copyWith(fontSize: 14, color: Colors.grey),
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                      icon: Icon(Icons.remove_circle),
                      color: Colors.red.shade300,
                      iconSize: 25,
                      onPressed: () {
                        if (_kids > 0)
                          setState(() {
                            _kids--;
                            _personcountList.remove('b');
                          });
                      },
                    ),
                  )
                ])),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                    child: Wrap(
                        spacing: 10,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: <Widget>[
                      Text(
                        'کودک',
                        style: Theme.of(context)
                            .textTheme
                            .headline
                            .copyWith(fontSize: 15),
                      ),
                      Text(
                        'با تخت خواب',
                        style: Theme.of(context)
                            .textTheme
                            .headline
                            .copyWith(fontSize: 11, color: Colors.grey),
                      )
                    ])),
                Expanded(
                    child: Row(children: <Widget>[
                  Expanded(
                    child: IconButton(
                        icon: Icon(Icons.add_circle),
                        color: Colors.green.shade300,
                        iconSize: 25,
                        onPressed: () {
                          setState(() {
                            _kidsbed++;
                            _personcountList.add('c');
                          });
                        }),
                  ),
                  Container(
                    width: 80,
                    alignment: Alignment.center,
                    child: Text(
                      '${_kidsbed.toString()} نفر',
                      style: Theme.of(context)
                          .textTheme
                          .headline
                          .copyWith(fontSize: 14, color: Colors.grey),
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                      icon: Icon(Icons.remove_circle),
                      color: Colors.red.shade300,
                      iconSize: 25,
                      onPressed: () {
                        if (_kidsbed > 0)
                          setState(() {
                            _kidsbed--;
                            _personcountList.remove('c');
                          });
                      },
                    ),
                  )
                ])),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                    child: Wrap(
                        spacing: 10,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: <Widget>[
                      Text(
                        'نوزاد',
                        style: Theme.of(context)
                            .textTheme
                            .headline
                            .copyWith(fontSize: 15),
                      ),
                      Text(
                        'کودکان زیر 1 سال',
                        style: Theme.of(context)
                            .textTheme
                            .headline
                            .copyWith(fontSize: 11, color: Colors.grey),
                      )
                    ])),
                Expanded(
                    child: Row(children: <Widget>[
                  Expanded(
                    child: IconButton(
                        icon: Icon(Icons.add_circle),
                        color: Colors.green.shade300,
                        iconSize: 25,
                        onPressed: () {
                          setState(() {
                            _baby++;
                            _personcountList.add('d');
                          });
                        }),
                  ),
                  Container(
                    width: 80,
                    alignment: Alignment.center,
                    child: Text(
                      '${_baby.toString()} نفر',
                      style: Theme.of(context)
                          .textTheme
                          .headline
                          .copyWith(fontSize: 14, color: Colors.grey),
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                      icon: Icon(Icons.remove_circle),
                      color: Colors.red.shade300,
                      iconSize: 25,
                      onPressed: () {
                        if (_baby > 0)
                          setState(() {
                            _baby--;
                            _personcountList.remove('d');
                          });
                      },
                    ),
                  )
                ])),
              ],
            ),
            Padding(
                padding: EdgeInsets.only(top: 12),
                child: _overflow
                    ? Text(
                        'تعداد نفرات انتخاب شده از ظرفیت تور بیشتر است !',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.red),
                      )
                    : Text(
                        'تعداد $_bigPerson بزرگسال و $_kids کودک و $_baby نوزاد انتخاب شد',
                        textAlign: TextAlign.center,
                      )),
            Padding(
              padding: EdgeInsets.only(top: 15),
              child: IgnorePointer(
                ignoring: _overflow,
                child: MaterialButton(
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Passenger(
                          personcount: _personcountList,
                        ),
                      )),
                  minWidth: 300,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    'تایید و ثبت مشخصات مسافران',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  elevation: 2,
                  color: _overflow
                      ? Theme.of(context).buttonColor.withOpacity(0.5)
                      : Theme.of(context).buttonColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
