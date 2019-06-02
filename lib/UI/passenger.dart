import 'package:flutter/material.dart';
import 'package:jalali_calendar/jalali_calendar.dart';


class Passenger extends StatefulWidget {
  final List personcount;

  const Passenger({Key key, this.personcount}) : super(key: key);

  @override
  _PassengerState createState() => _PassengerState();
}

class _PassengerState extends State<Passenger> {
  @override
  Widget build(BuildContext context) {
    print(widget.personcount);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget.personcount.toString()),
        ),
        body: Directionality(
            textDirection: TextDirection.rtl,
            child: ListView(children: <Widget>[UserForm()])));
  }
}

class UserForm extends StatefulWidget {
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
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
                  decoration: InputDecoration(hintText: 'نام', counterText: ''),
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
                      hintText: 'کدملی/پاسپورت', counterText: ''),
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
                    hintText: 'تاریخ تولد',
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
                    alignment: WrapAlignment.center,
                    children: <Widget>[
                      Text(
                        'زن',
                        style: TextStyle(fontSize: 17),
                      ),
                      Radio(
                        value: 0,
                        groupValue: _radioValue,
                        onChanged: _changeValue,
                      ),
                      SizedBox(width: 5),
                      Text(
                        'مرد',
                        style: TextStyle(fontSize: 17),
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
                  child: FlatButton.icon(
                    icon: Icon(Icons.calendar_today),
                    label: _year == null
                        ? Text('تاریخ تولد')
                        : Text(
                            "$_year/$_month/$_day",
                            textDirection: TextDirection.rtl,
                            style: TextStyle(fontSize: 15),
                          ),
                    onPressed: () {
                      //  DatePicker.showDatePicker(context);
                      _selectDate(context);
                    },
                  ))
            ],
          )
        ],
      ),
    );
  }
}
