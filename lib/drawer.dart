import 'package:flutter/material.dart';
import './Theme/drawerTheme.dart';
import './coustomIcon/toure_icons_icons.dart';

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
            Padding(
              padding: const EdgeInsets.only(left: 100),
              child: Container(
                margin: EdgeInsets.only(top: 40),
                decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        topLeft: Radius.circular(15))),
                child: Row(
                  textDirection: TextDirection.rtl,
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
            ),
            //___________________________________شبکه های اجتماعی___________________________

            Container(
              margin: EdgeInsets.only(top: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      print('تلگرام');
                      //Navigator.pushNamed(context, '');
                    },
                    child: Container(
                      width: 125,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.2),
                            child: Icon(
                              ToureIcons.telegram,
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
                  ),
                  GestureDetector(
                    onTap: () {
                      print('اینستاگرام');
                      //Navigator.pushNamed(context, '');
                    },
                    child: Container(
                      width: 125,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.2),
                            child: Icon(
                              ToureIcons.instagram,
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                          Text(
                            'اینستاگرام',
                            style: DarwerThemeData.textTheme.title,
                          )
                        ],
                      ),
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
            //______________________________تورها_________________________________
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Stack(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        GestureDetector(
                            onTap: () {
                              print('تورهای خارجی');
                              Navigator.pushNamed(context, '/webview');
                            },
                            child: Container(
                              padding: EdgeInsets.only(
                                  top: 15.0, left: 15, right: 20),
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Icon(
                                      ToureIcons.around,
                                      color: Theme.of(context).accentColor,
                                    ),
                                  ),
                                  Text(
                                    'تور های خارجی',
                                    style: DarwerThemeData.textTheme.title,
                                  ),
                                ],
                              ),
                            )),
                        GestureDetector(
                            onTap: () {
                              print('تورهای داخلی');
                              //Navigator.pushNamed(context, '');
                            },
                            child: Container(
                              padding: EdgeInsets.only(
                                  top: 15.0, left: 15, right: 20),
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Icon(
                                      ToureIcons.azadi,
                                      color: Theme.of(context).accentColor,
                                    ),
                                  ),
                                  Text(
                                    'تور های داخلی',
                                    style: DarwerThemeData.textTheme.title,
                                  ),
                                ],
                              ),
                            )),
                        GestureDetector(
                            onTap: () {
                              print('تورهای طبیعتگردی');
                              //Navigator.pushNamed(context, '');
                            },
                            child: Container(
                              padding: EdgeInsets.only(
                                  top: 15.0, left: 15, right: 20),
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Icon(
                                      ToureIcons.tent,
                                      color: Theme.of(context).accentColor,
                                    ),
                                  ),
                                  Text(
                                    'تور های طبیعتگردی',
                                    style: DarwerThemeData.textTheme.title,
                                  ),
                                ],
                              ),
                            )),

                        GestureDetector(
                            onTap: () {
                              print('تور های یکروزه');
                              //Navigator.pushNamed(context, '');
                            },
                            child: Container(
                              padding: EdgeInsets.only(
                                  top: 15.0, left: 15, right: 20),
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Icon(
                                      ToureIcons.first_day,
                                      color: Theme.of(context).accentColor,
                                    ),
                                  ),
                                  Text(
                                    'تور های یکروزه',
                                    style: DarwerThemeData.textTheme.title,
                                  ),
                                ],
                              ),
                            )),
                        GestureDetector(
                            onTap: () {
                              print('تور های لاکچری');
                              //Navigator.pushNamed(context, '');
                            },
                            child: Container(
                              padding: EdgeInsets.only(
                                  top: 15.0, left: 15, right: 20),
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Icon(
                                      ToureIcons.crown_of_royal_design,
                                      color: Theme.of(context).accentColor,
                                    ),
                                  ),
                                  Text(
                                    'تور های لاکچری',
                                    style: DarwerThemeData.textTheme.title,
                                  ),
                                ],
                              ),
                            )),
                        GestureDetector(
                            onTap: () {
                              print('تور های لحظه آخری');
                              //Navigator.pushNamed(context, '');
                            },
                            child: Container(
                              padding: EdgeInsets.only(
                                  top: 15.0, left: 15, right: 20),
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Icon(
                                      ToureIcons.stopwatch,
                                      color: Theme.of(context).accentColor,
                                    ),
                                  ),
                                  Text(
                                    'تور های لحظه آخری',
                                    style: DarwerThemeData.textTheme.title,
                                  ),
                                ],
                              ),
                            )),

                        Container(
                          margin:
                              EdgeInsets.only(top: 20, left: 15.0, right: 15),
                          height: 1,
                          decoration: BoxDecoration(
                              color: Theme.of(context).accentColor,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  bottomLeft: Radius.circular(5))),
                        ),
                        //_________________________________اطلاعات_____________________________________
                        GestureDetector(
                            onTap: () {
                              print('اطلاعات پرواز فرودگاه ها');
                              //Navigator.pushNamed(context, '');
                            },
                            child: Container(
                              padding: EdgeInsets.only(
                                  top: 15.0, left: 15, right: 20),
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Icon(
                                      ToureIcons.airport,
                                      color: Theme.of(context).accentColor,
                                    ),
                                  ),
                                  Text(
                                    'اطلاعات پرواز فرودگاه ها',
                                    style: DarwerThemeData.textTheme.title,
                                  ),
                                ],
                              ),
                            )),
                        GestureDetector(
                            onTap: () {
                              print('پرداخت عوارض خروج');
                              //Navigator.pushNamed(context, '');
                            },
                            child: Container(
                              padding: EdgeInsets.only(
                                  top: 15.0, left: 15, right: 20),
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Icon(
                                      ToureIcons.passport_1,
                                      color: Theme.of(context).accentColor,
                                    ),
                                  ),
                                  Text(
                                    'پرداخت عوارش خروج',
                                    style: DarwerThemeData.textTheme.title,
                                  ),
                                ],
                              ),
                            )),

                        Container(
                          margin:
                              EdgeInsets.only(top: 20, left: 15.0, right: 15),
                          height: 1,
                          decoration: BoxDecoration(
                              color: Theme.of(context).accentColor,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  bottomLeft: Radius.circular(5))),
                        ),
                        //_________________________________درباره ما ، تماس با ما_____________________________________

                        GestureDetector(
                            onTap: () {
                              print('aboutus');
                              Navigator.pushNamed(context, '/aboutus');
                            },
                            child: Container(
                              padding: EdgeInsets.only(
                                  top: 15.0, left: 15, right: 20),
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Icon(
                                      ToureIcons.share,
                                      color: Theme.of(context).accentColor,
                                    ),
                                  ),
                                  Text(
                                    'درباره ما',
                                    style: DarwerThemeData.textTheme.title,
                                  )
                                ],
                              ),
                            )),
                        GestureDetector(
                            onTap: () {
                              print('contact');
                              Navigator.pushNamed(context, '/contact');
                            },
                            child: Container(
                              padding: EdgeInsets.only(
                                  top: 15.0, left: 15, right: 20),
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Icon(
                                      ToureIcons.call,
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
                          margin:
                              EdgeInsets.only(top: 20, left: 15.0, right: 15),
                          height: 1,
                          decoration: BoxDecoration(
                              color: Theme.of(context).accentColor,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  bottomLeft: Radius.circular(5))),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5, top: 15),
              child: Container(
                child: Image.asset(
                  'images/logo.png',
                  color: Theme.of(context).accentColor.withOpacity(0.3),
                  height: 100,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
