import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import './model/tourefilter_model.dart';
import './drawer.dart';
import './UI/divider.dart';
import './UI/maincategorei.dart';
import './UI/toure_scroll_title.dart';
import './UI/special_toure_scroll_title.dart';
import './scoped_model.dart';
import './model/toure_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int categoryindex = 0;
 List<Toure> _specialtoure = [];

@override
  void initState() {
      super.initState();
      
MainModel model = ScopedModel.of(context);
    ToureFilterModel sfilter = ToureFilterModel(
        foreign: model.touretypes[4]['foregin'],
        special: model.touretypes[4]['special']);
    fetchList(model, sfilter);
  }

  Future fetchList(MainModel model, ToureFilterModel filter) async {
    _specialtoure = await model.getTourData(filter: filter);
    setState(() {
    _specialtoure = _specialtoure;
    });
    print("fetcheed special tour is  : ${_specialtoure.length}");
  }

  @override
  Widget build(BuildContext context) {
    print("special tour is  : ${_specialtoure.length}");
    return Container(
      child: Stack(
        textDirection: TextDirection.rtl,
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            color: Colors.grey.shade200,
          ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  iconTheme: Theme.of(context)
                      .iconTheme
                      .copyWith(color: Color(0xFFD8B945)),
                  elevation: 0.0,
                  actions: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 7, top: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            'پارت ونک',
                            style: TextStyle(
                                color: Color(0xFFD8B945),
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          SizedBox(height: 3),
                          Text(
                            'آژانس مسافرتی و گردشگری',
                            style: TextStyle(
                                color: Colors.brown.shade400,
                                fontWeight: FontWeight.bold,
                                fontSize: 11),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 7, top: 5),
                      child: Image.asset(
                        'images/logo.png',
                        height: 50,
                      ),
                    ),
                  ],
                ),
                drawer: MyDrawer(),
                body: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Column(
                    children: <Widget>[
                      HomeCategorei(tapedcategory: (index) {
                        setState(() {
                          categoryindex = index;
                        });
                      }),
                      Container(
                        height: MediaQuery.of(context).size.height - 198,
                        child: ListView(
                          children: <Widget>[
                            CatDivider(
                              toureTypeindex: categoryindex,
                            ),
                           ToureScrollTitle(toureTypeindex: categoryindex),
                             CatDivider(
                              toureTypeindex: 4,
                            ),
                            SpecialToureScrollTitle(specialtours: _specialtoure),
                          ],
                        ),
                      ),
                     
                    ],
                  ),
                )),
          )
        ],
      ),
    );
  }
}
