import 'package:flutter/material.dart';
import 'package:hello_flutter/scoped_model.dart';
import 'package:jalali_calendar/jalali_calendar.dart';
import 'package:scoped_model/scoped_model.dart';

typedef OnDelete = void Function(int index);

class UserForm extends StatefulWidget {
  final int index;
  //final VoidCallback onDelete;
// final OnDelete onDelete;

  const UserForm({Key key, this.index}) : super(key: key);

  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  int _radioValue = 0;
  int _national;
  GlobalKey<FormState> _keyform;

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
        model.passengers[widget.index].nationality = _national.toString();

        return Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
              child: Form(
                key: _keyform,
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
                              onSaved: (val) => setState(
                                () => model.passengers[widget.index].name = val,
                              ),
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return 'این فیلد ضروری می باشد';
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
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            flex: 1,
                            child: TextFormField(
                              onSaved: (val) => setState(
                                () =>
                                    model.passengers[widget.index].family = val,
                              ),
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return 'این فیلد ضروری می باشد';
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
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: TextFormField(
                              onSaved: (val) => setState(
                                () => model.passengers[widget.index].melicode =
                                    val,
                              ),
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return 'این فیلد ضروری می باشد';
                                }
                              },
                              decoration: InputDecoration(
                                  hintText: 'کدملی/پاسپورت',
                                  hintStyle: TextStyle(fontSize: 13),
                                  counterText: ''),
                              keyboardType: TextInputType.number,
                              maxLength: 10,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              flex: 1,
                              child: DropdownButtonFormField(
                                validator: (int valid) {
                                  if (valid == null)
                                    return 'ملیت را انتخاب کنید';
                                },
                                items: [
                                  DropdownMenuItem(
                                    child: Text('ایرانی',
                                        style: Theme.of(context)
                                            .textTheme
                                            .display4),
                                    value: 1,
                                  ),
                                  DropdownMenuItem(
                                    child: Text('غیر ایرانی',
                                        style: Theme.of(context)
                                            .textTheme
                                            .display4),
                                    value: 2,
                                  ),
                                ],
                                onChanged: (selectedItem) {
                                  print(selectedItem);
                                  setState(() {
                                    _national = selectedItem;
                                  });
                                },
                                value: _national,
                                hint: Text('ملیت مسافر'),
                              ))
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
