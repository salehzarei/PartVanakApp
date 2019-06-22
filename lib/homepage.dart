import 'package:flutter/material.dart';
import 'package:hello_flutter/body.dart';
import 'package:hello_flutter/drawer.dart';
import 'package:hello_flutter/scoped_model.dart';


class HomePage extends StatefulWidget {
  final MainModel model;
  const HomePage({Key key, this.model}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // @override
  // void initState() {
  //   super.initState();
  //   widget.model.getTourData();
  // }

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
                          padding: const EdgeInsets.only(left: 60,top:5),
                          child: Image.asset('images/logo.png',height: 50,color: Theme.of(context).accentColor,),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8, bottom: 8),
                          child: Container(
                            height: 5,
                            width: 143,
                            padding: EdgeInsets.only(left: 10, right: 12),
                            decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(15),
                                    topRight: Radius.circular(15))),
                            child: Row(
                              textDirection: TextDirection.rtl,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  '09154127181',
                                  style: Theme.of(context)
                                      .appBarTheme
                                      .textTheme
                                      .display1,
                                ),
                                Icon(
                                  Icons.phone,
                                  color: Theme.of(context).iconTheme.color,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    drawer: MyDrawer(),
                    body: HomeBody()

                    // LayoutBuilder(
                    //   builder: (BuildContext context , BoxConstraints viewportConstraints){
                    //     return SingleChildScrollView(
                    //       child: ConstrainedBox(
                    //         constraints: BoxConstraints(
                    //           minHeight: viewportConstraints.minHeight
                    //         ),
                    //         child: HomeBody()
                    //       ),
                    //     );
                    //   },
                    // )
                    ),
              )
            ],
          ),
        );
  }
}
