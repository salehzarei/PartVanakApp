import 'package:flutter/material.dart';
import 'package:hello_flutter/UI/hotel.dart';
import 'package:hello_flutter/coustomIcon/toure_icons_icons.dart';
import '../../model/accommodation_model.dart';
import '../../model/toure_model.dart';

// class HotelDetile extends StatelessWidget {
//   final Toure toure;

//   const HotelDetile({Key key, this.toure}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       mainAxisAlignment: MainAxisAlignment.center,
//       mainAxisSize: MainAxisSize.min,
//       children: <Widget>[
//         Padding(
//           padding: const EdgeInsets.symmetric(vertical: 5),
//           child: Text(
//             'مشخصات ${toure.accommodation.length} محل اقامت برای این تور',
//             style: Theme.of(context).textTheme.title.copyWith(fontSize: 17),
//           ),
//         ),
//         Padding(
//           padding: EdgeInsets.all(8),
//           child: ListView.builder(
//             itemCount: toure.accommodation.length,
//             shrinkWrap: true,
//             // ضروری است
//             physics: ClampingScrollPhysics(),
//             scrollDirection: Axis.vertical,
//             itemBuilder: (context, index) {
//               return HotelDetiles(
//                 hotel: toure.accommodation[index],
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }

class HotelDetiles extends StatelessWidget {
  final Accommodation hotel;
  const HotelDetiles({Key key, this.hotel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double margin = 2.5;

    makeStar(int type) {
      List<Widget> starIconList = [];
      for (int i = 1; i < 6; i++) {
        if (type > 0) {
          starIconList.add(Icon(
            Icons.star,
            size: 15,
            color: Colors.orange.shade300,
          ));
          type--;
        } else
          starIconList.add(
            Icon(
              Icons.star_border,
              size: 15,
              color: Colors.orange.shade300,
            ),
          );
      }
      return starIconList;
    }

    return GestureDetector(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => HotelPage())),
      child: Card(
        color: Colors.grey.shade100,
        child: Padding(
          padding: const EdgeInsets.all(5),
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
                        '${hotel.title} ${hotel.hotel_title}',
                        style: Theme.of(context)
                            .textTheme
                            .headline
                            .copyWith(fontSize: 15),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          textDirection: TextDirection.rtl,
                          children: makeStar(hotel.accommodation_type),
                        ),
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    textDirection: TextDirection.rtl,
                    children: <Widget>[
                      SizedBox(
                        width: 25,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          textDirection: TextDirection.rtl,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(ToureIcons.coffee_cup ,size: 15,),
                            VerticalDivider(),
                            Text('شهر گردی'),
                            VerticalDivider(),
                            Text('بیمه'),
                            VerticalDivider(),
                            Text('صبحانه'),


                          ]
                        ),
                      )
                    ],
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 0),
                height: 70.0,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    Wrap(
                      direction: Axis.vertical,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: margin, right: margin),
                          width: 160.0,
                          color: Colors.grey.shade300,
                          alignment: Alignment.center,
                          height: 30,
                          child: Text('قیمت تک نفر',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor)),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: margin, right: margin),
                          color: Theme.of(context).primaryColor,
                          alignment: Alignment.center,
                          height: 30,
                          width: 160.0,
                          child: Text('1,340,000 تومان',
                              textDirection: TextDirection.rtl,
                              style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                    Wrap(
                      direction: Axis.vertical,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: margin, right: margin),
                          width: 160.0,
                          color: Colors.grey.shade300,
                          alignment: Alignment.center,
                          height: 30,
                          child: Text('قیمت بزرگسال ',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor)),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: margin, right: margin),
                          color: Theme.of(context).primaryColor,
                          alignment: Alignment.center,
                          height: 30,
                          width: 160.0,
                          child: Text('1,340,000 تومان',
                              textDirection: TextDirection.rtl,
                              style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                    Wrap(
                      direction: Axis.vertical,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: margin, right: margin),
                          width: 160.0,
                          color: Colors.grey.shade300,
                          alignment: Alignment.center,
                          height: 30,
                          child: Text('قیمت کودک',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor)),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: margin, right: margin),
                          color: Theme.of(context).primaryColor,
                          alignment: Alignment.center,
                          height: 30,
                          width: 160.0,
                          child: Text('1,340,000 تومان',
                              textDirection: TextDirection.rtl,
                              style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                    Wrap(
                      direction: Axis.vertical,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: margin, right: margin),
                          width: 160.0,
                          color: Colors.grey.shade300,
                          alignment: Alignment.center,
                          height: 30,
                          child: Text('قیمت کودک با تخت',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor)),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: margin, right: margin),
                          color: Theme.of(context).primaryColor,
                          alignment: Alignment.center,
                          height: 30,
                          width: 160.0,
                          child: Text('1,340,000 تومان',
                              textDirection: TextDirection.rtl,
                              style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                    Wrap(
                      direction: Axis.vertical,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: margin, right: margin),
                          width: 160.0,
                          color: Colors.grey.shade300,
                          alignment: Alignment.center,
                          height: 30,
                          child: Text('قیمت نوزاد',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor)),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: margin, right: margin),
                          color: Theme.of(context).primaryColor,
                          alignment: Alignment.center,
                          height: 30,
                          width: 160.0,
                          child: Text('240,000 تومان',
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
      ),
    );
  }
}
