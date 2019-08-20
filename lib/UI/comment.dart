import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../model/comment_model.dart';
import 'package:scoped_model/scoped_model.dart';
import '../scoped_model.dart';

class CommentItem extends StatelessWidget {
  final Comment comment;

  const CommentItem({Key key, this.comment}) : super(key: key);

  Widget _replayComment(BuildContext context, Comment data) {
    Widget _content = Container(width: 0, height: 0);
    print('reply');
   
    if (data.replay != null && data.replay.length>0) {
       print(data.replay.length.toString()+'llll');
      _content = Container(
        padding: EdgeInsets.only(right: 25),
        child: Column(children: [
          Divider(),
          Row(
            textDirection: TextDirection.rtl,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.only(top: 3),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        height: 60,
                        imageUrl: comment.adminPic,
                        placeholder: (context, url) => SpinKitFadingFour(
                              color: Colors.red,
                              size: 50.0,
                            ),
                        errorWidget: (context, string, url) =>
                            Icon(Icons.error),
                      ),
                    ),
                  )),
              Expanded(
                flex: 3,
                child: ListView(
                  padding: EdgeInsets.only(right: 10, top: 5),
                  shrinkWrap: true,
                  children: <Widget>[
                    Text(
                      'پاسخ مدیر',
                      style: Theme.of(context).textTheme.headline,
                      softWrap: true,
                      textAlign: TextAlign.right,
                      textDirection: TextDirection.rtl,
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      textDirection: TextDirection.rtl,
                      children: <Widget>[
                        Icon(
                          Icons.calendar_today,
                          color: Theme.of(context).iconTheme.color,
                          size: 20,
                        ),
                        SizedBox(width: 5),
                        Text('${data.replayDate}')
                      ],
                    ),
                    Divider(),
                  ],
                ),
              )
            ],
          ),
          Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
              child: Text(
                data.replay,
                textAlign: TextAlign.right,
              )),
        ]),
      );
    }
    return _content;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(top: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: Colors.white,
      child: Column(children: [
        Row(
          textDirection: TextDirection.rtl,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.only(top: 3),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      height: 60,
                      imageUrl: comment.userPic,
                      placeholder: (context, url) => SpinKitFadingFour(
                            color: Colors.red,
                            size: 50.0,
                          ),
                      errorWidget: (context, string, url) => Icon(Icons.error),
                    ),
                  ),
                )),
            Expanded(
              flex: 3,
              child: ListView(
                padding: EdgeInsets.only(right: 10, top: 5),
                shrinkWrap: true,
                children: <Widget>[
                  Text(
                    '${comment.name}',
                    style: Theme.of(context).textTheme.headline,
                    softWrap: true,
                    textAlign: TextAlign.right,
                    textDirection: TextDirection.rtl,
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    textDirection: TextDirection.rtl,
                    children: <Widget>[
                      Icon(
                        Icons.calendar_today,
                        color: Theme.of(context).iconTheme.color,
                        size: 20,
                      ),
                      SizedBox(width: 5),
                      Text('${comment.cDate}')
                    ],
                  ),
                  Divider(),
                ],
              ),
            )
          ],
        ),
        Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
            child: Text(
              comment.message,
              textAlign: TextAlign.right,
            )),
        _replayComment(context, comment),
      ]),
    );
  }
}

class CommentForm extends StatefulWidget {
  MainModel model;
  int bId;

  CommentForm(this.bId);

  @override
  State<StatefulWidget> createState() {
    return _CommentFormState();
  }
}

class _CommentFormState extends State<CommentForm> {
  String _selected;

  final Map<String, dynamic> _formData = {
    "token": '',
    "name": '',
    "email": '',
    "cell": '',
    "message": '',
    "bId":''
  };
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildNameTextField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'نام و نام خانوادگی',
          filled: true,
          fillColor: Colors.white),
      keyboardType: TextInputType.emailAddress,
      validator: (String value) {
        if (value.isEmpty) {
          return 'این فیلد ضروریست ';
        }
      },
      onSaved: (String value) {
        _formData['name'] = value;
      },
    );
  }

  Widget _buildEmailTextField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: ' پست الکترونیک ‍', filled: true, fillColor: Colors.white),
      keyboardType: TextInputType.emailAddress,
      textAlign: TextAlign.left,
      validator: (String value) {
        if (value.length>0 && !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                .hasMatch(value)) {
          return 'پست الکترونیک معتبر وارد نمایید.';
        }
      },
      onSaved: (String value) {
        _formData['email'] = value;
      },
    );
  }

  Widget _buildCellTextField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'تلفن همراه', filled: true, fillColor: Colors.white),
      textAlign: TextAlign.left,
      maxLength: 11,
      validator: (String value) {
        if (value.length>0 && value.length != 11) {
          return 'تلفن همراه معتبر نیست.';
        }
      },
      keyboardType: TextInputType.number,
      onSaved: (String value) {
        _formData['cell'] = value;
      },
    );
  }

  Widget _buildMessageTextField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'متن پیام', filled: true, fillColor: Colors.white),

      validator: (String value) {
        if (value.isEmpty || value.length < 10) {
          return 'متن پیام ضروری و بیشتر از 10 حرف باشد.';
        }
      },
      maxLines: 3,
      keyboardType: TextInputType.text,
      onSaved: (String value) {
        _formData['message'] = value;
      },
    );
  }

  void _submitForm(Function addComment) {
    _formData['bId']=widget.bId.toString();

    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();

    addComment(_formData).then((bool success) {
      if (success) {
        _formKey.currentState.reset();
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: Colors.green,
                title: Text('Success'),
                content: Text('Operation success!'),
                actions: <Widget>[
                  FlatButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('Okay'),
                  )
                ],
              );
            });
      } else {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: Colors.red,
                title: Text('Something went wrong'),
                content: Text('Please try again!'),
                actions: <Widget>[
                  FlatButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('Okay'),
                  )
                ],
              );
            });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;
    return Container(
      child: SingleChildScrollView(
        child: Card(
          margin: EdgeInsets.only(top: 20,bottom: 10),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: Colors.white,
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(8),
                  child: Text('لطفا با نظرات خود مار را یاری فرمایید.'),
                  color: Colors.white,
                ),
                Divider(),
                _buildNameTextField(),
                SizedBox(
                  height: 10.0,
                ),
                _buildEmailTextField(),
                SizedBox(
                  height: 10.0,
                ),
                _buildCellTextField(),
                SizedBox(
                  height: 10.0,
                ),
                _buildMessageTextField(),
                SizedBox(
                  height: 10.0,
                ),
                ScopedModelDescendant<MainModel>(
                  builder:
                      (BuildContext context, Widget child, MainModel model) {
                    return  RaisedButton(
                              color: Colors.greenAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              onPressed: () => _submitForm(model.addComment),
                              child: model.isLoading
                                  ? CircularProgressIndicator()
                                  : Text(' ارسال '),
                            );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
