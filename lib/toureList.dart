import 'package:flutter/material.dart';

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
        title: Text("لیست تورها"),
      ),
      body: Stack(
        fit: StackFit.expand,
        textDirection: TextDirection.rtl,
        children: <Widget>[
          Row(
            textDirection: TextDirection.rtl,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text("فیلترکردن"),
                  Icon(Icons.filter_list),
                ],
              ),
              Row(
                children: <Widget>[
                  Text("مرتب سازی"),
                  Icon(Icons.sort),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
