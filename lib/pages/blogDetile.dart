import 'package:flutter/material.dart';
import 'package:hello_flutter/drawer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../model/blog_model.dart';
import '../model/comment_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../scoped_model.dart';
import '../UI/comment.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;

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
              .map((i) => Comment.fromJson(i))
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
          body: isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : CustomScrollView(
                  slivers: <Widget>[
                    SliverAppBar(
                        centerTitle: true,
                        actions: <Widget>[
                          IconButton(
                            icon:
                                Icon(Icons.arrow_forward, color: Colors.white),
                            onPressed: () => Navigator.pop(context),
                          )
                        ],
                        pinned: true,
                        snap: false,
                        floating: false,
                        expandedHeight: 180.0,
                        flexibleSpace: FlexibleSpaceBar(
                          centerTitle: true,
                          title: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 75),
                            child: Text(
                              blog.title,
                              style: TextStyle(fontSize: 12),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          background: Image.network(
                            blog.pic,
                            fit: BoxFit.cover,
                          ),
                        )),
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
                           padding: EdgeInsets.all(8),
                            child: Text(blog.title,style: TextStyle(fontSize: 18,height: 1.3,fontWeight: FontWeight.bold),),
                            
                        ),
                        Container(
                            child: Container(
                                padding: EdgeInsets.all(8),
                                child: Html(
                                  data: blog.content,
                                  onLinkTap: (url) async {
                                    if (await canLaunch(url)) {
                                      await launch(url);
                                    } else {
                                      throw 'Could not launch $url';
                                    }
                                  },
                                  customTextAlign: (dom.Node node) {
                                    if (node is dom.Element) {
                                      return TextAlign.right;
                                    }
                                  },
                                  customTextStyle:
                                      (dom.Node node, TextStyle baseStyle) {
                                    if (node is dom.Element) {
                                      switch (node.localName) {
                                        case "p":
                                          return baseStyle.merge(TextStyle(
                                              height: 1.5, fontSize: 15));
                                      }
                                    }
                                    return baseStyle;
                                  },
                                ))),
                      ]),
                    ),
                    SliverList(
                      delegate: SliverChildListDelegate(
                        (blog.comment as List<Comment>)
                            .map((i) => CommentItem(
                                  comment: i,
                                ))
                            .toList(),
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildListDelegate(
                          [CommentForm(blog.id, 'blog')]),
                    )
                  ],
                ),
        ));
  }
}
