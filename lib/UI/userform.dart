import 'package:flutter/material.dart';
import 'package:hello_flutter/scoped_model.dart';
import 'package:jalali_calendar/jalali_calendar.dart';
import 'package:scoped_model/scoped_model.dart';

class UserForm extends StatefulWidget {
  final int index;

  const UserForm({Key key, this.index}) : super(key: key);

  @override
  _UserFormState createState() => _UserFormState();

  //  bool isValid() => state.validate();
}

class _UserFormState extends State<UserForm> {
  int _radioValue = 0;
  // PassengerModel _passenger = PassengerModel();
  GlobalKey<FormState> _keyform = GlobalKey<FormState>();
  // TextEditingController _name = TextEditingController();
  // TextEditingController _family = TextEditingController();
  // TextEditingController _melicode = TextEditingController();

  // String name;

  _changeValue(value) {
    setState(() {
      _radioValue = value;
    });
  }

  bool saveFormData() {
    print("Run Save");
    var valid = _keyform.currentState.validate();
    if (valid) _keyform.currentState.save();
    return valid;
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
    return ScopedModelDescendant<MainModel>(
      builder: (context, child, model) {
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
                            //  initialValue: model.passengers[widget.index].name,
                              onSaved: (val) =>
                                  model.passengers[widget.index].name = val,
                           
                              validator: (val) => val.length != null
                                  ? null
                                  : 'نام را وارد کنید',
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
                              onSaved: (val) {},
                      
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
                              onSaved: (val) {},
                         
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
                      onPressed: () {
                                }),
                ))
          ],
        );
      },
    );
  }
}
