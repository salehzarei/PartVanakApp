import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../model/toure_model.dart';
import '../toureDetile.dart';

class ToureTitle extends StatelessWidget {
  final Toure toure;

  const ToureTitle({Key key, this.toure}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ToureDetilePage(toure: toure))),
        borderRadius: BorderRadius.circular(25),
        child: Stack(
          textDirection: TextDirection.rtl,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                    height: 75,
                    width: 151,
                    // decoration: BoxDecoration(
                    //   borderRadius: BorderRadius.only(
                    //       topLeft: Radius.circular(8),
                    //       topRight: Radius.circular(8)),

                    // ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8)),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: toure.thumb,
                        placeholder: (context, url) => SpinKitFadingFour(
                              color: Colors.red,
                              size: 50.0,
                            ),
                        errorWidget: (context, string, url) =>
                            Icon(Icons.error),
                      ),
                    )),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: Text(
                    toure.vehicl_went,
                    style: Theme.of(context).textTheme.subtitle,
                    textAlign: TextAlign.right,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: Text(
                    toure.title,
                    style: Theme.of(context).textTheme.headline,
                    textAlign: TextAlign.right,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 45),
                  child: Text(
                    toure.sdate,
                    style: Theme.of(context).textTheme.subtitle,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  height: 27,
                  width: 150,
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8)),
                    color: Theme.of(context).accentColor,
                  ),
                  child: Text("${toure.price} ${toure.currency}",
                      style: TextStyle(fontSize: 14)),
                )
              ],
            ),
            Positioned(
                left: 3,
                top: 55,
                child: Card(
                  color: Colors.red,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      "${toure.nights} شب",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ))
          ],
        ));
  }
}
