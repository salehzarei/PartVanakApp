import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../model/accommodation_model.dart';
import '../../scoped_model.dart';
import '../../buyticket.dart';
import '../../coustomIcon/toure_icons_icons.dart';

class HotelDetiles extends StatelessWidget {
  final Accommodation hotel;
  final String currency, toureId;
  const HotelDetiles({Key key, this.hotel, this.currency, this.toureId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ///// دخیره آیدی تور به صورت موقت در اسکوپ مدل
    MainModel _model = ScopedModel.of(context);
    _model.tmpCartData['ToureID'] = toureId;

    void _showModalSheet() {
      showModalBottomSheet(
          context: context,
          builder: (builder) {
            return Material(
              child: BuyTicket(hotel: hotel),
              color: Theme.of(context).canvasColor,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(25), topLeft: Radius.circular(25)),
            );
          });
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
      onTap: () {
        if (_model.userToken != null) {
          _showModalSheet();
        } else
          _model.ackAlert(context,
              massage: 'برای خرید تور از این اپلیکیشن ابتدا باید وارد سیستم شوید',
              route: '/login');
      },
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
                          child: _model.makeStar(hotel.accommodation_type),
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
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      PriceBox(
                        price: _model.fixPrice(hotel.singel_price.toString()),
                        currency: currency,
                        title: 'تک نفر',
                      ),
                      PriceBox(
                        price: _model.fixPrice(hotel.adult_price.toString()),
                        currency: currency,
                        title: 'بزرگسال',
                      ),
                      PriceBox(
                        price:
                            _model.fixPrice(hotel.child_price_bed.toString()),
                        currency: currency,
                        title: 'کودک با تخت',
                      ),
                      PriceBox(
                        price: _model.fixPrice(hotel.child_price.toString()),
                        currency: currency,
                        title: 'کودک بدون تخت',
                      ),
                      PriceBox(
                        price: _model.fixPrice(hotel.baby_price.toString()),
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
  final String price;
  const PriceBox({Key key, this.price, this.title, this.currency})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double margin = 2.5;
    return Wrap(
      direction: Axis.vertical,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: margin, right: margin),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8), topRight: Radius.circular(8)),
            color: Colors.grey.shade300,
          ),
          width: 120.0,
          alignment: Alignment.center,
          height: 20,
          child: Text(title,
              style: TextStyle(color: Theme.of(context).primaryColor)
                  .copyWith(fontSize: 12)),
        ),
        Container(
          margin: EdgeInsets.only(left: margin, right: margin),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8)),
            color: Theme.of(context).primaryColor,
          ),
          alignment: Alignment.center,
          height: 25,
          width: 120.0,
          child: Text('$price $currency',
              textDirection: TextDirection.rtl,
              style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
