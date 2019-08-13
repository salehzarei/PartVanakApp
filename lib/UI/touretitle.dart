import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:scoped_model/scoped_model.dart';
import '../scoped_model.dart';
import '../model/toure_model.dart';
import '../toureDetile.dart';

class ToureTitle extends StatelessWidget {
  final Toure toure;

  const ToureTitle({Key key, this.toure}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (context, child, model) {
        return InkWell(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ToureDetilePage(toure: toure))),
            borderRadius: BorderRadius.circular(25),
            child: Stack(
              textDirection: TextDirection.rtl,
              alignment: Alignment.topCenter,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: Container(
                    height: 100,
                    width: 150,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(color: Colors.grey.shade300, blurRadius: 7)
                        ]),
                        child: Padding(
                          padding: const EdgeInsets.only(top:35.0 , right: 7),
                          child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                      Text(
                          toure.title,
                          maxLines: 1,
                          style: Theme.of(context).textTheme.subtitle,
                          textAlign: TextAlign.right,
                      ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                        'قیمت ${model.fixPrice(toure.price.toString())} تومان',
                        style: Theme.of(context).textTheme.headline,
                        textAlign: TextAlign.right,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                        toure.sdate,
                        style: Theme.of(context).textTheme.subtitle.copyWith(color: Colors.brown),
                    ),
                   
                  ],
                ),
                        ),
                  ),
                ),
                Container(
                    height: 130,
                    width: 130,
                    decoration: BoxDecoration(
                      boxShadow:  [
                          BoxShadow(color: Colors.grey.shade300, blurRadius: 7)
                        ]
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
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
                
                Positioned(
                    left: 3,
                    top: 10,
                    child: Card(
                      color: Colors.red,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          "${toure.nights} شب",
                          style: TextStyle(color: Colors.white , fontSize: 12),
                        ),
                      ),
                    ))
              ],
            ));
      },
    );
  }
}
