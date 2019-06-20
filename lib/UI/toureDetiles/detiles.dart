import 'package:flutter/material.dart';
import 'package:hello_flutter/coustomIcon/toure_icons_icons.dart';
import '../../model/toure_model.dart';


class Detiles extends StatelessWidget {
  final Toure toure;

  const Detiles({Key key, this.toure}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
            
             Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          padding: EdgeInsets.only(left:8,right:8,bottom: 8),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: Theme.of(context).accentColor),
                  )),
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
                          ToureIcons.departures,
                          size: 15,
                          color: Colors.white,
                        ),
                        SizedBox(width: 5),
                        Text(
                          'وسیله نقلیه رفت و برگشت',
                          style: Theme.of(context).textTheme.display3,
                        ),
                        SizedBox(width: 5),
                        Text(
                          toure.vehicl_went,
                          style: Theme.of(context).textTheme.display4.copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Row(
                        textDirection: TextDirection.rtl,
                        children: <Widget>[
                          Icon(
                            ToureIcons.first_day,
                            size: 15,
                            color: Colors.white,
                          ),
                          SizedBox(width: 5),
                          Text(
                            'تاریخ رفت    ',
                            style: Theme.of(context).textTheme.display3,
                          ),
                          SizedBox(width: 5),
                          Text(
                            toure.sdate,
                            style: Theme.of(context).textTheme.display4.copyWith(color: Colors.white),
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
                            ToureIcons.first_day,
                            size: 15,
                            color: Colors.white,
                          ),
                          SizedBox(width: 5),
                          Text(
                            'تاریخ برگشت',
                            style: Theme.of(context).textTheme.display3,
                          ),
                          SizedBox(width: 5),
                          Text(
                            toure.edate,
                            style: Theme.of(context).textTheme.display4.copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
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
                          ToureIcons.tent,
                          size: 15,
                          color: Colors.white,
                        ),
                        SizedBox(width: 5),
                        Text(
                          'نوع تور',
                          style: Theme.of(context).textTheme.display3,
                        ),
                        SizedBox(width: 5),
                        Text(
                          toure.difficulty,
                          style: Theme.of(context).textTheme.display4.copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Row(
                        textDirection: TextDirection.rtl,
                        children: <Widget>[
                          Icon(
                            ToureIcons.suitcase,
                            size: 15,
                            color: Colors.white,
                          ),
                          SizedBox(width: 5),
                          Text(
                            'ظرفیت تور',
                            style: Theme.of(context).textTheme.display3,
                          ),
                          SizedBox(width: 5),
                          Text(
                            '${toure.capacity.toString()} نفر',
                            style: Theme.of(context).textTheme.display4.copyWith(color: Colors.white),
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
                            ToureIcons.hotel,
                            size: 15,
                            color: Colors.white,
                          ),
                          SizedBox(width: 5),
                          Text(
                            'مدت تور',
                            style: Theme.of(context).textTheme.display3,
                          ),
                          SizedBox(width: 5),
                          Text(
                            '${toure.nights.toString()} شب',
                            style: Theme.of(context).textTheme.display4.copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
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