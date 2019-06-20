import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hello_flutter/drawer.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import '../model/accommodation_model.dart';
import '../model/toure_model.dart';

import '../buyticket.dart';

class HotelPage extends StatelessWidget {
  final Toure toure;
  final Accommodation hotel;
  const HotelPage({Key key, this.hotel, this.toure}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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

    Map<String, String> images = {
      '1': toure.pic,
      '2': toure.pic,
      '3': toure.pic,
      '4': toure.pic,
    };

    void _showModalSheet() {
      showModalBottomSheet(
          context: context,
          builder: (builder) {
            return Material(child: BuyTicket());
          });
    }

    return Stack(
      children: <Widget>[
        Container(
          color: Colors.white,
        ),
        Container(
          height: 280,
          width: MediaQuery.of(context).size.width,
          // child: PhotoViewGallery.builder(
          //   scrollPhysics: BouncingScrollPhysics(),
          //   builder: (context, index) {
          //     return PhotoViewGalleryPageOptions(
          //         imageProvider:
          //             NetworkImage(images.values.elementAt(index)),
          //         initialScale: PhotoViewComputedScale.contained * 0.8,
          //         heroTag: images.keys.elementAt(index));
          //   },
          //   itemCount: images.length,
          //   backgroundDecoration: BoxDecoration(color: Colors.white),
          // ),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(toure.pic), fit: BoxFit.cover)),
        ),
        Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
              backgroundColor: Colors.transparent,
              bottomNavigationBar: MaterialButton(
                onPressed: _showModalSheet,
                minWidth: 200,
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  'رزرو تور',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                elevation: 2,
                color: Theme.of(context).accentColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
              ),
              drawer: MyDrawer(),
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                actions: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.arrow_forward,
                    ),
                    onPressed: () => Navigator.pop(context),
                  )
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.only(top: 200),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('${hotel.title} ${hotel.hotel_title}',
                                  style: Theme.of(context).textTheme.title),
                              SizedBox(
                                height: 5,
                              ),
                              makeStar(hotel.accommodation_type)
                            ],
                          ),
                          FlatButton(
                            child: Column(
                              children: <Widget>[
                                Icon(
                                  Icons.map,
                                  color: Colors.redAccent,
                                ),
                                Text(
                                  'مسیریابی',
                                  style: TextStyle(
                                      color: Colors.redAccent, fontSize: 11),
                                )
                              ],
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Divider(
                        height: 3,
                        color: Colors.grey,
                      ),
                    ),
                    Card(
                      color: Colors.grey.shade200,
                                          child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Icon(Icons.wifi),
                            Icon(Icons.map),
                            Icon(Icons.fastfood),
                            Icon(Icons.camera_alt),
                            Icon(
                              Icons.more_vert,
                              color: Colors.grey,
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Divider(
                        height: 3,
                        color: Colors.grey,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('توضحیات هتل',
                              style: Theme.of(context).textTheme.subtitle),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                              'متن زیابدی ببایتنسیتدبنتیدکرتبدینترنیدکبترتینبدریدبرکیکن تنتددتتنکدنبتیربتندیتردبنتیدنتبیدبترنیبتدنتیبتبدنتتب'),
                        ],
                      ),
                    )
                  ],
                ),
              )),
        ),
      ],
    );
  }
}
