import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:hello_flutter/coustomIcon/toure_icons_icons.dart';
import 'package:hello_flutter/drawer.dart';
import './UI/toureDetiles/hoteldetile.dart';
import './model/toure_model.dart';
import './UI/toureDetiles/detiles.dart';

class ToureDetilePage extends StatelessWidget {
  final Toure toure;

  const ToureDetilePage({Key key, this.toure}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_forward),
              onPressed: () => Navigator.pop(context),
            ),
          ],
          title: Text(
            toure.title,
            style: Theme.of(context).textTheme.title,
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          iconTheme: Theme.of(context).iconTheme,
        ),
        drawer: MyDrawer(),
        body: Column(
          children: <Widget>[
            Text(
              toure.sdate,
              style: Theme.of(context)
                  .textTheme
                  .title
                  .copyWith(fontSize: 17, color: Colors.grey),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'مبدا',
                        style: TextStyle(
                            fontSize: 15, color: Theme.of(context).accentColor),
                      ),
                      Text(
                        toure.source_title,
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).accentColor),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: <Widget>[
                    Container(
                      color: Theme.of(context).accentColor,
                      height: 2,
                      width: 50,
                    ),
                    Icon(
                      ToureIcons.airplane_flight,
                      size: 28,
                      color: Theme.of(context).accentColor,
                    ),
                    Container(
                      color: Theme.of(context).accentColor,
                      height: 2,
                      width: 50,
                    ),
                  ],
                ),
                Container(
                  width: 100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'مقصد',
                        style: TextStyle(
                            fontSize: 15, color: Theme.of(context).accentColor),
                      ),
                      Text(
                        toure.destination_title,
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).accentColor),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 9.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Container(
                        color: Theme.of(context).accentColor,
                        height: 1,
                        width: MediaQuery.of(context).size.width,
                      ),
                      Container(
                        height: 25,
                        width: 150,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Theme.of(context).accentColor),
                        alignment: Alignment.center,
                        child: Text(
                          'جزئیات تور',
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            // CarouselSlider(
            //   height: 50,
            //   items: <Widget>[
            //     IconButton(
            //       icon: Icon(Icons.airplay),
            //       onPressed: () {},
            //     ),
            //     IconButton(
            //       icon: Icon(Icons.airplay),
            //       onPressed: () {},
            //     ),
            //     IconButton(
            //       icon: Icon(Icons.airplay),
            //       onPressed: () {},
            //     ),
            //     IconButton(
            //       icon: Icon(Icons.airplay),
            //       onPressed: () {},
            //     ),
            //     IconButton(
            //       icon: Icon(Icons.airplay),
            //       onPressed: () {},
            //     )
            //   ],
            // ),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  Padding(
                      padding:
                          const EdgeInsets.only(top: 10, right: 10, left: 10),
                      child: Text(
                        toure.desc,
                        textAlign: TextAlign.start,
                       textDirection: TextDirection.rtl,
                        style: TextStyle(fontSize: 13),
                      )),
                  Detiles(toure:toure),
                  HotelDetile(toure:toure)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
