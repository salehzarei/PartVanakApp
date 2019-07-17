import 'package:flutter/material.dart';
import '../drawer.dart';

class NewsList extends StatelessWidget {
  final double _name = 45;
  makeList() {
    return ListView.builder(
        itemCount: 4,
        padding: EdgeInsets.only(top: 50, left: 10, right: 10, bottom: 10),
        itemBuilder: (context, index) {
          return Column(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/contact');
                },
                child: Card(
                  color: Colors.white30,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Stack(
                        alignment: AlignmentDirectional.bottomStart,
                        children: <Widget>[
                          Image.asset(
                            'images/air.jpg',
                            fit: BoxFit.cover,
                          ),
                          ListTile(
                            title: Text(
                              'پیتزا مخلوط',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 24.0),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: Text(
                            'توضیح درباره عکس توضیح درباره عکس  توضیح درباره عکس  توضیح درباره عکس '),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ButtonTheme.bar(
                        child: ButtonBar(
                          alignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text('بازدید کل'),
                                IconButton(
                                  icon: Icon(
                                    Icons.visibility,
                                    color: Colors.black,
                                  ),
                                  onPressed: () {},
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Text('98/4/24'),
                                IconButton(
                                  icon: Icon(
                                    Icons.calendar_today,
                                    color: Colors.black,
                                  ),
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            drawer: MyDrawer(),
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                'لیست اخبار سایت',
                style: Theme.of(context).textTheme.display2,
              ),
              iconTheme: Theme.of(context)
                  .iconTheme
                  .copyWith(color: Theme.of(context).accentColor),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.arrow_forward,
                      color: Theme.of(context).accentColor),
                  onPressed: () => Navigator.pop(context),
                )
              ],
            ),
            body: Stack(textDirection: TextDirection.rtl, children: <Widget>[
              makeList(),
              // Container(
              //   color: Colors.white,
              //   height: _name,
              //   child: Padding(
              //     padding: const EdgeInsets.only(top: 10, right: 5),
              //     child: Row(
              //       textDirection: TextDirection.rtl,
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       mainAxisAlignment: MainAxisAlignment.start,
              //       children: <Widget>[
              //         GestureDetector(
              //           onTap: () {

              //             _groupinglist();

              //           },
              //           child: Row(
              //             children: <Widget>[
              //               Text("دسته بندی"),
              //               Icon(Icons.filter_list),
              //             ],
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(top: 5, right: 10),
                  child: Row(
                    children: <Widget>[
                      Text('دسته بندی'),
                      PopupMenuButton<String>(
                        icon: Icon(Icons.filter_list),
                        onSelected: choiceAction,
                        itemBuilder: (BuildContext context) {
                          return Constants.choices.map((String choice) {
                            return PopupMenuItem<String>(
                              value: choice,
                              child: Text(
                                choice,
                                style: TextStyle(color: Colors.black),
                              ),
                            );
                          }).toList();
                        },
                      ),
                    ],
                  ),
                ),
              )
            ]),
          ),
        ),
      ],
    );
  }

  //https://github.com/best-flutter/flutter_dropdown_menu
}

class Constants {
  static const String Item1 = 'کلیک 1';
  static const String Item2 = 'کلیک 2';
  static const String Item3 = 'کلیک 3';
  static const String Item4 = 'کلیک 4';
  static const String Item5 = 'کلیک 5';
  static const String Item6 = 'کلیک 6';
  static const String Item7 = 'کلیک 7';
  static const String Item8 = 'کلیک 8';
  static const String Item9 = 'کلیک 9';
  static const String Item10 = 'کلیک 10';

  static const List<String> choices = <String>[
    Item1,
    Item2,
    Item3,
    Item4,
    Item5,
    Item6,
    Item7,
    Item8,
    Item9,
    Item10,
  ];
}

void choiceAction(String choice) {
  if (choice == Constants.Item1) {
    print('لینک اول');
  } else if (choice == Constants.Item2) {
    print('لینک دوم');
  } else if (choice == Constants.Item3) {
    print('لینک سوم');
  } else if (choice == Constants.Item4) {
    print('لینک چهارم');
  } else if (choice == Constants.Item5) {
    print('لینک پنجم');
  } else if (choice == Constants.Item6) {
    print('لینک ششم');
  } else if (choice == Constants.Item7) {
    print('لینک هفتم');
  } else if (choice == Constants.Item8) {
    print('لینک هشتم');
  } else if (choice == Constants.Item9) {
    print('لینک نهم');
  } else if (choice == Constants.Item10) {
    print('لینک دهم');
  }
}
