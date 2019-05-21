import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ToureDetilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('جزئیات تور'),
        centerTitle: true,
      ),
      body: Stack(
        textDirection: TextDirection.rtl,
        children: <Widget>[
          SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    CachedNetworkImage(
                      imageUrl: 'https://i.onthebeach.co.uk/v1/hotel_images/79c9a56a-57bb-4d4e-aea3-4e5b7452b236/cover/1000/600/medium/1.0/rixos-downtown-antalya',
                      placeholder: (context, url) => SpinKitFadingFour(
                            color: Colors.red,
                            size: 50.0,
                          ),
                      errorWidget: (context, string, url) => Icon(Icons.error),
                    ),
                  ],
                )),
          ),
          Container(
            height: 45,
            child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  'تور مشهد به تبریز 7 روزه',
                  style: Theme.of(context).textTheme.title,
                  textAlign: TextAlign.center,
                )),
          ),
        ],
      ),
    );
  }
}
