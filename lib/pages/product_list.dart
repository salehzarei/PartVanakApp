import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hello_flutter/pages/productDetile.dart';
import '../drawer.dart';
import '../model/product_model.dart';
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
  List<Map<String, dynamic>> crumb = [
    {'id': '00', 'title': 'همه'}
  ];
  List<Product> list = List();
  Map<String, dynamic> curentCategory = {'id': 00, 'title': 'همه'};
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

    setState(() {
      isLoading = true;
    });

    final response = await http.get(model.host + 'products$q');
    if (response.statusCode == 200) {
      Map data = json.decode(response.body);

      if (data['count'] > 0) {
        list = (data['post'] as List)
            .map((data) => new Product.listJson(data))
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

    final response = await http.get(model.host + 'products/treecategory');
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

  makeList(List<Product> product) {
    Widget content = Center(
      child: Text('موردی یافت نشد'),
    );
    if (product.length > 0) {
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
                            builder: (context) => ProductDetile(
                                  id: product[index].id,
                                )));
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    color: Colors.white12,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Stack(
                          alignment: AlignmentDirectional.bottomStart,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Center(
                                child: Image.network(
                                  product[index].thumb,
                                  fit: BoxFit.cover,
                                  width: MediaQuery.of(context).size.width,
                                  height: 200,
                                ),
                              ),
                            ),
                            ListTile(
                              title: Text(
                                product[index].title,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16.0),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: Text(
                            product[index].summary,
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
                                    Icons.visibility,
                                    color: Colors.black,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(product[index].hits.toString()),
                                ],
                              ),
                              Row(
                                children: _bulidPriceBox(product[index]),
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
            'لیست خدمات',
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text("دسته بندی : "),
                                    Text(curentCategory['title']),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 160),
                                      child: InkWell(
                                        child: Text('حذف فیلتر'),
                                        onTap: () {
                                          Navigator.pushReplacementNamed(
                                              context, '/product');
                                        },
                                      ),
                                    )
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
                    if (curentCategory['id'] != '00') {
                      crumb.removeAt(crumb.length - 1);
                    }

                    _buildCategory(context);
                  });
                },
                child: crumb.length > 1 ? Icon(Icons.arrow_back) : Container()),
            GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    curentCategory['id'] = last['id'];
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
      return;
    } else if (_categories["${last['id']}"] != null) {
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
                          crumb.add({'id': k, 'title': v['title']});
                        }

                        curentCategory['id'] = k;
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
                            crumb.add({'id': k, 'title': v['title']});

                            _buildCategory(context);
                          });
                        },
                        child: Icon(Icons.keyboard_arrow_left))
              ],
            ));

        categorieData.add(w);
      });
    }

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

  List<Widget> _bulidPriceBox(Product product) {
    List<Widget> _content = [Container()];
    if (product.off != '0') {
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
