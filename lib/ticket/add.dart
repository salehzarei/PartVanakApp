import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hello_flutter/drawer.dart';
import 'package:image_picker/image_picker.dart';

import 'package:http/http.dart' as http;

import '../scoped_model.dart';
import '../model/ticket_model.dart';

class Add extends StatefulWidget {
  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {
  
  Map<String, dynamic> dataFrom = {};
  String subject;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var addLoading = false;

  MainModel model = new MainModel();

  Future getImage() async {
    // file = await ImagePicker.pickImage(source: ImageSource.camera);
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        dataFrom['pic'] = base64Encode(image.readAsBytesSync());
      });
    }
  }

  Future<bool> addTicket() {
    setState(() {
      addLoading = true;
    });

    return http
        .post(model.host + 'tickets/add',
            encoding: Encoding.getByName('utf-8'), body: dataFrom)
        .then((http.Response response) {
      if (response.statusCode != 200 && response.statusCode != 201) {
        setState(() {
          addLoading = false;
        });
        return false;
      }

      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['error']) {
        setState(() {
          addLoading = false;
        });
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
      return false;
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
          body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Card(
                    color: Colors.grey.shade700,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: TextFormField(
                        decoration: InputDecoration(
                            labelStyle: TextStyle(color: Colors.white),
                            errorStyle: TextStyle(
                            color: Colors.redAccent,
                            // fontSize: 16,
                          ),
                            labelText: 'موضوع پیام',
                            filled: true,
                            fillColor: Colors.transparent),
                        validator: (String value) {
                          if (value.isEmpty || value.length < 10) {
                            return 'وارد کردن این فیلد ضروری می باشد.';
                          }
                        },
                        onSaved: (String value) {
                          dataFrom['subject'] = value;
                        },
                        textAlign: TextAlign.right,
                        keyboardType: TextInputType.text,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Card(
                      color: Colors.grey.shade700,
                      child: TextFormField(
                        decoration: InputDecoration(
                          errorStyle: TextStyle(
                            color: Colors.redAccent,
                            // fontSize: 16,
                          ),
                          labelStyle: TextStyle(color: Colors.white),
                          labelText: 'متن پیام',
                          filled: true,
                          fillColor: Colors.transparent,
                        ),
                        validator: (String value) {
                          if (value.isEmpty || value.length < 10) {
                            return 'متن پیام ضروری و باید بیشتر از 10 حرف باشد';
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
                          getImage();
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
                            ? CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.red),
                              )
                            : Text('ارسال'),
                        onPressed: () {
                          if (!_formKey.currentState.validate()) {
                            return;
                          }

                          _formKey.currentState.save();
                          model.getToken().then((_) {
                            dataFrom['token'] = model.userToken;
                            addTicket().then((bool success) {
                              if (success) {
                                _formKey.currentState.reset();
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: AlertDialog(
                                          title: Text('توجه'),
                                          content:
                                              Text('پیام شما با موفقیت ثبت شد'),
                                          actions: <Widget>[
                                            FlatButton(
                                              onPressed: () => Navigator
                                                  .pushReplacementNamed(
                                                      context, '/ticket'),
                                              child: Text('بستن'),
                                            )
                                          ],
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20.0))),
                                        ),
                                      );
                                    });
                              } else {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: AlertDialog(
                                          title: Text('توجه'),
                                          content: Text('پیام شما ثبت نگردید'),
                                          actions: <Widget>[
                                            FlatButton(
                                              onPressed: () =>
                                                  Navigator.of(context).pop(),
                                              child: Text('بستن'),
                                            )
                                          ],
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20.0))),
                                        ),
                                      );
                                    });
                              }
                            });
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
