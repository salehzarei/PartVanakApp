import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hello_flutter/drawer.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../scoped_model.dart';
import '../model/ticket_model.dart';

class Reply extends StatefulWidget {
  int id;
  @override
  _NewReplyState createState() => _NewReplyState();
  Reply(this.id);
}

class _NewReplyState extends State<Reply> {
  File _image;
  MainModel model = new MainModel();
  var isLoading = true;
  var addLoading = false;
  List<ReplyModel> list = List();
  Map<String, dynamic> dataFrom = {};
  String subject;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future getImage() async {
    // file = await ImagePicker.pickImage(source: ImageSource.camera);
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
      print ('_image');
      print (_image);

      print(_image);
        dataFrom['pic'] =  base64Encode(_image.readAsBytesSync());
      print (base64Encode(_image.readAsBytesSync()));
    });
  }

  _getConversation() async {
    final response = await http.post(model.host + 'tickets/show',
        body: {'token': model.userToken, 'ticketId': widget.id.toString()});
    if (response.statusCode == 200) {
      Map data = json.decode(response.body);
      setState(() {
        list = (data['ticket'] as List)
            .map((d) => new ReplyModel.fromJson(d))
            .toList();
        // model.getToken().then((_) {
        //   if (model.userToken != null) {
        //     dataFrom['token'] = model.userToken;
        //   }
        // });
        dataFrom['token'] = model.userToken;
        dataFrom['replyId'] = data['replyId'].toString();
        dataFrom['tId'] = data['tId'].toString();
        
        subject = data['subject'];
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load ticket');
    }
  }

  Future<bool> add() {
    setState(() {
      addLoading = true;
    });
    print(dataFrom);

     return http
        .post(model.host + 'tickets/replay',
            encoding: Encoding.getByName('utf-8'), body: dataFrom)
        .then((http.Response response) {
          print(response.statusCode);

      if (response.statusCode != 200 && response.statusCode != 201) {
        setState(() {
          addLoading = false;
        });
        print(1);
        return false;
      }

      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['error']) {
        setState(() {
          addLoading = false;
        });
        print(2);
        return false;
      }

      setState(() {
        addLoading = false;
      });
      return true;
    }).catchError((error) {
      setState(() {
        addLoading = false;
      });
      print(3);
      return false;
    });
  }

  @override
  void initState() {
    model.getToken().then((_) {
      if (model.userToken != null) {
        _getConversation();
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
                drawer: MyDrawer(),
                appBar: AppBar(
                  iconTheme: Theme.of(context)
                      .iconTheme
                      .copyWith(color: Theme.of(context).accentColor),
                  centerTitle: true,
                  title: Text(subject,
                      style: Theme.of(context).textTheme.display2),
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
                        Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              Card(
                                  color: Colors.grey.shade700,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      //prefixStyle: TextStyle(color: Colors.white),
                                      labelStyle:
                                          TextStyle(color: Colors.white),
                                      labelText: 'متن پیام',
                                      filled: true,
                                      fillColor: Colors.transparent,
                                    ),
                                    validator: (String value) {
                                      if (value.isEmpty || value.length < 10) {
                                        return 'متن پیام ضروری و بیشتر از 10 حرف باشد.';
                                      }
                                    },
                                    onSaved: (String value) {
                                      dataFrom['message'] = value;
                                    },
                                    textAlign: TextAlign.right,
                                    maxLines: 10,
                                    keyboardType: TextInputType.text,
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(color: Colors.white),
                                  )),
                              Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width,
                                child: Card(
                                  child: RaisedButton.icon(
                                    label: Text('ارسال عکس'),
                                    icon: Icon(Icons.camera),
                                    onPressed: () {
                                      _image != null
                                          ? Image.file(_image)
                                          : getImage();
                                    },
                                  ),
                                ),
                              ),
                              Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width,
                                child: Card(
                                  child: RaisedButton(
                                      child: addLoading
                                          ? Container(
                                              color: Colors.red,
                                              child:
                                                  CircularProgressIndicator(),
                                            )
                                          : Text(' ارسال '),
                                      onPressed: () {
                                        if (!_formKey.currentState.validate()) {
                                          return;
                                        }
                                        _formKey.currentState.save();
                                        add().then((bool success) {
                                          print(success);
                                          if (success) {
                                            _formKey.currentState.reset();
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    backgroundColor:
                                                        Colors.green,
                                                    title: Text('Success'),
                                                    content: Text(
                                                        'Operation success!'),
                                                    actions: <Widget>[
                                                      FlatButton(
                                                        onPressed: () =>
                                                            Navigator.of(
                                                                    context)
                                                                .pop(),
                                                        child: Text('Okay'),
                                                      )
                                                    ],
                                                  );
                                                });
                                            _getConversation();
                                          } else {
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    backgroundColor: Colors.red,
                                                    title: Text(
                                                        'Something went wrong'),
                                                    content: Text(
                                                        'Please try again!'),
                                                    actions: <Widget>[
                                                      FlatButton(
                                                        onPressed: () =>
                                                            Navigator.of(
                                                                    context)
                                                                .pop(),
                                                        child: Text('Okay'),
                                                      )
                                                    ],
                                                  );
                                                });
                                          }
                                        });
                                      }),
                                ),
                              ),
                            ],
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
                            children: _buiLdConversation(list),
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
          );
  }

  List<Widget> _buiLdConversation(List<ReplyModel> replyList) {
    List<Widget> _content = [Center(child: Text('موردی یافت نشد'))];
    if (replyList.length > 0) {
      _content = [];
      replyList.forEach((ReplyModel d) {
        _content.add(Wrap(
          children: <Widget>[
            Container(
              child: Row(
                children: <Widget>[
                  Text(d.sender),
                  SizedBox(
                    width: 3,
                  ),
                  Text(d.date),
                  SizedBox(
                    width: 3,
                  )
                ],
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Container(
              child: Text(d.message),
            ),
            SizedBox(
              width: 10,
            ),
            d.pic != null
                ? Container(
                    child: Image.network(d.pic),
                  )
                : Container(),
            SizedBox(
              height: 10,
            ),
            Container(
              color: Colors.black,
              height: 2,
              width: MediaQuery.of(context).size.width,
            )
          ],
        ));
      });
    }

    return _content;
  }
}
