import 'package:flutter/material.dart';
import 'package:hello_flutter/UI/toure_list_item.dart';

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
       // fit: StackFit.expand,
        textDirection: TextDirection.rtl,
        children: <Widget>[
           SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                   GestureDetector(
                     onTap: ()=>Navigator.pushNamed(context, '/touredetile'),
                     child: ToureListItem()),
                   ToureListItem(),
                   ToureListItem(),
                   ToureListItem(),
                   ToureListItem(),
                   ToureListItem(),
                   ToureListItem(),
                   ToureListItem(),
                   
                  ],
                )),
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
          ),
         
         
        ],
      ),
    );
  }
}
