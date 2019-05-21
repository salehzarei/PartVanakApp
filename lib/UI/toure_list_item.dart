import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ToureListItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10)
      ),
    
      color: Colors.white,
      child: Row(
        textDirection: TextDirection.rtl,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
              flex: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child:CachedNetworkImage(
                  fit: BoxFit.cover,
                  height: 90,
                      imageUrl: 'https://i.onthebeach.co.uk/v1/hotel_images/79c9a56a-57bb-4d4e-aea3-4e5b7452b236/cover/1000/600/medium/1.0/rixos-downtown-antalya',
                      placeholder: (context, url) => SpinKitFadingFour(
                            color: Colors.red,
                            size: 50.0,
                          ),
                      errorWidget: (context, string, url) => Icon(Icons.error),
                    ),
              )),
          Expanded(
            flex: 2,
            child: ListView(
              padding: EdgeInsets.only(right: 10, top: 5),
              shrinkWrap: true,
              children: <Widget>[
                Text(
                  'تور کیش 7 روزه از مشهد ',
                  style: Theme.of(context).textTheme.headline,
                  softWrap: true,
                  textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  textDirection: TextDirection.rtl,
                  children: <Widget>[
                    Icon(
                      Icons.payment,
                      color: Theme.of(context).iconTheme.color,
                      size: 20,
                    ),
                    SizedBox(width: 5),
                    Text('قیمت 1.200.000 تومان')
                  ],
                ),
                Divider(
                  color: Theme.of(context).cardColor,
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  textDirection: TextDirection.rtl,
                  children: <Widget>[
                    Icon(
                      Icons.place,
                      color: Theme.of(context).iconTheme.color,
                      size: 20,
                    ),
                    Text('هتل 4 ستاره با صبحانه'),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.hotel,
                      color: Theme.of(context).iconTheme.color,
                      size: 20,
                    ),
                    SizedBox(width: 5),
                    Text('4 شب'),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
