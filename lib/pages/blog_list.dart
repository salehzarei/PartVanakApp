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
  List<Map<String, dynamic>> crumb = [
    {'pId': 0, 'id': '00', 'title': 'همه'}
  ];
  List<Blog> list = List();
  Map<String, dynamic> curentCategory = {'pId': 0, 'id': '00', 'title': 'همه'};
  Map<dynamic, dynamic> _categories;
  String word = '';
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var isLoading = false;
  var categoryLoading = false;
  MainModel model = new MainModel();

  _fetchData() async {
    String q = '';

    q = '?catId=' + curentCategory['id'].toString();

    if (word != '') {
      q = '$q&word=$word';
    }
    print(q);

    setState(() {
      isLoading = true;
    });

    final response = await http.get(model.host + 'blog$q');
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
          padding: EdgeInsets.only(top: 110, left: 10, right: 10, bottom: 10),
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
                            GestureDetector(
                              onTap: () {
                                _buildCategory(context);
                              },
                              child: Directionality(
                                textDirection: TextDirection.rtl,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Text("دسته بندی : "),
                                    Text(curentCategory['title']),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Container(
                              color: Colors.black,
                              height: 1,
                            ),
                            Container(
                                child: Form(
                              key: _formKey,
                              child: _search(),
                            )),
                            Container(
                              color: Colors.black,
                              height: 1,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]),
      ),
    );
  }

  void _buildCategory(BuildContext context) {
    List<Widget> categorieData = new List();
    Map last = crumb.last;
    categorieData.add(Container(
        padding: EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
        decoration: BoxDecoration(
          color: Colors.black12,
          border: Border(bottom: BorderSide(color: Colors.black12)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            GestureDetector(
                onTap: () {
                  Navigator.pop(context);

                  setState(() {
                    // curentCategory['id'] = last['id'];
                    // curentCategory['pId'] = last['pId'];
                    // curentCategory['title'] = last['title'];

                    if (curentCategory['id'] != crumb[crumb.length - 1]['id']) {
                      crumb.removeAt(crumb.length - 1);
                    }

                    _buildCategory(context);
                  });
                },
                child: crumb.length > 1 ? Icon(Icons.arrow_back) : Container()),
            // Icon(Icons.arrow_back)),
            GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    crumb.add({
                      'id': last['id'],
                      'pId': curentCategory['id'],
                      'title': last['title']
                    });

                    curentCategory['id'] = last['id'];
                    curentCategory['pId'] = curentCategory['id'];
                    curentCategory['title'] = last['title'];
                  });

                  _fetchData();
                },
                child: Text(crumb[crumb.length - 1]['title'])),
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
      
      _categories["${last['id']}"].forEach((k, v) {
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
                      setState(() {
                        if (_categories[k] != null) {
                          crumb.add({
                            'id': k,
                            'pId': curentCategory['id'],
                            'title': v['title']
                          });
                        }

                        curentCategory['id'] = k;
                        curentCategory['pId'] = curentCategory['id'];
                        curentCategory['title'] = v['title'];
                      });

                      _fetchData();
                    },
                    child: Text("${v['title']}")),
                v['count'] == 0
                    ? Container()
                    : GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          setState(() {
                            // crumb.add(curentCategory);
                            // curentCategory['id'] = k;
                            // curentCategory['pId'] = curentCategory['id'];
                            // curentCategory['title'] = v['title'];

                            crumb.add({
                              'id': k,
                              'pId': curentCategory['id'],
                              'title': v['title']
                            });

                            // crumb.add({'id':k,'pId': curentCategory['id'],'title':v['title']});

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
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextFormField(
        initialValue: word,
        validator: (String value) {
          if (value.isEmpty) {
            return 'متن خود را وارد کنید';
          }
        },
        onSaved: (String value) {
          setState(() {
            word = value;
          });
        },
        maxLines: 1,
        decoration: InputDecoration(
            suffixIcon: IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                setState(() {
                  // if(!_formKey.currentState.validate()){
                  //   return ;
                  // }
                  _formKey.currentState.save();
                  _fetchData();
                });
              },
            ),
            labelText: 'جست و جو',
            filled: true,
            fillColor: Colors.white,
            border: InputBorder.none),
        keyboardType: TextInputType.text,
      ),
    );
  }
}
