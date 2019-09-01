import 'package:flutter/material.dart';
import 'package:hello_flutter/drawer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../model/product_model.dart';
import '../model/comment_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../scoped_model.dart';
import 'package:flutter_banner_swiper/flutter_banner_swiper.dart';
import '../UI/comment.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;

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
      Map res = json.decode(response.body);
      Map data = res['content'];
      setState(() {
        isLoading = false;
        product = new Product(
            id: data['id'],
            title: data['title'],
            content: data['content'],
            hits: data['hits'],
            price: data['price'].toString(),
            off: data['off'],
            currency: data['currency'],
            comment: (res['comments'] as List)
                .map((i) => Comment.fromJson(i))
                .toList(),
            gallery: (data['gallery'] as List).map((i) => (i)).toList());
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
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Text(product.title),
                          ),
                          background: getSlider(),
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
                                    Icons.visibility,
                                    color: Colors.black,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(product.hits.toString()),
                                ],
                              ),
                              Row(
                                children: _bulidPriceBox(product),
                              ),
                            ],
                          ),
                        ),
                        Container(
                            child: Container(
                                padding: EdgeInsets.all(8),
                                child: Html(
                                  data: product.content,
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
                                      return baseStyle.merge(
                                          TextStyle(height: 1.5, fontSize: 15));
                                    }
                                    return baseStyle;
                                  },
                                ))),
                      ]),
                    ),
                    SliverList(
                      delegate: SliverChildListDelegate(
                        (product.comment as List<Comment>)
                            .map((i) => CommentItem(
                                  comment: i,
                                ))
                            .toList(),
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildListDelegate(
                          [CommentForm(product.id, 'products')]),
                    )
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
              product.gallery[index % product.gallery.length],
              fit: BoxFit.cover,
            ),
            onTap: () {});
      },
    );
  }

  List<Widget> _bulidPriceBox(Product product) {
    List<Widget> _content = [Container()];
    if (product.off != '0' && product.off != null) {
      _content = [
        Icon(
          Icons.attach_money,
          color: Colors.black,
          size: 20,
        ),
        SizedBox(
          width: 3,
        ),
        Text(
          product.price,
          style: TextStyle(decoration: TextDecoration.lineThrough),
        ),
        SizedBox(
          width: 5,
        ),
        Text(product.off),
        SizedBox(
          width: 5,
        ),
        Text(product.currency)
      ];
    } else if (product.price != '0') {
      _content = [
        Icon(
          Icons.attach_money,
          color: Colors.black,
          size: 20,
        ),
        SizedBox(
          width: 5,
        ),
        Text(product.price),
        SizedBox(
          width: 5,
        ),
        Text(product.currency)
      ];
    }
    return _content;
  }
}
