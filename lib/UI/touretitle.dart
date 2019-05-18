import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ToureTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(25),
        child: Stack(
          textDirection: TextDirection.rtl,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 75,
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8)),
                    color: Theme.of(context).accentColor,
                    image: DecorationImage(
                      image: NetworkImage('https://t4t.ir/files/large/fbdeed3829b01ca'),
                      fit: BoxFit.cover
                    )
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: Text(
                    'آژانس آسمان کهن',
                    style: Theme.of(context).textTheme.subtitle,
                    textAlign: TextAlign.right,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: Text(
                    'تور آنتالیا - ترکیه',
                    style: Theme.of(context).textTheme.headline,
                    textAlign: TextAlign.right,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 60),
                  child: Text(
                    'هتل های پنج ستاره',

                    style: Theme.of(context).textTheme.subtitle,
               
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  height: 27,
                  width: 150,
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8)),
                    color: Theme.of(context).accentColor,
                  ),
                  child: Text("250.000 تومان", style: TextStyle(fontSize: 14)),
                )
              ],
            ),
            Positioned(
              left: 3,
              top: 55,
              child: Card(
                color: Colors.red,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text("7 شب",style: TextStyle(color: Colors.white),),
                ),
              )
            )
          ],
        ));
  }
}
