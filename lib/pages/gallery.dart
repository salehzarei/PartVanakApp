import 'package:flutter/material.dart';
import 'package:hello_flutter/drawer.dart';
import '../model/product_model.dart';

class AlbumGallery extends StatefulWidget {
  @override
  _AlbumGalleryState createState() => _AlbumGalleryState();
}

class _AlbumGalleryState extends State<AlbumGallery> {
  Product product;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          drawer: MyDrawer(),
          appBar: AppBar(
            title: Text('گالری تصاویر',
                style: Theme.of(context).textTheme.display2),
            centerTitle: true,
            iconTheme: Theme.of(context)
                .iconTheme
                .copyWith(color: Theme.of(context).accentColor),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.arrow_forward,
                    color: Theme.of(context).accentColor),
                onPressed: () => Navigator.pushNamed(context, '/homepage'),
              )
            ],
          ),
          body: Center(
            child: Text('data'),
          )),
    );
  }
}
