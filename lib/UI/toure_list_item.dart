import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

import '../model/toure_model.dart';

class ToureListItem extends StatelessWidget {
  final Toure toure;

  const ToureListItem({Key key, this.toure}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// پکیج تبدیل قیمت به نقاط هزارگان
    var price = MoneyMaskedTextController(
        precision: 0,
        thousandSeparator: '.',
        decimalSeparator: '',
        initialValue: double.parse(toure.price.toString()));

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: Colors.white,
      child: Row(
        textDirection: TextDirection.rtl,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
              flex: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  height: 90,
                  imageUrl: toure.thumb,
                  placeholder: (context, url) => SpinKitFadingFour(
                    color: Colors.red,
                    size: 50.0,
                  ),
                  errorWidget: (context, string, url) => Icon(Icons.error),
                ),
              )),
          Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.only(right: 8, top: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '${toure.title}',
                      style: Theme.of(context).textTheme.headline,
                      softWrap: true,
                      textAlign: TextAlign.right,
                      textDirection: TextDirection.rtl,
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      textDirection: TextDirection.rtl,
                      children: <Widget>[
                        Icon(
                          Icons.monetization_on,
                          color: Theme.of(context).iconTheme.color,
                          size: 15,
                        ),
                        SizedBox(width: 2),
                        Text('قیمت ${price.text} ${toure.currency}')
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
                          Icons.calendar_today,
                          color: Theme.of(context).iconTheme.color,
                          size: 15,
                        ),
                        SizedBox(width: 2),
                        Text('${toure.sdate}'),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.hotel,
                          color: Theme.of(context).iconTheme.color,
                          size: 15,
                        ),
                        SizedBox(width: 2),
                        Text(
                          '${toure.nights} شب ${toure.days} روز',
                          textDirection: TextDirection.rtl,
                        ),
                      ],
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
