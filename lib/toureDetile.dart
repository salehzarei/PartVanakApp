import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import './UI/toureDetiles/hoteldetile.dart';
import './model/toure_model.dart';
import './UI/toureDetiles/detiles.dart';

class ToureDetilePage extends StatelessWidget {
  final Toure toure;

  const ToureDetilePage({Key key, this.toure}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'تور ${toure.title}',
          style: Theme.of(context).textTheme.title,
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: Theme.of(context).iconTheme,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {},
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Text(
            toure.sdate,
            style: Theme.of(context).textTheme.title.copyWith(fontSize: 17),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 100,
                child: Column(
                  children: <Widget>[
                    Text(
                      'مقصد',
                      style: TextStyle(
                          fontSize: 15, color: Theme.of(context).accentColor),
                    ),
                    Text(
                      'KSH',
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).accentColor),
                    ),
                    Text(
                      toure.destination_title,
                      style: TextStyle(fontSize: 15, color: Colors.grey),
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
                    Icons.airplanemode_active,
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
                  children: <Widget>[
                    Text(
                      'مبدا',
                      style: TextStyle(
                          fontSize: 15, color: Theme.of(context).accentColor),
                    ),
                    Text(
                      'MHD',
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).accentColor),
                    ),
                    Text(
                      toure.source_title,
                      style: TextStyle(fontSize: 15, color: Colors.grey),
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
                        'تاریخ های شروع',
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
              children: <Widget>[Detiles(), HotelDetile()],
            ),
          ),
        ],
      ),
    );
  }
}
