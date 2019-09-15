import 'package:flutter/material.dart';
//import 'package:flutter/rendering.dart';
//import 'package:flutter/widgets.dart';
import 'package:jalali_calendar/jalali_calendar.dart';
import 'package:scoped_model/scoped_model.dart';
import '../scoped_model.dart';

typedef OnDelete = void Function(int index);

class UserForm extends StatefulWidget {
  final int index;

  const UserForm({Key key, this.index}) : super(key: key);

  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  int _radioValue = 0;
  bool _national = false;
  GlobalKey<FormState> _keyform;

  _changeValue(value) {
    setState(() {
      _radioValue = value;
    });
  }

  _changenational(value) {
    setState(() {
      _national = value;
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
  void initState() {
    super.initState();
    _keyform = GlobalKey();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (context, child, model) {
        model.userFormKey.add(_keyform);
        // ثبت و تغییر جنسیت هر مسافر در اسکوپ مدل
        if (_radioValue == 0) {
          model.passengers[widget.index].sex = 'آقای';
        } else {
          model.passengers[widget.index].sex = 'خانم';
        }
        // ثبت و تغییر تاریخ تولد هر مسافر در اسکوپ مدل
        model.passengers[widget.index].brith = "$_year/$_month/$_day";
        // ثبت و تغییر ملیت هر مسافر در اسکوپ مدل
        if (_national == true) {
          model.passengers[widget.index].nationality = '1';
        } else {
          model.passengers[widget.index].nationality = '2';
        }

        return Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
              child: Form(
                key: _keyform,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Theme.of(context).primaryColor,
                            blurRadius: 2.5,
                            offset: Offset(0.0, 1.0),
                            spreadRadius: 0.5),
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                onSaved: (val) => setState(
                                  () =>
                                      model.passengers[widget.index].name = val,
                                ),
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return 'ورود نام ضروری است';
                                  }
                                },
                                decoration: InputDecoration(
                                    hintText: 'نام',
                                    isDense: true,
                                    hintStyle: TextStyle(fontSize: 13),
                                    counterText: ''),
                                keyboardType: TextInputType.text,
                                maxLength: 10,
                              ),
                              TextFormField(
                                onSaved: (val) => setState(
                                  () => model.passengers[widget.index].family =
                                      val,
                                ),
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return 'ورود نام خانوادگی ضروری است';
                                  }
                                },
                                decoration: InputDecoration(
                                  hintText: 'نام خانوادگی',
                                  hintStyle: TextStyle(fontSize: 13),
                                  counterText: '',
                                ),
                                keyboardType: TextInputType.text,
                                maxLength: 25,
                              ),
                              TextFormField(
                                onSaved: (val) => setState(
                                  () => model
                                      .passengers[widget.index].melicode = val,
                                ),
                                validator: (String value) {
                                  if (value.isEmpty || value.length < 10) {
                                    return 'کد ملی حداقل 10 رقم می باشد';
                                  }
                                },
                                decoration: InputDecoration(
                                    hintText: 'کدملی/پاسپورت',
                                    hintStyle: TextStyle(fontSize: 13),
                                    counterText: ''),
                                keyboardType: TextInputType.number,
                                maxLength: 10,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                CheckboxListTile(
                                  onChanged: _changenational,
                                  value: _national,
                                  dense: true,
                                  title: Text(
                                    'غیر ایرانی',
                                    style: TextStyle(fontSize: 10),
                                  ),
                                ),
                                Container(
                                    child: _year == null
                                        ? RaisedButton.icon(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            icon: Icon(
                                              Icons.date_range,
                                              color: Colors.white,
                                            ),
                                            label: Text(
                                              'تاریخ تولد',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            onPressed: () {
                                              _selectDate(context);
                                            },
                                          )
                                        : InkWell(
                                            onTap: () => _selectDate(context),
                                            child: Text(
                                              "تاریخ تولد $_year/$_month/$_day",
                                              textDirection: TextDirection.rtl,
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey.shade700),
                                            ),
                                          )),
                                Wrap(
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
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
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              right: MediaQuery.of(context).size.width / 3,
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  model.passengers[widget.index].title,
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
          ],
        );
      },
    );
  }
}
