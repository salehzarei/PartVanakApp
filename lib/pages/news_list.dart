import 'package:flutter/material.dart';
import 'package:hello_flutter/coustomIcon/bloglist_icons.dart';
import '../drawer.dart';

class NewsList extends StatelessWidget {
  makeList() {
    return ListView.builder(
        itemCount: 10,
        padding: EdgeInsets.only(top: 50, left: 10, right: 10, bottom: 10),
        itemBuilder: (context, index) {
          return //GestureDetector(onTap: () => {}, child: Image.asset('images/logo.png'));

              //     Column(
              //       children: <Widget>[
              //         SizedBox(height: 10,),
              //         Container(
              //           //decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),

              //   color: Colors.black26,
              //   child: Row(
              //         children: <Widget>[
              //           Container(
              //             child: Image.asset(
              //               'images/logo.png',
              //               width: 50,
              //               height: 50,
              //             ),
              //           ),

              //           Column(
              //             children: <Widget>[
              //               Text('متن نمونه'),
              //               //Container(height: 1,color: Colors.black,width: 100,),
              //               Text('متن نمونه'),
              //              // Container(height: 1,color: Colors.black,width: 100,),
              //               Text('متن نمونه'),
              //               //Container(height: 1,color: Colors.black,width: 100,),
              //               Text('متن نمونه'),
              //             ],
              //           ),
              //         ],
              //   ),
              // ),
              //       ],
              //     );

              Column(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/contact');
                },
                child: Card(
                  color: Colors.white30,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Stack(
                        alignment: AlignmentDirectional.bottomStart,
                        children: <Widget>[
                          Image.asset(
                            'images/air.jpg',
                            fit: BoxFit.cover,
                          ),
                          ListTile(
                            title: Text(
                              'پیتزا مخلوط',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 24.0),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      
                         Container(child: Text('توضیح درباره عکس توضیح درباره عکس  توضیح درباره عکس  توضیح درباره عکس '),),
                      
                      SizedBox(height: 10,),
                      ButtonTheme.bar(
                        child: ButtonBar(
                          alignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text('بازدید کل'),
                                IconButton(
                                  icon: Icon(Bloglist.eye_eyes,
                                      color: Colors.black,),
                                  onPressed: () {},
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Text('98/4/24'),
                                IconButton(
                                  icon: Icon(Bloglist.date_range,
                                      color: Colors.black,),
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        });
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
            'لیست اخبار سایت',
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
        body: Stack(textDirection: TextDirection.rtl, children: <Widget>[
          makeList(),
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
                  GestureDetector(onTap: (){Navigator.pushNamed(context, '/grouping');},
                                      child: Row(
                      children: <Widget>[
                        Text("دسته بندی"),
                        Icon(Icons.filter_list),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}

// import 'package:flutter/material.dart';

// class HomeCards extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return
//     SingleChildScrollView(
//       child:  Column(
//         children: <Widget>[
//            Card(
//             color: Color(0xFFFFF59D),
//             child:  Column(
//               mainAxisSize: MainAxisSize.min,
//               children: <Widget>[
//                 const ListTile(
//                   leading: const Icon(Icons.image),
//                   title: const Text('This Is A Title'),
//                   subtitle: const Text('This is a subtitle in a list tile.'),
//                 ),
//                  ButtonTheme.bar(
//                   // make buttons use the appropriate styles for cards
//                   child:  ButtonBar(
//                     children: <Widget>[
//                        FlatButton(
//                         child: const Text('Button1'),
//                         onPressed: () {},
//                       ),
//                        FlatButton(
//                         child: const Text('Button2'),
//                         onPressed: () {},
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//            Card(
//             child:  Column(
//               mainAxisSize: MainAxisSize.min,
//               children: <Widget>[
//                  Image.asset(
//                   'images/logo.png',
// //                  height: 192.0,
//                   fit: BoxFit.fill,
//                 ),
//                 const ListTile(
//                   title: const Text('This Is A Title'),
//                   subtitle: const Text('This is a subtitle in a card.'),
//                 ),
//                  ButtonTheme.bar(
//                   // make buttons use the appropriate styles for cards
//                   child:  ButtonBar(
//                     alignment: MainAxisAlignment.start,
//                     children: <Widget>[
//                        FlatButton(
//                         child: const Text('Button1'),
//                         onPressed: () {},
//                       ),
//                        FlatButton(
//                         child: const Text('Button2'),
//                         onPressed: () {},
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//            Card(
//             child:  Column(
//               mainAxisSize: MainAxisSize.min,
//               children: <Widget>[
//                  Stack(
//                   alignment: AlignmentDirectional.bottomStart,
//                   children: <Widget>[
//                      Image.asset(
//                       'images/logo.png',
// //                      height: 192.0,
//                       fit: BoxFit.fill,
//                     ),
//                      ListTile(
//                       title:  Text(
//                         'This Is A Title',
//                         style:
//                              TextStyle(color: Colors.white, fontSize: 24.0),
//                       ),
//                     ),
//                   ],
//                 ),
//                  ButtonTheme.bar(
//                   child:  ButtonBar(
//                     alignment: MainAxisAlignment.end,
//                     children: <Widget>[
//                        IconButton(
//                         icon:  Icon(Icons.favorite, color: Colors.grey),
//                         onPressed: () {},
//                       ),
//                        IconButton(
//                         icon:  Icon(Icons.bookmark, color: Colors.grey),
//                         onPressed: () {},
//                       ),
//                        IconButton(
//                         icon:  Icon(Icons.share, color: Colors.grey),
//                         onPressed: () {},
//                       ),
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ].map((Widget widget) {
//           // Add a little space between the widgets
//           return  Container(
//             padding: const EdgeInsets.symmetric(vertical: 4.0),
//             child: widget,
//           );
//         }).toList(),
//       ),
//     );
//   }
// }
