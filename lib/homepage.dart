import 'package:flutter/material.dart';
import 'package:hello_flutter/body.dart';
import 'package:hello_flutter/drawer.dart';
import 'package:hello_flutter/scoped_model.dart';
import 'package:url_launcher/url_launcher.dart';


class HomePage extends StatefulWidget {
  final MainModel model;
  const HomePage({Key key, this.model}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    widget.model.getTourData();
  }

_launchURL() async {
  const url = 'tel:+985137675030';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

  @override
  Widget build(BuildContext context) {
    return Container(
          child: Stack(
            textDirection: TextDirection.rtl,
            fit: StackFit.expand,
            children: <Widget>[
              Container(
                color: Colors.white,
              ),
              Directionality(
                textDirection: TextDirection.rtl,
                child: Scaffold(
                    backgroundColor: Colors.transparent,
                    appBar: AppBar(
                      
                      backgroundColor: Theme.of(context).appBarTheme.color,
                      iconTheme: Theme.of(context)
                          .iconTheme
                          .copyWith(color: Color(0xFFD8B945)),
                      elevation: 5.0,
                      actions: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 75,top:5),
                          child: Image.asset('images/logo.png',height: 50,color: Colors.white,),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: GestureDetector(
                            onTap: ()=>_launchURL(),
                            child: Container(
                            width: 125,
                            padding: EdgeInsets.only(left: 10, right: 10),
                            decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(15),
                                    topRight: Radius.circular(15))),
                            child: Row(
                              textDirection: TextDirection.rtl,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  '05137675030',
                                  style: Theme.of(context)
                                      .appBarTheme
                                      .textTheme
                                      .display1.copyWith(fontSize: 15),
                                ),
                                Icon(
                                  Icons.phone,
                                  size: 18,
                                  color: Theme.of(context).iconTheme.color,
                                ),
                              ],
                            ),
                          ),
                          )
                        )
                      ],
                    ),
                    drawer: MyDrawer(),
                    body: HomeBody()
                    ),
              )
            ],
          ),
        );
  }
}
