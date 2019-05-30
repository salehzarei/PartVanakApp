import 'package:flutter/material.dart';
import 'package:hello_flutter/UI/passenger.dart';

class BuyTicket extends StatefulWidget {
  @override
  _BuyTicketState createState() => _BuyTicketState();
}

class _BuyTicketState extends State<BuyTicket> {
  int _bigPerson = 0;
  int _kids = 0;
  int _baby = 0;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 25),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text('تعداد نفرات رو انتخاب کنید', textAlign: TextAlign.center,),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Wrap(
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
                  ]),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                alignment: WrapAlignment.end,
                spacing: 10,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.add_circle),
                    color: Colors.green,
                    iconSize: 25,
                    onPressed: () {
                      setState(() {
                        _bigPerson++;
                      });
                    },
                  ),
                  Text(
                    '${_bigPerson.toString()} نفر',
                    style: Theme.of(context)
                        .textTheme
                        .headline
                        .copyWith(fontSize: 14, color: Colors.grey),
                  ),
                  IconButton(
                    icon: Icon(Icons.remove_circle),
                    color: Colors.red,
                    iconSize: 25,
                    onPressed: () {
                      if (_bigPerson > 0)
                        setState(() {
                          _bigPerson--;
                        });
                    },
                  )
                ],
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Wrap(
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
                      'افراد زیر 14 سال',
                      style: Theme.of(context)
                          .textTheme
                          .headline
                          .copyWith(fontSize: 11, color: Colors.grey),
                    )
                  ]),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                alignment: WrapAlignment.end,
                spacing: 10,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.add_circle),
                    color: Colors.green,
                    iconSize: 25,
                    onPressed: () {
                      setState(() {
                        _kids++;
                      });
                    },
                  ),
                  Text(
                    '${_kids.toString()} نفر',
                    style: Theme.of(context)
                        .textTheme
                        .headline
                        .copyWith(fontSize: 14, color: Colors.grey),
                  ),
                  IconButton(
                    icon: Icon(Icons.remove_circle),
                    color: Colors.red,
                    iconSize: 25,
                    onPressed: () {
                      setState(() {
                        if (_kids > 0) _kids--;
                      });
                    },
                  )
                ],
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Wrap(
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
                  ]),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                alignment: WrapAlignment.end,
                spacing: 10,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.add_circle),
                    color: Colors.green,
                    iconSize: 25,
                    onPressed: () {
                      setState(() {
                        _baby++;
                      });
                    },
                  ),
                  Text(
                    '${_baby.toString()} نفر',
                    style: Theme.of(context)
                        .textTheme
                        .headline
                        .copyWith(fontSize: 14, color: Colors.grey),
                  ),
                  IconButton(
                    icon: Icon(Icons.remove_circle),
                    color: Colors.red,
                    iconSize: 25,
                    onPressed: () {
                      if (_baby > 0)
                        setState(() {
                          _baby--;
                        });
                    },
                  )
                ],
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 25),
            child: Text(
                'تعداد $_bigPerson بزرگسال و $_kids کودک و $_baby نوزاد انتخاب شد' , textAlign: TextAlign.center,),
          ),

          Padding(
            padding: EdgeInsets.only(top: 25),
            child: MaterialButton(
            onPressed: ()=>Navigator.push(context, MaterialPageRoute(
              builder: (context)=>Passenger(
              personcount: [_bigPerson,_kids,_baby],
            ) ,
            )),
            minWidth: 300,
            padding: EdgeInsets.symmetric(vertical: 15),
            child: Text(
              'ورود مشخصات مسافران',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            elevation: 2,
            color: Theme.of(context).accentColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          ),
          )
        ],
      ),
    );
  }
}
