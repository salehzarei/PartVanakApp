import 'package:flutter/material.dart';
// import '../drawer.dart';
import '../model/blog_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../scoped_model.dart';
// import 'package:flutter_html_view/flutter_html_view.dart';

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
      Map data = json.decode(response.body);
      data = data['content'];

      setState(() {
        isLoading = false;
        blog = new Blog(
            id: data['id'],
            title: data['title'],
            content: data['content'],
            date: data['date'],
            hits: data['hits'],
            pic: data['pic'],
            thumb: data['thumb']);
        print(blog.pic);
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
          // SliverAppBar is declared in Scaffold.body, in slivers of a
          // CustomScrollView.
          body: isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : CustomScrollView(
                  slivers: <Widget>[
                    SliverAppBar(
                      pinned: true,
                      snap: false,
                      floating: false,
                      expandedHeight: 160.0,
                      flexibleSpace: FlexibleSpaceBar(
                        title: Text(blog.title),
                        background: Image.network(
                          blog.pic,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    // If the main content is a list, use SliverList instead.
                    SliverFillRemaining(
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(10),
                            child:Text(blog.content)
                          ),
                          DefaultTabController(
                            length: 2,
                            child: SizedBox(
                              height: 100.0,
                              child: Column(
                                children: <Widget>[
                                  TabBar(
                                    indicatorColor: Colors.lime,
                                    labelColor: Colors.black,
                                    tabs: <Widget>[
                                      Tab(
                                          child: new Row(
                                        children: <Widget>[
                                          new Icon(Icons.airplanemode_active),
                                          new SizedBox(
                                            width: 5.0,
                                          ),
                                          new Text("First"),
                                        ],
                                      )),
                                      Tab(
                                          child: new Row(
                                        children: <Widget>[
                                          new Icon(Icons.airplanemode_active),
                                          new SizedBox(
                                            width: 5.0,
                                          ),
                                          new Text("First"),
                                        ],
                                      ))
                                    ],
                                  ),
                                  Expanded(
                                    child: TabBarView(
                                      children: <Widget>[
                                        Container(
                                          child: Text("ssss"),
                                          color: Colors.green,
                                        ),
                                        Container(
                                          child: Text("sss1211s"),
                                          color: Colors.yellow,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Center(child:Text(blog.content)),
                      //           Center(child: HtmlView(
                      // data: blog.content)),
                    ),
                  ],
                ),
        ));
  }
}
