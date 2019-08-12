import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import './coustomIcon/toure_icons_icons.dart';
import './drawer.dart';
import './UI/toureDetiles/hoteldetile.dart';
import './model/toure_model.dart';
import './UI/toureDetiles/detiles.dart';

class ToureDetilePage extends StatelessWidget {
  final Toure toure;
  const ToureDetilePage({Key key, this.toure}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          drawer: MyDrawer(),
          body: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                expandedHeight: 250,
                actions: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                    onPressed: () => Navigator.pop(context),
                  )
                ],
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text(toure.title),
                  background: ToureTitleBar(
                    toure: toure,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: <Widget>[
                    ExpansionTile(
                      title: Row(
                        children: <Widget>[
                          Container(
                            height: 20,
                            width: 5,
                            color: Theme.of(context).accentColor,
                          ),
                          SizedBox(width: 3,),
                          Text(
                            'مشاهده توضیحات تور',
                            style: TextStyle(fontSize: 13),
                          ),
                        ],
                      ),
                      backgroundColor: Colors.grey.shade100,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 15, left: 10, bottom: 10),
                          child: Text(
                            toure.desc,
                            textAlign: TextAlign.start,
                            textDirection: TextDirection.rtl,
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        'برای این تور ${toure.accommodation.length} محل اقامت موجود است',
                        style: Theme.of(context)
                            .textTheme
                            .title
                            .copyWith(color: Colors.grey, fontSize: 15),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return HotelDetiles(
                    hotel: toure.accommodation[index],
                    currency: toure.currency,
                    toure: toure,
                  );
                }, childCount: toure.accommodation.length),
              ),
            ],
          )),
    );
  }
}

class ToureTitleBar extends StatelessWidget {
  final Toure toure;
  const ToureTitleBar({Key key, this.toure}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Opacity(
            opacity: 0.25, child: Image.network(toure.pic, fit: BoxFit.cover)),
        Padding(
          padding: const EdgeInsets.only(top: 39),
          child: Column(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 80,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'مبدا',
                          style: TextStyle(
                              fontSize: 15,
                              color: Theme.of(context).accentColor),
                        ),
                        Text(
                          toure.source_title,
                          maxLines: 1,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).accentColor),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        color: Theme.of(context).accentColor,
                        height: 1,
                        width: 45,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: RotationTransition(
                          turns: AlwaysStoppedAnimation(-135 / 360),
                          child: Icon(
                            ToureIcons.airplane_flight,
                            size: 20,
                            color: Theme.of(context).accentColor,
                          ),
                        ),
                      ),
                      Container(
                        color: Theme.of(context).accentColor,
                        height: 1,
                        width: 45,
                      ),
                    ],
                  ),
                  Container(
                    width: 80,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'مقصد',
                          style: TextStyle(
                              fontSize: 15,
                              color: Theme.of(context).accentColor),
                        ),
                        Text(
                          toure.destination_title,
                          maxLines: 1,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).accentColor),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Text(
                toure.sdate,
                style: Theme.of(context)
                    .textTheme
                    .title
                    .copyWith(fontSize: 15, color: Colors.grey.shade200),
              ),
              SizedBox(
                height: 10,
              ),
              Detiles(toure: toure)
            ],
          ),
        )
      ],
    );
  }
}
