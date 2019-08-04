import 'package:flutter/material.dart';
import 'package:hello_flutter/drawer.dart';

class Menubar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text('لیست اخبار سایت',
              style: Theme.of(context).textTheme.display2),
          iconTheme: Theme.of(context)
              .iconTheme
              .copyWith(color: Theme.of(context).accentColor),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_forward,
                  color: Theme.of(context).accentColor),
              onPressed: () => Navigator.pop(context),
            )
          ],
        ),
        drawer: MyDrawer(),
        body: Directionality(
            textDirection: TextDirection.rtl,
            child: ListView(
              children: <Widget>[
                ExpansionTile(
                  title: Text('پیتزا'),
                  children: <Widget>[
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 1,
                            color: Color(0xFFD8B945),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Text(
                              'پیتزا مخلوط',
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Container(
                            height: 1,
                            color: Color(0xFFD8B945),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Text(
                              'پیتزا سبزیجات',
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Container(
                            height: 1,
                            color: Color(0xFFD8B945),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Text(
                              'پیتزا سبزیجات',
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Container(
                            height: 1,
                            color: Color(0xFFD8B945),
                          ),
                          ExpansionTile(
                            title: Text('ساندویچ'),
                            children: <Widget>[
                              Container(
                                height: 1,
                                color: Color(0xFFD8B945),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Text(
                                  'پیتزا مخلوط',
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Container(
                                height: 1,
                                color: Color(0xFFD8B945),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Text(
                                  'پیتزا مخلوط',
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Container(
                                height: 1,
                                color: Color(0xFFD8B945),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Text(
                                  'پیتزا مخلوط',
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Container(
                                height: 1,
                                color: Color(0xFFD8B945),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                ExpansionTile(
                  title: Text('منو'),
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          height: 1,
                          color: Color(0xFFD8B945),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            'پیتزا مخلوط',
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                          height: 1,
                          color: Color(0xFFD8B945),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            'پیتزا مخلوط',
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                          height: 1,
                          color: Color(0xFFD8B945),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            'پیتزا مخلوط',
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                          height: 1,
                          color: Color(0xFFD8B945),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            'پیتزا مخلوط',
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                          height: 1,
                          color: Color(0xFFD8B945),
                        ),
                      ],
                    )
                  ],
                ),
                ExpansionTile(
                  title: Text('منو'),
                ),
                ExpansionTile(
                  title: Text('منو'),
                ),
                ExpansionTile(
                  title: Text('منو'),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 1,
                  color: Colors.black,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'متن خود را وارد کنید',
                      filled: true,
                      fillColor: Colors.white),
                  keyboardType: TextInputType.text,
                ),
                RaisedButton(
                  onPressed: () {
                    print('جست و جو');
                  },
                  child: Text('جست و جو'),
                )
              ],
            )),
      ),
    );
  }
}
