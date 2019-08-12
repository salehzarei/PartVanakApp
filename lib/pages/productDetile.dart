import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_banner_swiper/flutter_banner_swiper.dart';
import 'package:hello_flutter/drawer.dart';
import 'package:hello_flutter/model/blog_model.dart';
import 'package:http/http.dart' as http;
import '../scoped_model.dart';

class ProductDetile extends StatefulWidget {
  int id;
  @override
  _ProductDetileState createState() => _ProductDetileState();
  BlogDetile(int id) {
    this.id = id;
  }
}

class _ProductDetileState extends State<ProductDetile> {
  var isLoading = false;
  Blog blog;
  MainModel model = new MainModel();
  // _fetchData() async {
  //   setState(() {
  //     isLoading = true;
  //   });
  //   final response =
  //       await http.get(model.host + 'blog/show/prm/' + widget.id.toString());
  //   if (response.statusCode == 200) {
  //     print(response.body);
  //     Map res = json.decode(response.body);
  //     Map data = res['content'];

  //     setState(() {
  //       isLoading = false;
  //       blog = new Blog(
  //         id: data['id'],
  //         title: data['title'],
  //         content: data['content'],
  //         date: data['date'],
  //         hits: data['hits'],
  //         pic: data['pic'],
  //         thumb: data['thumb'],
  //         comment: (res['comments'] as List)
  //             .map((i) => BlogComment.fromJson(i))
  //             .toList(),
  //       );
  //     });
  //   } else {
  //     throw Exception('Failed to load photos');
  //   }
  // }

  @override
  void initState() {
    bannerList.add(
        "https://images.unsplash.com/photo-1561196643-35c381cb6a6d?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60");
    bannerList.add(
        "https://images.unsplash.com/photo-1561078451-8ebb052326ec?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60");
    bannerList.add(
        "https://images.unsplash.com/photo-1563746924237-f81657aec06a?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60");
    bannerList.add(
        "https://images.unsplash.com/photo-1563923683738-4ad77b43411c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60");
   // _fetchData();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
              drawer: MyDrawer(),
              appBar: AppBar(
                title: Text('data'),
                backgroundColor: Colors.transparent,
                centerTitle: true,
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.arrow_forward),
                    onPressed: () => Navigator.pop(context),
                  )
                ],
              ),
              body: isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Stack(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 190),
                          child: ListView(
                            children: <Widget>[
                              SliverList(
                                delegate: SliverChildListDelegate([
                                  ButtonTheme.bar(
                                    child: ButtonBar(
                                      alignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Icon(
                                              Icons.calendar_today,
                                              color: Colors.black,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(blog.date),
                                          ],
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Icon(
                                              Icons.visibility,
                                              color: Colors.black,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(blog.hits.toString()),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                      child: Container(
                                          padding: EdgeInsets.all(8),
                                          child: Text(blog.content))),
                                ]),
                              ),
                            ],
                          ),
                        ),
                        getSlider(),
                      ],
                    )),
        ),
      ],
    );
  }

  List<String> bannerList = List();
  Widget getSlider() {
    return BannerSwiper(
      height: 108,
      width: 54,
      length: 4,
      getwidget: (index) {
        return GestureDetector(
            child: Image.network(
              bannerList[index % bannerList.length],
              fit: BoxFit.cover,
            ),
            onTap: () {
              print('click on');
            });
      },
    );
  }
}
