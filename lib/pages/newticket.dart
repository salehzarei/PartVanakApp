import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hello_flutter/drawer.dart';
import 'package:image_picker/image_picker.dart';

class NewTicket extends StatefulWidget {
  @override
  _NewTicketState createState() => _NewTicketState();
}

class _NewTicketState extends State<NewTicket> {
  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          drawer: MyDrawer(),
          appBar: AppBar(
            iconTheme: Theme.of(context)
                .iconTheme
                .copyWith(color: Theme.of(context).accentColor),
            centerTitle: true,
            title: Text('تیکت ها', style: Theme.of(context).textTheme.display2),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.arrow_forward,
                    color: Theme.of(context).accentColor),
                onPressed: () => Navigator.pushNamed(context, '/ticket'),
              )
            ],
          ),
          body: Stack(
            children: <Widget>[
              ListView(
                children: <Widget>[
                  Card(
                    color: Colors.grey.shade700,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: TextFormField(
                        decoration: InputDecoration(
                            labelStyle: TextStyle(color: Colors.white),
                            labelText: 'موضوع پیام',
                            filled: true,
                            fillColor: Colors.transparent),
                        textAlign: TextAlign.right,
                        keyboardType: TextInputType.text,
                        textDirection: TextDirection.rtl,
                      ),
                    ),
                  ),
                  Card(
                    color: Colors.grey.shade700,
                    child: TextFormField(
                      decoration: InputDecoration(
                          labelStyle: TextStyle(color: Colors.white),
                          labelText: 'متن پیام',
                          filled: true,
                          fillColor: Colors.transparent),
                      textAlign: TextAlign.right,
                      maxLines: 10,
                      keyboardType: TextInputType.text,
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                  Container(
                    height: 50,
                    child: Card(
                      child: RaisedButton.icon(
                        label: Text('ارسال عکس'),
                        icon: Icon(Icons.camera),
                        onPressed: () {
                          print('ارسال عکس');
                          _image != null ? Image.file(_image) : getImage();
                        },
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                    child: Card(
                      child: RaisedButton(
                        child: Text('ارسال'),
                        onPressed: () {
                          print('ارسال');
                        },
                      ),
                    ),
                  ),
                  Container(
                    height: 3,
                    color: Colors.black,
                    width: MediaQuery.of(context).size.width,
                  ),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Row(
                            children: <Widget>[
                              Text('مدیریت'),
                              SizedBox(
                                width: 3,
                              ),
                              Text('1398/05/28'),
                              SizedBox(
                                width: 3,
                              ),
                              Text('09:30:00'),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          child: Text('سلام'),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          child: Image.asset('images/air.jpg'),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          color: Colors.black,
                          height: 2,
                          width: MediaQuery.of(context).size.width,
                        )
                      ],
                    ),
                  ),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Row(
                            children: <Widget>[
                              Text('مدیریت'),
                              SizedBox(
                                width: 3,
                              ),
                              Text('1398/05/28'),
                              SizedBox(
                                width: 3,
                              ),
                              Text('09:30:00'),
                            ],
                          ),
                        ),
                        Container(
                          child: Text('سلام'),
                        ),
                        // Container(
                        //   child: Image.asset('images/air.jpg'),
                        // ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          color: Colors.black,
                          height: 2,
                          width: MediaQuery.of(context).size.width,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ],
          )),
    );
  }
}
