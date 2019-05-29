import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HotelDetile extends StatelessWidget {
  final double  margin=2.5;
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
            'مشخصات محل اقامت',
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
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                textDirection: TextDirection.rtl,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    textDirection: TextDirection.rtl,
                    children: <Widget>[
                      Text(
                        'هتل آنا کیش',
                        style: Theme.of(context)
                            .textTheme
                            .headline
                            .copyWith(fontSize: 15),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          textDirection: TextDirection.rtl,
                          children: <Widget>[
                            Icon(
                              Icons.star,
                              size: 15,
                              color: Colors.orange.shade300,
                            ),
                            Icon(
                              Icons.star,
                              size: 15,
                              color: Colors.orange.shade300,
                            ),
                            Icon(
                              Icons.star,
                              size: 15,
                              color: Colors.orange.shade300,
                            ),
                            Icon(
                              Icons.star_border,
                              size: 15,
                              color: Colors.orange.shade300,
                            ),
                            Icon(
                              Icons.star_border,
                              size: 15,
                              color: Colors.orange.shade300,
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
              // SingleChildScrollView(
              //   scrollDirection: Axis.horizontal,
              //                 child: Row(
              //     children: <Widget>[
              //       Column(
              //         children: <Widget>[
              //           Container(
              //             color: Colors.grey.shade300,
              //             alignment: Alignment.center,
              //             height: 30,
              //             child: Text('یک تخته',
              //                 style: TextStyle(
              //                     color: Theme.of(context).primaryColor)),
              //           ),
              //           Container(
              //             color: Theme.of(context).primaryColor,
              //             alignment: Alignment.center,
              //             height: 30,
              //             child: Text('989.000 تومان',
              //                 textDirection: TextDirection.rtl,
              //                 style: TextStyle(color: Colors.white)),
              //           ),
              //         ],
              //       ),
              //       Column(
              //         children: <Widget>[
              //           Container(
              //             color: Colors.grey.shade300,
              //             alignment: Alignment.center,
              //             height: 30,
              //             child: Text('دو تخته',
              //                 style: TextStyle(
              //                     color: Theme.of(context).primaryColor)),
              //           ),
              //           Container(
              //             color: Theme.of(context).primaryColor,
              //             alignment: Alignment.center,
              //             height: 30,
              //             child: Text('989.000 تومان',
              //                 textDirection: TextDirection.rtl,
              //                 style: TextStyle(color: Colors.white)),
              //           ),
              //         ],
              //       ),
              //       Column(
              //         children: <Widget>[
              //           Container(
              //             color: Colors.grey.shade300,
              //             alignment: Alignment.center,
              //             height: 30,
              //             child: Text('سه تخته',
              //                 style: TextStyle(
              //                     color: Theme.of(context).primaryColor)),
              //           ),
              //           Container(
              //             color: Theme.of(context).primaryColor,
              //             alignment: Alignment.center,
              //             height: 30,
              //             child: Text('989.000 تومان',
              //                 textDirection: TextDirection.rtl,
              //                 style: TextStyle(color: Colors.white)),
              //           ),
              //         ],
              //       ),
              //       Column(
              //         children: <Widget>[
              //           Container(
              //             color: Colors.grey.shade300,
              //             alignment: Alignment.center,
              //             height: 30,
              //             child: Text('کودک',
              //                 style: TextStyle(
              //                     color: Theme.of(context).primaryColor)),
              //           ),
              //           Container(
              //             color: Theme.of(context).primaryColor,
              //             alignment: Alignment.center,
              //             height: 30,
              //             child: Text('989.000 تومان',
              //                 textDirection: TextDirection.rtl,
              //                 style: TextStyle(color: Colors.white)),
              //           ),
              //         ],
              //       ),
              //       Expanded(
              //         flex: 1,
              //         child: Column(
              //           children: <Widget>[
              //             Container(
              //               color: Colors.grey.shade300,
              //               alignment: Alignment.center,
              //               height: 30,
              //               child: Text('بزرگسال',
              //                   style: TextStyle(
              //                       color: Theme.of(context).primaryColor)),
              //             ),
              //             Container(
              //               color: Theme.of(context).primaryColor,
              //               alignment: Alignment.center,
              //               height: 30,
              //               child: Text('989.000 تومان',
              //                   textDirection: TextDirection.rtl,
              //                   style: TextStyle(color: Colors.white)),
              //             ),
              //           ],
              //         ),
              //       ),
              //     ],
              //   ),
              // ),

              Container(
                margin: EdgeInsets.symmetric(vertical: 20.0),
                height: 70.0,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    Wrap(
                      direction: Axis.vertical,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left:margin , right: margin),
                           width: 160.0,
                          color: Colors.grey.shade300,
                          alignment: Alignment.center,
                          height: 30,
                          child: Text('دو تخته',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor)),
                        ),
                        Container(
                           margin: EdgeInsets.only(left: margin,right: margin),
                          color: Theme.of(context).primaryColor,
                          alignment: Alignment.center,
                          height: 30,
                          width: 160.0,
                          child: Text('989.000 تومان',
                              textDirection: TextDirection.rtl,
                              style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                    Wrap(
                      direction: Axis.vertical,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: margin,right: margin),
                           width: 160.0,
                          color: Colors.grey.shade300,
                          alignment: Alignment.center,
                          height: 30,
                          child: Text('دو تخته',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor)),
                        ),
                        Container(
                           margin: EdgeInsets.only(left: margin,right: margin),
                          color: Theme.of(context).primaryColor,
                          alignment: Alignment.center,
                          height: 30,
                          width: 160.0,
                          child: Text('989.000 تومان',
                              textDirection: TextDirection.rtl,
                              style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                     Wrap(
                      direction: Axis.vertical,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: margin,right: margin),
                           width: 160.0,
                          color: Colors.grey.shade300,
                          alignment: Alignment.center,
                          height: 30,
                          child: Text('دو تخته',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor)),
                        ),
                        Container(
                           margin: EdgeInsets.only(left: margin,right: margin),
                          color: Theme.of(context).primaryColor,
                          alignment: Alignment.center,
                          height: 30,
                          width: 160.0,
                          child: Text('3.000.000.000 تومان',
                              textDirection: TextDirection.rtl,
                              style: TextStyle(color: Colors.white)),
                        ),
                      ],
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
