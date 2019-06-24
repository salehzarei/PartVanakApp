import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hello_flutter/model/accommodation_model.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:hello_flutter/scoped_model.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../UI/hotel.dart';
import '../../coustomIcon/toure_icons_icons.dart';

class HotelDetiles extends StatelessWidget {
  final Accommodation hotel;
  final String currency, toureId;
  const HotelDetiles({Key key, this.hotel, this.currency, this.toureId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {


    ///// دخیره آی تور به صورت موقت در اسکوپ مدل
    MainModel _model = ScopedModel.of(context);
    _model.tmpCartData['ToureID'] = toureId;
    ///////

    /// ساخت ستاره هتل ها
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
      return Row(
        children: starIconList,
        textDirection: TextDirection.rtl,
      );
    }

    specification(List<dynamic> hotelSpecification) {
      List<Widget> specificationList = [];
      specificationList.add(Icon(
        ToureIcons.coffee_cup,
        size: 13,
      ));
      hotelSpecification.forEach((item) {
        specificationList.add(Container(
          height: 10,
          width: 1,
          color: Colors.grey.shade400,
          margin: EdgeInsets.all(2),
        ));
        specificationList.add(Text(item, style: TextStyle(fontSize: 12)));
      });

      return specificationList;
    }

    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => HotelPage(
                    hotel: hotel,
                  ))),
      child: Card(
        color: Colors.grey.shade200,
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            children: <Widget>[
              Row(
                textDirection: TextDirection.rtl,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      textDirection: TextDirection.rtl,
                      children: <Widget>[
                        Text(
                          '${hotel.hotel_title} ',
                          style: Theme.of(context)
                              .textTheme
                              .headline
                              .copyWith(fontSize: 15),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: makeStar(hotel.accommodation_type),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            textDirection: TextDirection.rtl,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: specification(hotel.specification),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              Container(
                  margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 0),
                  height: 50.0,
                  width: MediaQuery.of(context).size.width - 20,
                  child: CarouselSlider(
                    viewportFraction: 0.35,
                    enableInfiniteScroll: false,
                    initialPage: 1,
                    realPage: 5,
                    items: <Widget>[
                      PriceBox(
                        price: hotel.singel_price,
                        currency: currency,
                        title: 'تک نفر',
                      ),
                      PriceBox(
                        price: hotel.adult_price,
                        currency: currency,
                        title: 'بزرگسال',
                      ),
                      PriceBox(
                        price: hotel.child_price_bed,
                        currency: currency,
                        title: 'کودک با تخت',
                      ),
                      PriceBox(
                        price: hotel.child_price,
                        currency: currency,
                        title: 'کودک بدون تخت',
                      ),
                      PriceBox(
                        price: hotel.baby_price,
                        currency: currency,
                        title: 'نوزاد',
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class PriceBox extends StatelessWidget {
  final String title;
  final String currency;
  final int price;
  const PriceBox({Key key, this.price, this.title, this.currency})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double margin = 2.5;

    /// تبدیل عدد به قیمت با اعشار
    fixPrice(int hotelprice) {
      var price = MoneyMaskedTextController(
          precision: 0,
          thousandSeparator: '.',
          decimalSeparator: '',
          initialValue: double.parse(hotelprice.toString()));

      return price;
    }

    return Wrap(
      direction: Axis.vertical,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: margin, right: margin),
          width: 120.0,
          color: Colors.grey.shade300,
          alignment: Alignment.center,
          height: 25,
          child: Text(title,
              style: TextStyle(color: Theme.of(context).primaryColor)),
        ),
        Container(
          margin: EdgeInsets.only(left: margin, right: margin),
          color: Theme.of(context).primaryColor,
          alignment: Alignment.center,
          height: 25,
          width: 120.0,
          child: Text('${fixPrice(price).text} $currency',
              textDirection: TextDirection.rtl,
              style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
