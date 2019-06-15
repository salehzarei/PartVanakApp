import 'package:flutter/material.dart';
import './Theme/drawerTheme.dart';
import './pages/aboutus.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
        child: Container(
      width: 250,
      decoration: BoxDecoration(
        color: Theme.of(context).appBarTheme.color,
      ),
      child: Column(
        children: <Widget>[
          Container(
            width: 250,
            // decoration: BoxDecoration(
            //     color: Colors.blueAccent.shade700.withOpacity(0.9)),
            child: Column(
              children: <Widget>[
                Container(
                  width: 143,
                  margin: EdgeInsets.only(top: 40),
                  padding: EdgeInsets.only(left: 10, right: 12),
                  decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          topLeft: Radius.circular(15))),
                  child: Row(
                    textDirection: TextDirection.rtl,
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '09154127181',
                        style: Theme.of(context).appBarTheme.textTheme.display1,
                      ),
                      Icon(
                        Icons.phone,
                        color: Theme.of(context).iconTheme.color,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 125,
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10.2),
                              child: Icon(
                                Icons.phone,
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                            Text(
                              'تلگرام',
                              style: DarwerThemeData.textTheme.title,
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: 125,
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10.2),
                              child: Icon(
                                Icons.phone,
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                            Text(
                              'اینستاگرام',
                              style: DarwerThemeData.textTheme.title,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20, left: 15.0, right: 15),
                  height: 1,
                  decoration: BoxDecoration(
                      color: Theme.of(context).accentColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          bottomLeft: Radius.circular(5))),
                ),
                GestureDetector(
                    onTap: () {
                      print('kkkkk');
                      Navigator.pushNamed(context, '/contact');
                    },
                    child: Container(
                      padding: EdgeInsets.only(top: 15.0, left: 15, right: 20),
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Icon(
                              Icons.phone,
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                          // Text(
                          //   'درباره ما',
                          //   style: DarwerThemeData.textTheme.title,
                          // )
                          InkWell(
                            child: Text('درباره ما',style: DarwerThemeData.textTheme.title,),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AboutUs()),
                              );
                            },
                          ),
                        ],
                      ),
                    )),
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: EdgeInsets.only(top: 15.0, left: 15, right: 20),
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Icon(
                              Icons.phone,
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                          Text(
                            'تماس با ما',
                            style: DarwerThemeData.textTheme.title,
                          )
                        ],
                      ),
                    )),
                Container(
                  margin: EdgeInsets.only(top: 20, left: 15.0, right: 15),
                  height: 1,
                  decoration: BoxDecoration(
                      color: Theme.of(context).accentColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          bottomLeft: Radius.circular(5))),
                )
              ],
            ),
          )
        ],
      ),
    ));
  }
}
