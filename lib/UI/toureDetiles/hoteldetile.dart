import 'package:flutter/material.dart';
import '../../model/toure_model.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../model/accommodation_model.dart';
import '../../scoped_model.dart';
import '../../buyticket.dart';
import '../../coustomIcon/toure_icons_icons.dart';

class HotelDetiles extends StatelessWidget {
  final Accommodation hotel;
  final Toure toure;
  final String currency;
  const HotelDetiles({Key key, this.hotel, this.currency, this.toure})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ///// دخیره آیدی تور به صورت موقت در اسکوپ مدل
    MainModel _model = ScopedModel.of(context);
    _model.tmpCartData['ToureID'] = toure.id.toString();

    void _showModalSheet() {
      showModalBottomSheet(
          context: context,
          builder: (builder) {
            return Material(
              child: BuyTicket(
                hotel: hotel,
                toureCapacity: toure.capacity,
              ),
              color: Theme.of(context).canvasColor,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(25), topLeft: Radius.circular(25)),
            );
          });
    }

    return GestureDetector(
      onTap: () {
        if (_model.userToken != null) {
          _showModalSheet();
        } else
          _model.ackAlert(context,
              massage:
                  'برای خرید تور از این اپلیکیشن ابتدا باید وارد سیستم شوید',
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
                    flex: 2,
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
                      child: FlatButton.icon(
                        textColor: Theme.of(context).buttonColor,
                        icon: Icon(
                          Icons.info_outline,
                          size: 15,
                        ),
                        label: Text(
                          'خدمات تور',
                          style: TextStyle(fontSize: 12),
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (_) => FunkyOverlay(hotel: hotel),
                          );
                        },
                      ))
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

class FunkyOverlay extends StatefulWidget {
  final Accommodation hotel;

  const FunkyOverlay({Key key, this.hotel}) : super(key: key);
  @override
  State<StatefulWidget> createState() => FunkyOverlayState();
}

class FunkyOverlayState extends State<FunkyOverlay>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Center(
        child: Material(
          color: Colors.transparent,
          child: ScaleTransition(
            scale: scaleAnimation,
            child: Container(
              width: 300,
              height: 260,
              decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0))),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Text('خدمات این تور' , style: Theme.of(context).textTheme.title,),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 20),
                    child: SizedBox(
                      height: 160,
                      child: ListView(
                        children: widget.hotel.specification
                            .map((item) => Padding(
                                  padding: EdgeInsets.only(bottom: 10),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Icon(
                                        Icons.check,
                                        size: 20,
                                        color: Theme.of(context).buttonColor,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Flexible(
                                        child: Text(
                                          item,
                                        ),
                                      ),
                                    ],
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
