import 'package:flutter/material.dart';
import 'package:hello_flutter/UI/toure_list_item.dart';
import 'package:hello_flutter/scoped_model.dart';
import 'package:hello_flutter/toureDetile.dart';
import 'package:scoped_model/scoped_model.dart';

class ToureListPage extends StatefulWidget {
  @override
  _ToureListPageState createState() => _ToureListPageState();
}

class _ToureListPageState extends State<ToureListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("لیست تورهای خارجی"),
      ),
      body: Stack(
          // fit: StackFit.expand,
          textDirection: TextDirection.rtl,
          children: <Widget>[
            ScopedModelDescendant<MainModel>(
              builder: (context, child, model) {
                return ListView.builder(
                  itemCount: model.foreign.length,
                  padding: EdgeInsets.only(top: 50, left: 3, right: 3),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ToureDetilePage(
                                      toure: model.foreign[index],
                                    ))),
                        child: ToureListItem(
                          toure: model.foreign[index],
                        ));
                  },
                );
              },
            ),
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
    );
  }
}
