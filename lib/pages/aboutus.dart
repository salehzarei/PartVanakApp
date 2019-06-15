import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';


class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _text_long =
        'خرید آنلاین بلیط هواپیما خارجیخرید آنلاین بلیط هواپیما خارجیخرید آنلاین بلیط هواپیما خارجیخرید آنلاین بلیط هواپیما خارجیخرید آنلاین بلیط هواپیما خارجیخرید آنلاین بلیط هواپیما خارجیخرید آنلاین بلیط هواپیما خارجیخرید آنلاین بلیط هواپیما خارجیخرید آنلاین بلیط هواپیما خارجیخرید آنلاین بلیط هواپیما خارجیخرید آنلاین بلیط هواپیما خارجیخرید آنلاین بلیط هواپیما خارجیخرید آنلاین بلیط هواپیما خارجیخرید آنلاین بلیط هواپیما خارجیخرید آنلاین بلیط هواپیما خارجیخرید آنلاین بلیط هواپیما خارجیخرید آنلاین بلیط هواپیما خارجیخرید آنلاین بلیط هواپیما خارجیخرید آنلاین بلیط هواپیما خارجیخرید آنلاین بلیط هواپیما خارجیخرید آنلاین بلیط هواپیما خارجیخرید آنلاین بلیط هواپیما خارجیخرید آنلاین بلیط هواپیما خارجیخرید آنلاین بلیط هواپیما خارجی';
    return Scaffold(
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
        // fit: StackFit.expand,
        alignment: Alignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              color: Colors.black26.withOpacity(0.2),
              child: ListView(
                children: <Widget>[
                 Html(
                   data: """
                <div>Follow<a class='sup'><sup>pl</sup></a> 
                  Below hr
                    <b>Bold</b>
                <h1>what was sent down to you from your Lord</h1>, 
                and do not follow other guardians apart from Him. Little do</br>
                 and do not follow other guardians apart from Him. Little do</br>
                 and do not follow other guardians apart from Him. Little do</br>
                 and do not follow other guardians apart from Him. Little do</br>
                 and do not follow other guardians apart from Him. Little do</br>
                 and do not follow other guardians apart from Him. Little do</br>
                <span class='h'>you remind yourselves</span><a class='f'><sup f=2437>1</sup></a></div>
                """,
                 ),
                
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
             // color: Colors.grey.withOpacity(1),
             decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(25),
               color: Colors.grey.withOpacity(1),
             ),
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Image.asset('images/instagram.png')),
                     SizedBox(
                       width: 10,
                     ),
                  InkWell(
                      onTap: () {}, child: Image.asset('images/telegram.png')),
                      SizedBox(
                       width: 10,
                     ),
                  InkWell(
                      onTap: () {}, child: Image.asset('images/twitter.png')),
                       SizedBox(
                       width: 10,
                     ),
                  InkWell(
                      onTap: () {}, child: Image.asset('images/facebook.png')),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
