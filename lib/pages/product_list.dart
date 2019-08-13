import 'package:flutter/material.dart';
import 'package:hello_flutter/pages/blogDetile.dart';
import '../drawer.dart';
import '../model/blog_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../scoped_model.dart';

class ProductList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProductListState();
  }
}

class _ProductListState extends State<ProductList> {
  List<Blog> list = List();
  var isLoading = false;
  MainModel model = MainModel();

  _fetchData() async {
    setState(() {
      isLoading = true;
    });
    final response = await http.get(model.host + 'blog');
    if (response.statusCode == 200) {
      print(response.body);
      Map data = json.decode(response.body);

      list = (data['post'] as List).map((data) => Blog.fromJson(data)).toList();
      setState(() {
        isLoading = false;
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

  makeList(List<Blog> blog) {
    return ListView.builder(
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
                  // Navigator.pushNamed(context, '/contact');
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
                          // Swiper(
                          //   itemBuilder: (BuildContext context, int index) {
                          //     return  Image.network(
                          //       "https://images.unsplash.com/photo-1495490311930-678c8ecdd120?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1189&q=80",
                          //       fit: BoxFit.fill,
                          //     );
                          //   },
                          //   itemCount: 3,
                          //   pagination:  SwiperPagination(),
                          //   control:  SwiperControl(),
                          // ),
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

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        drawer: MyDrawer(),
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'لیست محصولات سایت',
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
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Stack(textDirection: TextDirection.rtl, children: <Widget>[
                makeList(list),
                Column(
                  children: <Widget>[
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
                            GestureDetector(
                              onTap: () => {},
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
                    ),
                  ],
                ),
              ]),
      ),
    );
  }

  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Directionality(
            textDirection: TextDirection.ltr,
            child: Container(
              child: Wrap(
                children: <Widget>[
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: Container(
                      child: Row(
                        children: <Widget>[
                          Text('data'),
                          Icon(Icons.arrow_back)
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  Widget search() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'متن پیام', filled: true, fillColor: Colors.grey),
      // obscureText: true,

      maxLines: 3,
      keyboardType: TextInputType.text,
      onSaved: (String value) {},
    );
  }
}