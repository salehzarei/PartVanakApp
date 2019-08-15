import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hello_flutter/pages/blogDetile.dart';
import '../drawer.dart';
import '../model/blog_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../scoped_model.dart';

class BlogList extends StatefulWidget {
  int pId;
  String word;
  BlogList({this.pId, this.word});

  @override
  State<StatefulWidget> createState() {
    return _BlogListState();
  }
}

class _BlogListState extends State<BlogList> {
  List<Blog> list = List();
  Map<String, dynamic> curentCategory = {'pId': 0, 'id': 0};
  Map<dynamic, dynamic> _categories;

  var isLoading = false;
  var categoryLoading = false;
  MainModel model = new MainModel();

  _fetchData({pId, word}) async {
    String q = '';
    if (pId != null) {
      q = '?catId=' + pId.toString();
    }

    if (word != null) {
      q = q != '' ? '?$q&word=$word' : '?word=$word';
    }

    setState(() {
      isLoading = true;
    });

    final response = await http.get(model.host + 'blog$q');
    print(model.host + 'blog$q');
    if (response.statusCode == 200) {
      Map data = json.decode(response.body);
      if (data['count'] > 0) {
        list = (data['post'] as List)
            .map((data) => new Blog.fromJson(data))
            .toList();
        setState(() {
          isLoading = false;
        });
      } else {
        setState(() {
          list = [];
          isLoading = false;
        });
      }
    } else {
      throw Exception('Failed to load photos');
    }
  }

  _fetchCategories() async {
    setState(() {
      categoryLoading = true;
    });

    final response = await http.get(model.host + 'blog/treecategory');
    if (response.statusCode == 200) {
      setState(() {
        categoryLoading = false;
        _categories = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load photos');
    }
  }

  @override
  void initState() {
    _fetchData();
    _fetchCategories();
    super.initState();
  }

  makeList(List<Blog> blog) {
    Widget content = Center(
      child: Text('موردی یافت نشد'),
    );
    if (blog.length > 0) {
      content = ListView.builder(
          itemCount: list.length,
          padding: EdgeInsets.only(top: 50, left: 10, right: 10, bottom: 10),
          itemBuilder: (context, index) {
            return Column(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BlogDetile(blog[index].id)));
                  },
                  child: Card(
                    color: Colors.white30,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Stack(
                          alignment: AlignmentDirectional.bottomStart,
                          children: <Widget>[
                            Image.network(
                              blog[index].thumb,
                              fit: BoxFit.cover,
                            ),
                            ListTile(
                              title: Text(
                                blog[index].title,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 24.0),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: Text(
                            blog[index].summary,
                            textAlign: TextAlign.start,
                          ),
                        ),
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
                                  Text(blog[index].date),
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
                                  Text(blog[index].hits.toString()),
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
    return content;
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        drawer: MyDrawer(),
        appBar: AppBar(
          actions: <Widget>[
            // IconButton(
            //  // alignment: Alignment(65,0),
            //   //padding: EdgeInsets.only(left: 100),
            //   icon: Icon(Icons.search, color: Theme.of(context).accentColor),
            //   onPressed: () => Navigator.pop(context),
            // ),
            IconButton(
              icon: Icon(Icons.arrow_forward,
                  color: Theme.of(context).accentColor),
              onPressed: () => Navigator.pop(context),
            )
          ],
          centerTitle: true,
          title: Text(
            'لیست اخبار سایت',
            style: Theme.of(context).textTheme.display2,
          ),
          iconTheme: Theme.of(context)
              .iconTheme
              .copyWith(color: Theme.of(context).accentColor),
        ),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Stack(
                textDirection: TextDirection.rtl,
                alignment: AlignmentDirectional.topCenter,
                children: <Widget>[
                    makeList(list),
                    Container(
                      color: Colors.white,
                      height: 106,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10, right: 5),
                        child: Column(
                          children: <Widget>[
                            Row(
                              textDirection: TextDirection.rtl,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    _buildCategory(context);
                                  },
                                  child: Row(
                                    children: <Widget>[
                                      Text("دسته بندی"),
                                      Icon(Icons.filter_list),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Container(
                              height: 1,
                              color: Colors.black,
                              width: MediaQuery.of(context).size.width,
                            ),
                            Column(
                              textDirection: TextDirection.rtl,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[_search()],
                            ),
                            Container(
                              height: 1,
                              color: Colors.black,
                              width: MediaQuery.of(context).size.width,
                            ),
                          ],
                        ),
                      ),
                    )
                  ]),
      ),
    );
  }

  void _buildCategory(BuildContext context) {
    List<Widget> categorieData = new List();

    categorieData.add(Container(
        padding: EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
        decoration: BoxDecoration(
          color: Colors.black12,
          border: Border(bottom: BorderSide(color: Colors.black12)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Icon(Icons.arrow_back),
            Text("All"),
          ],
        )));

    if (categoryLoading) {
      showModalBottomSheet(
          context: context,
          builder: (BuildContext context) => Container(
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: Colors.black12)),
              ),
              child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ))));
    } else {
      _categories["${curentCategory['id']}"].forEach((k, v) {
        Widget w = Container(
            padding: EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.black12)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      curentCategory['id'] = k;
                      curentCategory['pId'] = curentCategory['id'];
                      _fetchData(pId: k);
                    },
                    child: Text("${v['title']}")),
                v['count'] == 0
                    ? Container()
                    : GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          setState(() {
                            curentCategory['id'] = k;
                            curentCategory['pId'] = curentCategory['id'];
                            _buildCategory(context);
                          });
                        },
                        child: Icon(Icons.keyboard_arrow_left))
              ],
            ));

        categorieData.add(w);
      });

      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) => Container(
          decoration: BoxDecoration(
            border: Border(top: BorderSide(color: Colors.black12)),
          ),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: ListView(
              shrinkWrap: true,
              primary: false,
              children: categorieData,
            ),
          ),
        ),
      );
    }
  }

  Widget _search() {
    return TextFormField(
      maxLines: 1,
      decoration: InputDecoration(
          icon: IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              print('جست و جو');
            },
          ),
          labelText: 'جست و جو',
          filled: true,
          fillColor: Colors.white,
          border: InputBorder.none),
      keyboardType: TextInputType.emailAddress,
    );
  }
}
