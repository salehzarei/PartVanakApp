import 'package:flutter/material.dart';
import 'package:hello_flutter/Theme/drawerTheme.dart';
import 'package:hello_flutter/drawer.dart';

class Ticket extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          drawer: MyDrawer(),
          appBar: AppBar(
            iconTheme: Theme.of(context)
                .iconTheme
                .copyWith(color: Theme.of(context).accentColor),
            centerTitle: true,
            title: Text('تیکت ها', style: Theme.of(context).textTheme.display2),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.arrow_forward,
                    color: Theme.of(context).accentColor),
                onPressed: () => Navigator.pushNamed(context, '/homepage'),
              )
            ],
          ),
          body: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(5),
                child: Container(
                  height: 140,
                  child: Card(
                    color: Colors.grey.shade700,
                    child: ListView(
                      children: <Widget>[
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(20),
                                child: Text('سلام',style: TextStyle(color: Colors.white),),
                              ),
                              Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Text('خرید کردم',style: TextStyle(color: Colors.white),),
                                  ),
                                  SizedBox(
                                    width: 180,
                                  ),
                                  Container(
                                    width: 100,
                                    child: RaisedButton(
                                      child: Text('ادامه مطلب'),
                                      onPressed: () {
                                         Navigator.pushNamed(context, '/newticket');
                                      },
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              /////////////////////////پیام جدید////////////////////////////
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                      //decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.grey.shade800,
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 5,
                          ),
                          GestureDetector(
                            onTap: () {
                             Navigator.pushNamed(context, '/newticket');
                            },
                            child: Container(
                              width: 125,
                              child: Column(
                                children: <Widget>[
                                  Icon(
                                    Icons.message,
                                    color: Theme.of(context).accentColor,
                                  ),
                                  Text(
                                    'پیام جدید',
                                    style: DarwerThemeData.textTheme.title,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      )),
                ],
              ),
            ],
          )),
    );
  }
}
