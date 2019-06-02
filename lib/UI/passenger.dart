import 'dart:math';

import 'package:flutter/material.dart';
import 'package:jalali_calendar/jalali_calendar.dart';

class Passenger extends StatefulWidget {
  final List<String> personcount;

  const Passenger({Key key, this.personcount}) : super(key: key);

  @override
  _PassengerState createState() => _PassengerState();
}

class _PassengerState extends State<Passenger> {
  final Map<String, String> selectedPersonList = {};

  @override
  void initState() {
    super.initState();
    // تبدیل لیست به مپ برای سهولت در انجام حذف لیست
    for (var i = 0; i < widget.personcount.length; i++) {
      selectedPersonList[i.toString()] = widget.personcount[i];
    }
  }

  @override
  Widget build(BuildContext context) {
    var keys = selectedPersonList.keys.toList();
    print(keys);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget.personcount.toString()),
        ),
        body: Directionality(
            textDirection: TextDirection.rtl,
            child: Padding(
                padding: const EdgeInsets.only(top: 15),
                child: ListView.builder(
                  itemCount: keys.length,
                  itemBuilder: (context, index) {
                    String _title;
                    String _key = keys[index];
                    switch (selectedPersonList.values.elementAt(index)) {
                      case "a":
                        {
                          _title = 'مشخصات بزرگسال';
                        }
                        break;

                      case "b":
                        {
                          _title = 'مشخصات نوجوان';
                        }
                        break;

                      case "c":
                        {
                          _title = 'مشخصات کودک';
                        }
                        break;

                      case "d":
                        {
                          _title = 'مشخصات نوزاد';
                        }
                        break;

                      default:
                        {
                          _title = 'نامشخص';
                        }
                        break;
                    }

                    return _key != '0'
                        // اگر بزرگسال نبود قابلیت دیسمیس رو بده وگرنه که نده
                        ? Dismissible(
                            key: Key(_key),
                            onDismissed: (_) {
                              setState(() {
                               selectedPersonList.remove(_key); 
                              });
                            },
                            //deleteFromList(_key, index),
                            child: UserForm(title: _title))
                        : UserForm(title: _title);
                  },
                ))));
  }
}

class UserForm extends StatefulWidget {
  final String title;

  const UserForm({Key key, this.title}) : super(key: key);

  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  int _radioValue = 0;

  _changeValue(value) {
    setState(() {
      _radioValue = value;
    });
  }

  String _year, _month, _day;

  Future<Null> _selectDate(BuildContext context) async {
    DatePicker.showDatePicker(context, onConfirm: (y, m, d) {
      setState(() {
        _year = y.toString();
        _month = m.toString();
        _day = d.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                      color: Theme.of(context).primaryColor,
                      blurRadius: 2.5,
                      offset: Offset(0.0, 1.0),
                      spreadRadius: 0.5),
                ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              textDirection: TextDirection.rtl,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        decoration: InputDecoration(
                            hintText: 'نام',
                            hintStyle: TextStyle(fontSize: 13),
                            counterText: ''),
                        keyboardType: TextInputType.text,
                        maxLength: 10,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: 'نام خانوادگی',
                          hintStyle: TextStyle(fontSize: 13),
                          counterText: '',
                        ),
                        keyboardType: TextInputType.text,
                        maxLength: 25,
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        decoration: InputDecoration(
                            hintText: 'کدملی/پاسپورت',
                            hintStyle: TextStyle(fontSize: 13),
                            counterText: ''),
                        keyboardType: TextInputType.text,
                        maxLength: 10,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: 'محل تولد',
                          hintStyle: TextStyle(fontSize: 13),
                          counterText: '',
                        ),
                        keyboardType: TextInputType.text,
                        maxLength: 25,
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          alignment: WrapAlignment.start,
                          children: <Widget>[
                            Text(
                              'مرد',
                              style: TextStyle(fontSize: 14),
                            ),
                            Radio(
                              value: 0,
                              groupValue: _radioValue,
                              onChanged: _changeValue,
                            ),
                            Text(
                              'زن',
                              style: TextStyle(fontSize: 14),
                            ),
                            Radio(
                              value: 1,
                              groupValue: _radioValue,
                              onChanged: _changeValue,
                            ),
                          ]),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () => _selectDate(context),
                          child: Container(
                            child: _year == null
                                ? Text(
                                    'تاریخ تولد را انتخاب کنید',
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey.shade700),
                                  )
                                : Text(
                                    "$_year/$_month/$_day",
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(fontSize: 15),
                                  ),
                          ),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
        Positioned(
          right: MediaQuery.of(context).size.width / 3,
          child: Container(
            alignment: Alignment.center,
            child: Text(
              widget.title,
              style: TextStyle(fontSize: 12),
            ),
            width: 110,
            height: 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Theme.of(context).cardColor,
            ),
          ),
        ),
        Positioned(
            left: -8,
            top: -8,
            child: RotationTransition(
              turns: AlwaysStoppedAnimation(45 / 360),
              child: IconButton(
                  icon: Icon(
                    Icons.add_circle,
                    color: Colors.redAccent,
                    size: 25,
                  ),
                  onPressed: () {}),
            ))
      ],
    );
  }
}
