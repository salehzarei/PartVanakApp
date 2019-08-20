import 'package:flutter/material.dart';
import 'package:hello_flutter/drawer.dart';
import '../model/product_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../scoped_model.dart';
import 'package:flutter_banner_swiper/flutter_banner_swiper.dart';
import '../UI/comment.dart';

class ProductDetile extends StatefulWidget {
  int id;

  ProductDetile({this.id});
  @override
  State<StatefulWidget> createState() {
    return _ProductDetileState();
  }
}

class _ProductDetileState extends State<ProductDetile> {
  Product product;
  var isLoading = false;
  MainModel model = new MainModel();

  _fetchData() async {
    setState(() {
      isLoading = true;
    });
    final response = await http
        .get(model.host + 'products/show/prm/' + widget.id.toString());
    if (response.statusCode == 200) {
      print('dddddd');
      Map res = json.decode(response.body);
      Map data = res['content'];
      print(data['gallery']);

      setState(() {
        isLoading = false;
        product = new Product(
          id: data['id'],
          title: data['title'],
          content: data['content'],
          hits: data['hits'],
          price: data['price'],
          off: data['off'],
          comment: (res['comments'] as List)
              .map((i) => ProductComment.fromJson(i))
              .toList(),
          gallery: (data['gallery'] as List)
              .map((i) =>(i))
              .toList()
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
    print(product);
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
              :
              CustomScrollView(
                  slivers: <Widget>[
                    Stack(
                      children: <Widget>[
                        Container(
                          height: 160,
                        ),
                        SliverAppBar(
                            centerTitle: true,
                            actions: <Widget>[
                              IconButton(
                                icon: Icon(Icons.arrow_forward,
                                    color: Colors.white),
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
                                          product.title,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            )),
                      ],
                    ),
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
                                  // Text(product.date),
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
                                  Text(product.hits.toString()),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                            child: Container(
                                padding: EdgeInsets.all(8),
                                child: Text(product.content))),
                      ]),
                    ),
                    // SliverList(
                    //   delegate: SliverChildListDelegate(
                    //     (product.comment as List<ProductComment>)
                    //         .map((i) => CommentItem(
                    //               comment: i,
                    //             ))
                    //         .toList(),
                    //   ),
                    // ),
                    // SliverList(
                    //   delegate: SliverChildListDelegate([CommentForm(product.id)]),
                    // )
                  ],
                ),
        ));
  }

  Widget getSlider() {
    return BannerSwiper(
      height: 108,
      width: 54,
      length: product.gallery.length,
      getwidget: (index) {
        return GestureDetector(
            child: Image.network(
             product.gallery[index],
              fit: BoxFit.cover,
            ),
            onTap: () {
              print('click on');
            });
      },
    );
  }
}
