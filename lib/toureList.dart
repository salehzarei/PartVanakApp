import 'package:flutter/material.dart';
import 'package:hello_flutter/UI/toure_list_item.dart';
import 'package:hello_flutter/drawer.dart';
import 'package:hello_flutter/scoped_model.dart';
import 'package:hello_flutter/toureDetile.dart';
import 'package:scoped_model/scoped_model.dart';

import 'model/toure_model.dart';

class ToureListPage extends StatefulWidget {
  final int toureType;

  const ToureListPage({Key key, this.toureType}) : super(key: key);
  @override
  _ToureListPageState createState() => _ToureListPageState();
}

class _ToureListPageState extends State<ToureListPage> {
  String _title;
  List<Toure> _toureList = [];

  @override
  void initState() {
    super.initState();

    MainModel model = ScopedModel.of(context);

    switch (widget.toureType.toString()) {
      case "1":
        {
          _title = 'لیست تورهای داخلی';
          model.tourelist.forEach((toure) {
            if (toure.foreign == 1) _toureList.add(toure);
          });
        }
        break;

      case "2":
        {
          _title = 'لیست تورهای خارجی';
          model.tourelist.forEach((toure) {
            if (toure.foreign == 2) _toureList.add(toure);
          });
        }
        break;
    }
  }

  makeList(List<Toure> toure) {
    return ListView.builder(
      itemCount: toure.length,
      padding: EdgeInsets.only(top: 50, left: 3, right: 3),
      itemBuilder: (context, index) {
        return GestureDetector(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ToureDetilePage(
                          toure: toure[index],
                        ))),
            child: ToureListItem(
              toure: toure[index],
            ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        drawer: MyDrawer(),
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            _title,
            style: Theme.of(context).textTheme.display2,
          ),
          iconTheme: Theme.of(context)
              .iconTheme
              .copyWith(color: Theme.of(context).accentColor),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_forward,
                  color: Theme.of(context).accentColor),
              onPressed: () => Navigator.pop(context),
            )
          ],
        ),
        body: Stack(
            // fit: StackFit.expand,
            textDirection: TextDirection.rtl,
            children: <Widget>[
              makeList(_toureList),
              Container(
                color: Colors.white,
                height: 45,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, right: 5),
                  child: Row(
                    textDirection: TextDirection.rtl,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text("فیلترکردن"),
                          Icon(Icons.filter_list),
                        ],
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Row(
                        children: <Widget>[
                          Text("مرتب سازی"),
                          Icon(Icons.sort),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ]),
      ),
    );
  }
}
