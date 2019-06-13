import 'package:flutter/material.dart';
import 'package:hello_flutter/coustomIcon/toure_icons_icons.dart';
import 'package:hello_flutter/model/toure_model.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _text_long =
        'خرید آنلاین بلیط هواپیما خارجیخرید آنلاین بلیط هواپیما خارجیخرید آنلاین بلیط هواپیما خارجیخرید آنلاین بلیط هواپیما خارجیخرید آنلاین بلیط هواپیما خارجیخرید آنلاین بلیط هواپیما خارجیخرید آنلاین بلیط هواپیما خارجیخرید آنلاین بلیط هواپیما خارجیخرید آنلاین بلیط هواپیما خارجیخرید آنلاین بلیط هواپیما خارجیخرید آنلاین بلیط هواپیما خارجیخرید آنلاین بلیط هواپیما خارجیخرید آنلاین بلیط هواپیما خارجیخرید آنلاین بلیط هواپیما خارجیخرید آنلاین بلیط هواپیما خارجیخرید آنلاین بلیط هواپیما خارجیخرید آنلاین بلیط هواپیما خارجیخرید آنلاین بلیط هواپیما خارجیخرید آنلاین بلیط هواپیما خارجیخرید آنلاین بلیط هواپیما خارجیخرید آنلاین بلیط هواپیما خارجیخرید آنلاین بلیط هواپیما خارجیخرید آنلاین بلیط هواپیما خارجیخرید آنلاین بلیط هواپیما خارجی';
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'درباره ما',
      home: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Icon(
                Icons.airplanemode_active,
                color: Theme.of(context).accentColor,
                size: 30,
              ),
              
            ),
            
          ],
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Text(
            'درباره ما',
            style: Theme.of(context).textTheme.title,
          ),
        ),
        body: Stack(
          fit: StackFit.expand,
          alignment: Alignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                color: Colors.black26.withOpacity(0.2),
                child: ListView(
                  children: <Widget>[
                    Text(
                      '${_text_long.toString()}',
                      textDirection: TextDirection.rtl,
                      // maxLines: 5,
                    ),
                    //Spacer(),
                    Text(
                      '${_text_long.toString()}',
                      textDirection: TextDirection.rtl,
                      // maxLines: 100,
                    ),
                    Text(
                      '${_text_long.toString()}',
                      textDirection: TextDirection.rtl,
                      // maxLines: 100,
                    ),
                  ],
                ),
              ),
            ),
            Container(
                child: Positioned(
              bottom: 0,
              child: Container(
                color: Colors.black.withOpacity(1),
                //alignment: Alignment.center,
                //width: 500,
                child: Row(
                  children: <Widget>[
                    InkWell(
                        radius: 50,
                        onTap: () {Navigator.pop(context);},
                        child: Image.asset('images/instagram.png')),
                    InkWell(
                        radius: 50,
                        onTap: () {},
                        child: Image.asset('images/telegram.png')
                        ),
                    InkWell(
                        radius: 50,
                        onTap: () {},
                        child: Image.asset('images/twitter.png')
                        ),
                    InkWell(
                        radius: 20,
                        onTap: () {},
                        child: Image.asset('images/facebook.png')
                        ),
                  ],
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
