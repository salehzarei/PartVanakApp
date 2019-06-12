import 'package:flutter/material.dart';
import 'package:hello_flutter/coustomIcon/toure_icons_icons.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'درباره ما',
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('درباره ما'),
        ),
        body: Stack(
          fit: StackFit.expand,
          alignment: Alignment.center,
          textDirection: TextDirection.rtl,
          children: <Widget>[
            ListView(
              children: <Widget>[
                Text('ّسلام'),
                Text('ّسلام'),
                Text('ّسلام'),
                Text('ّسلام'),
                Text('ّسلام'),
                Text('ّسلام'),
                Text('ّسلام'),
                Text('ّسلام'),
                Text('ّسلام'),
                Text('ّسلام'),
                Text('ّسلام'),
                Text('ّسلام'),
                Text('ّسلام'),
                Text('ّسلام'),
                Text('ّسلام'),
                Text('ّسلام'),
                Text('ّسلام'),
                Text('ّسلام'),
                Text('ّسلام'),
                Text('ّسلام'),
                Text('ّسلام'),
                Text('ّسلام'),
                Text('ّسلام'),
                Text('ّسلام'),
                Text('ّسلام'),
                Text('ّسلامfgdfhdddfhfhfdhfhfrhfhfhfhfhfdhfhfhfgjhfgjfg'),
                Text('ّسلامfgdfhdddfhfhfdhfhfrhfhfhfhfhfdhfhfhfgjhfgjfg'),
                Text('ّسلامfgdfhdddfhfhfdhfhfrhfhfhfhfhfdhfhfhfgjhfgjfg'),
                Text('ّسلامfgdfhdddfhfhfdhfhfrhfhfhfhfhfdhfhfhfgjhfgjfg'),
                Text('ّسلامfgdfhdddfhfhfdhfhfrhfhfhfhfhfdhfhfhfgjhfgjfg'),
                Text('ّسلامfgdfhdddfhfhfdhfhfrhfhfhfhfhfdhfhfhfgjhfgjfg'),
                Text('ّسلامfgdfhdddfhfhfdhfhfrhfhfhfhfhfdhfhfhfgjhfgjfg'),
                Text('ّسلامfgdfhdddfhfhfdhfhfrhfhfhfhfhfdhfhfhfgjhfgjfg'),
                Text('ّسلامfgdfhdddfhfhfdhfhfrhfhfhfhfhfdhfhfhfgjhfgjfg'),
                Text('ّسلامfgdfhdddfhfhfdhfhfrhfhfhfhfhfdhfhfhfgjhfgjfg'),
              ],
            ),
            Positioned(
                bottom: 25,
                child: Row(
                  children: <Widget>[
                    InkWell(
                      radius: 50,
                      onTap: () {},
                      child: Icon(
                        ToureIcons.around,
                        color: Colors.pink,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.map),
                      color: Colors.white,
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(Icons.mood),
                      color: Colors.white,
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(Icons.mail),
                      color: Colors.white,
                      onPressed: () {},
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
