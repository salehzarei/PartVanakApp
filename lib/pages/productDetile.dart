import 'package:flutter/material.dart';
import 'package:hello_flutter/drawer.dart';
import '../model/blog_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../scoped_model.dart';
import 'package:flutter_banner_swiper/flutter_banner_swiper.dart';
import '../UI/comment.dart';

class BlogDetile extends StatefulWidget {
  int id;
  @override
  State<StatefulWidget> createState() {
    return _BlogDetileState();
  }

  BlogDetile(int id) {
    this.id = id;
  }
}

class _BlogDetileState extends State<BlogDetile> {
  
  Blog blog;
  var isLoading = false;
  MainModel model = new MainModel();

  _fetchData() async {
    setState(() {
      isLoading = true;
    });
    final response =
        await http.get(model.host + 'blog/show/prm/' + widget.id.toString());
    if (response.statusCode == 200) {
      print(response.body);
      Map res = json.decode(response.body);
      Map data = res['content'];

      setState(() {
        isLoading = false;
        blog = new Blog(
          id: data['id'],
          title: data['title'],
          content: data['content'],
          date: data['date'],
          hits: data['hits'],
          pic: data['pic'],
          thumb: data['thumb'],
          comment: (res['comments'] as List)
              .map((i) => BlogComment.fromJson(i))
              .toList(),
        );
      });
    } else {
      throw Exception('Failed to load photos');
    }
  }

  @override
  void initState() {
    _fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          drawer: MyDrawer(),

          // SliverAppBar is declared in Scaffold.body, in slivers of a
          // CustomScrollView.
          body: isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : CustomScrollView(
                  slivers: <Widget>[
                    Stack(children: <Widget>[
                      Container(
                      height: 160,),
                      SliverAppBar(
                      centerTitle: true,
                      actions: <Widget>[
                        IconButton(
                          icon: Icon(Icons.arrow_forward, color: Colors.white),
                          onPressed: () => Navigator.pop(context),
                        )
                      ],
                      pinned: true,
                      snap: false,
                      floating: false,
                      expandedHeight: 180.0,
                      flexibleSpace: ListView(
                          children: <Widget>[
                            Stack(
                              children: <Widget>[
                                Container(
                                  child: getSlider(),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 120, right: 40),
                                  child: Container(
                                    child: Text(
                                      blog.title,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        )
                    ),
                    ],),
                    
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
                    SliverList(
                      delegate: SliverChildListDelegate(
                        (blog.comment as List<BlogComment>)
                            .map((i) => CommentItem(
                                  comment: i,
                                ))
                            .toList(),
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildListDelegate([CommentForm(blog.id)]),
                    )
                  ],
                ),
        ));
  }

  
  // List<String> bannerList = List();
  Widget getSlider() {
    return BannerSwiper(
      height: 108,
      width: 54,
      length: 4,
      getwidget: (index) {
        return GestureDetector(
            child: Image.network(
              // bannerList[index % bannerList.length],
              blog.pic,
              fit: BoxFit.cover,
            ),
            onTap: () {
              print('click on');
            });
      },
    );
  }
}
