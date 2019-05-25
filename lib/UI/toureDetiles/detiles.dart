import 'package:flutter/material.dart';

class Detiles extends StatefulWidget {
  @override
  _DetilesState createState() => _DetilesState();
}

class _DetilesState extends State<Detiles> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Text(
            'مشخصات تور',
            style: Theme.of(context).textTheme.title.copyWith(fontSize: 17),
          ),
        ),
          Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: Theme.of(context).accentColor),
                  top: BorderSide(color: Theme.of(context).accentColor))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Column(
                  textDirection: TextDirection.rtl,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      textDirection: TextDirection.rtl,
                      children: <Widget>[
                        Icon(
                          Icons.people,
                          size: 15,
                          color: Theme.of(context).iconTheme.color,
                        ),
                        SizedBox(width: 5),
                        Text(
                          'نوع سفر',
                          style: Theme.of(context).textTheme.display3,
                        ),
                        SizedBox(width: 5),
                        Text(
                          'هوایی',
                          style: Theme.of(context).textTheme.display4,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Row(
                        textDirection: TextDirection.rtl,
                        children: <Widget>[
                          Icon(
                            Icons.timer,
                            size: 15,
                            color: Theme.of(context).iconTheme.color,
                          ),
                          SizedBox(width: 5),
                          Text(
                            'تاریخ رفت',
                            style: Theme.of(context).textTheme.display3,
                          ),
                          SizedBox(width: 5),
                          Text(
                            '98/9/12',
                            style: Theme.of(context).textTheme.display4,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Row(
                        textDirection: TextDirection.rtl,
                        children: <Widget>[
                          Icon(
                            Icons.timer,
                            size: 15,
                            color: Theme.of(context).iconTheme.color,
                          ),
                          SizedBox(width: 5),
                          Text(
                            'مدت تور',
                            style: Theme.of(context).textTheme.display3,
                          ),
                          SizedBox(width: 5),
                          Text(
                            '3 شب',
                            style: Theme.of(context).textTheme.display4,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              /////////////// ستون دوم
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Column(
                  textDirection: TextDirection.rtl,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      textDirection: TextDirection.rtl,
                      children: <Widget>[
                        Icon(
                          Icons.people,
                          size: 15,
                          color: Theme.of(context).iconTheme.color,
                        ),
                        SizedBox(width: 5),
                        Text(
                          'نوع سفر',
                          style: Theme.of(context).textTheme.display3,
                        ),
                        SizedBox(width: 5),
                        Text(
                          'هوایی',
                          style: Theme.of(context).textTheme.display4,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Row(
                        textDirection: TextDirection.rtl,
                        children: <Widget>[
                          Icon(
                            Icons.timer,
                            size: 15,
                            color: Theme.of(context).iconTheme.color,
                          ),
                          SizedBox(width: 5),
                          Text(
                            'تاریخ رفت',
                            style: Theme.of(context).textTheme.display3,
                          ),
                          SizedBox(width: 5),
                          Text(
                            '98/9/12',
                            style: Theme.of(context).textTheme.display4,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Row(
                        textDirection: TextDirection.rtl,
                        children: <Widget>[
                          Icon(
                            Icons.timer,
                            size: 15,
                            color: Theme.of(context).iconTheme.color,
                          ),
                          SizedBox(width: 5),
                          Text(
                            'مدت تور',
                            style: Theme.of(context).textTheme.display3,
                          ),
                          SizedBox(width: 5),
                          Text(
                            '3 شب',
                            style: Theme.of(context).textTheme.display4,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
   
      ],
    );
  }
}
