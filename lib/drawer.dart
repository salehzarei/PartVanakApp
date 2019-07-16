import 'package:flutter/material.dart';
import './Theme/drawerTheme.dart';
import './coustomIcon/toure_icons_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import './coustomIcon/loginicon_icons.dart';
import './pages/userprofile.dart';

class MyDrawer extends StatelessWidget {
  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Container(
      width: 250,
      decoration: BoxDecoration(
        color: Theme.of(context).appBarTheme.color,
      ),
      child: ListView(
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.only(left: 8, top: 10),
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      print('برگشت به صفحه نخست');
                      Navigator.pushNamed(context, '/homepage');
                    },
                    child: Container(
                      width: 68,
                      height: 68,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('images/logo.png'),
                              fit: BoxFit.fitHeight)),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'آژانس مسافرتی و گردشگری',
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w200,
                            color: Theme.of(context).cardColor),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'پارت ونک',
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).cardColor),
                      ),
                    ],
                  )
                ],
              )),
         
          //___________________________________شبکه های اجتماعی___________________________
          Container(
            margin: EdgeInsets.only(top: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: () => _launchURL('https://t.me/partvanak'),
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
                  onTap: () =>
                      _launchURL('https://www.instagram.com/partvanak.agency/'),
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
           //  ________________ مشخصات پروفایل یا ورود و ثبت نام______________
         UserProfile(),
          //______________________________تورها_________________________________
          Container(
            child: Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    GestureDetector(
                        onTap: () => Navigator.pushNamed(context, '/homepage'),
                        child: Container(
                          padding:
                              EdgeInsets.only(top: 15.0, left: 15, right: 20),
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Icon(
                                  Loginicon.home_outline,
                                  color: Theme.of(context).accentColor,
                                ),
                              ),
                              Text(
                                'صفحه اصلی',
                                style: DarwerThemeData.textTheme.title,
                              ),
                            ],
                          ),
                        )),
                    GestureDetector(
                        onTap: () =>
                            Navigator.pushNamed(context, '/foreigntourelist'),
                        child: Container(
                          padding:
                              EdgeInsets.only(top: 15.0, left: 15, right: 20),
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
                        onTap: () =>
                            Navigator.pushNamed(context, '/internaltourelist'),
                        child: Container(
                          padding:
                              EdgeInsets.only(top: 15.0, left: 15, right: 20),
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
                          padding:
                              EdgeInsets.only(top: 15.0, left: 15, right: 20),
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Icon(
                                  ToureIcons.tent,
                                  color: Theme.of(context)
                                      .accentColor
                                      .withOpacity(0.5),
                                ),
                              ),
                              Text(
                                'تور های طبیعتگردی',
                                style: DarwerThemeData.textTheme.title.copyWith(
                                    color: Colors.white.withOpacity(0.5)),
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
                          padding:
                              EdgeInsets.only(top: 15.0, left: 15, right: 20),
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Icon(
                                  ToureIcons.first_day,
                                  color: Theme.of(context)
                                      .accentColor
                                      .withOpacity(0.5),
                                ),
                              ),
                              Text(
                                'تور های یکروزه',
                                style: DarwerThemeData.textTheme.title.copyWith(
                                    color: Colors.white.withOpacity(0.5)),
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
                          padding:
                              EdgeInsets.only(top: 15.0, left: 15, right: 20),
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Icon(
                                  ToureIcons.crown_of_royal_design,
                                  color: Theme.of(context)
                                      .accentColor
                                      .withOpacity(0.5),
                                ),
                              ),
                              Text(
                                'تور های لاکچری',
                                style: DarwerThemeData.textTheme.title.copyWith(
                                    color: Colors.white.withOpacity(0.5)),
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
                          padding:
                              EdgeInsets.only(top: 15.0, left: 15, right: 20),
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Icon(
                                  ToureIcons.stopwatch,
                                  color: Theme.of(context)
                                      .accentColor
                                      .withOpacity(0.5),
                                ),
                              ),
                              Text(
                                'تور های لحظه آخری',
                                style: DarwerThemeData.textTheme.title.copyWith(
                                    color: Colors.white.withOpacity(0.5)),
                              ),
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
                    ),
                    //_________________________________اطلاعات_____________________________________
                    GestureDetector(
                        onTap: () =>
                            Navigator.pushNamed(context, '/flyinfoSite'),
                        child: Container(
                          padding:
                              EdgeInsets.only(top: 15.0, left: 15, right: 20),
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
                    // GestureDetector(
                    //     onTap: ()=>Navigator.pushNamed(context, '/tollpayment'),
                    //     child: Container(
                    //       padding:
                    //           EdgeInsets.only(top: 15.0, left: 15, right: 20),
                    //       child: Row(
                    //         children: <Widget>[
                    //           Padding(
                    //             padding: const EdgeInsets.only(left: 8.0),
                    //             child: Icon(
                    //               ToureIcons.passport_1,
                    //               color: Theme.of(context).accentColor,
                    //             ),)
                    //             ]
                    //         ),
                    //       )),
                    GestureDetector(
                        onTap: () {
                          print('پرداخت عوارض خروج');
                          Navigator.pushNamed(context, '/tollpayment');
                        },
                        child: Container(
                          padding:
                              EdgeInsets.only(top: 15.0, left: 15, right: 20),
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
                                'پرداخت عوارض خروج',
                                style: DarwerThemeData.textTheme.title,
                              ),
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
                    ),
                    //_________________________________درباره ما ، تماس با ما_____________________________________

                    GestureDetector(
                        onTap: () {
                          print('aboutus');
                          Navigator.pushNamed(context, '/aboutus');
                        },
                        child: Container(
                          padding:
                              EdgeInsets.only(top: 15.0, left: 15, right: 20),
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
                          padding:
                              EdgeInsets.only(top: 15.0, left: 15, right: 20),
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
                    //       GestureDetector(
                    //           onTap: () {
                    //             print('ورود');
                    //             Navigator.pushNamed(context, '/login');
                    //           },
                    //           child: Container(
                    //             padding:
                    // EdgeInsets.only(top: 15.0, left: 15, right: 20),
                    //             child: Row(
                    // children: <Widget>[
                    // Padding(
                    // padding: const EdgeInsets.only(left: 8.0),
                    // child: Icon(
                    //   Loginicon.account_circle,
                    //   color: Theme.of(context).accentColor,
                    // ),
                    // ),
                    // Text(
                    // 'ورود',
                    // style: DarwerThemeData.textTheme.title,
                    // )
                    // ],
                    //             ),
                    //           )),
                    //       GestureDetector(
                    //           onTap: () {
                    //             print('ثبت نام');
                    //             Navigator.pushNamed(context, '/register');
                    //           },
                    //           child: Container(
                    //             padding:
                    // EdgeInsets.only(top: 15.0, left: 15, right: 20),
                    //             child: Row(
                    // children: <Widget>[
                    // Padding(
                    // padding: const EdgeInsets.only(left: 8.0),
                    // child: Icon(
                    //  Loginicon.border_color,
                    //   color: Theme.of(context).accentColor,
                    // ),
                    // ),
                    // Text(
                    // 'ثبت نام',
                    // style: DarwerThemeData.textTheme.title,
                    // )
                    // ],
                    //             ),
                    //           )),
                    Container(
                      margin: EdgeInsets.only(top: 20, left: 15.0, right: 15),
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
    ));
  }
}
