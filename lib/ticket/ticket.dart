import 'package:flutter/material.dart';
import 'package:hello_flutter/Theme/drawerTheme.dart';
import 'package:hello_flutter/drawer.dart';
import './reply.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../scoped_model.dart';
import '../model/ticket_model.dart';

class TicketList extends StatefulWidget {
  @override
  _TicketListState createState() => _TicketListState();
}

class _TicketListState extends State<TicketList> {
  List<Ticket> list = List();
  MainModel model = new MainModel();

  var isLoading = true;

  _getTicket() async {
    final response = await http
        .post(model.host + 'tickets', body: {'token': model.userToken});
    if (response.statusCode == 200) {
      Map data = json.decode(response.body);

      if (data['count'] > 0) {
        setState(() {
          list = (data['post'] as List)
              .map((d) => new Ticket.fromJson(d))
              .toList();
          isLoading = false;
        });
      } else {
        setState(() {
          list = [];
          isLoading = false;
        });
      }
    } else {
      throw Exception('Failed to load ticket');
    }
  }

  ///داریم نرم افزار را تست میکنیم
  Widget _checkread(int read) {
    if (read == 1) {
      return Container(
        child: Text(
          'خوانده نشده',
          style: TextStyle(color: Colors.redAccent),
        ),
      );
    } else if (read == 2) {
      return Container(
          child: Text(
        'پیام جدید',
        style: TextStyle(color: Colors.greenAccent),
      ));
    } else {
      return Container();
    }
  }

  @override
  void initState() {
    model.getToken().then((_) {
      if (model.userToken != null) {
        _getTicket();
      } else {
        setState(() {
          isLoading = false;
        });
      }
    });

    super.initState();
  }

  makeTicketList(List<Ticket> ticket) {
    Widget content = Center(
      child: Text('موردی یافت نشد'),
    );
    if (model.userToken == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('لطفا وارد پنل کاربری خود شوید'),
            RaisedButton(
              child: Text('ورود'),
              onPressed: () => Navigator.pushNamed(context, '/login'),
            )
          ],
        ),
      );
    }
    if (list.length > 0) {
      content = ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(5),
              child: Container(
                height: 140,
                child: Card(
                  color: Colors.grey.shade700,
                  child: ListView(
                    children: <Widget>[
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Text(
                                    ticket[index].subject.length > 30
                                        ? ticket[index]
                                                .subject
                                                .substring(0, 30) +
                                            '...'
                                        : ticket[index].subject,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 8, left: 20),
                                  child: Container(
                                      width: 80,
                                      height: 20,
                                      child: Container(
                                        child: _checkread(ticket[index].read),
                                      )),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        right: 20, left: 8),
                                    child: Text(
                                      ticket[index].abestract,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 125,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: RaisedButton(
                                      child: Text('ادامه مطلب'),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (content) =>
                                                    Reply(ticket[index].id)));
                                      },
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
    }
    return content;
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Scaffold(
              drawer: MyDrawer(),
              appBar: AppBar(
                iconTheme: Theme.of(context)
                    .iconTheme
                    .copyWith(color: Theme.of(context).accentColor),
                centerTitle: true,
                title: Text('تیکت ها',
                    style: Theme.of(context).textTheme.display2),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.arrow_forward,
                        color: Theme.of(context).accentColor),
                    onPressed: () => Navigator.pushNamed(context, '/homepage'),
                  )
                ],
              ),
              body: Stack(
                children: <Widget>[
                  makeTicketList(list),

                  /////////////////////////پیام جدید////////////////////////////
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                          padding: EdgeInsets.only(top: 5),
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          color: Colors.grey.shade800,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  if (model.userToken == null) {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Directionality(
                                            textDirection: TextDirection.rtl,
                                            child: AlertDialog(
                                              // title: Text('شرمنده'),
                                              content: Text(
                                                  'لطفا وارد پنل کاربری خود شوید'),
                                              actions: <Widget>[
                                                FlatButton(
                                                  onPressed: () =>
                                                      Navigator.of(context)
                                                          .pop(),
                                                  child: Text('بستن'),
                                                ),
                                                FlatButton(
                                                  onPressed: () => Navigator
                                                      .pushReplacementNamed(
                                                          context, '/login'),
                                                  child: Text('ورود'),
                                                ),
                                              ],
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              20.0))),
                                            ),
                                          );
                                        });
                                  } else {
                                    Navigator.pushReplacementNamed(
                                        context, '/addticket');
                                  }
                                },
                                child: Container(
                                  width: 125,
                                  child: Column(
                                    children: <Widget>[
                                      Icon(
                                        Icons.message,
                                        color: Theme.of(context).accentColor,
                                      ),
                                      Text(
                                        'پیام جدید',
                                        style: DarwerThemeData.textTheme.title,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, '/ticket');
                                },
                                child: Container(
                                  width: 125,
                                  child: Column(
                                    children: <Widget>[
                                      Icon(
                                        Icons.refresh,
                                        color: Theme.of(context).accentColor,
                                      ),
                                      Text(
                                        'بارگزاری',
                                        style: DarwerThemeData.textTheme.title,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ],
                  ),
                ],
              )),
    );
  }
}
