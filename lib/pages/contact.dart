import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../drawer.dart';
import '../scoped_model.dart';

class ContactPage extends StatefulWidget {
  final MainModel model;
  ContactPage(this.model);

  @override
  State<StatefulWidget> createState() {
    return _ContactPageState();
  }
}

class _ContactPageState extends State<ContactPage> {
  // static const menuItems = {'1':'1-title331','2':'2-title2','3':'2-title3'};
  String _selected;

  // final List<DropdownMenuItem<String>> _list = menuItems.entries
  //     .map((MapEntry<String,String> value) => DropdownMenuItem<String>(
  //           value: value.key,
  //           child: Text(value.value),
  //         ))
  //     .toList();
  final Map<String, dynamic> _formData = {
    'name': null,
    'email': null,
    'cell': null,
    'message': null,
    'subject': 0
  };
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  initState() {
    widget.model.fetchSubject();
    super.initState();
  }

  DecorationImage _buildBackgroundImage() {
    return DecorationImage(
      fit: BoxFit.cover,
      colorFilter:
          ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.dstATop),
      // image: AssetImage('assets/air.jpg'),
    );
  }

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
        if (value.isEmpty ||
            !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
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
        if (value.length != 11) {
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
      // obscureText: true,

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

  Widget _buildSubjectList() {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, MainModel model) {
         Widget content= Container(width: 0.0,height: 0.0,) ;
        if (model.contactSubjectList.length > 0 && !model.isLoading) {
            final List<DropdownMenuItem<String>> _subjectArr = [];
            model.contactSubjectList.forEach((subjectResponse) {
              _subjectArr.add(DropdownMenuItem<String>(
                value: subjectResponse.id,
                child: Text(subjectResponse.title),
              ));
            });

          content = DropdownButton(
              // value: _selected,
              hint: Text('انتخاب موضوع '),
              value: _selected,
              items: _subjectArr,
              onChanged: ((String newValue) {
                setState(() {
                  _selected = newValue;
                  _formData['subject'] = newValue;
                });
              }));
        } else if (model.isLoading) {
          content = Center(child: CircularProgressIndicator());
        }
        return content;
        // return RefreshIndicator(onRefresh: model.fetchSubject, child: content,) ;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;
    return Directionality(
      textDirection: TextDirection.rtl,
          child: Scaffold(
         appBar: AppBar(
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_forward , color: Colors.white,),
              onPressed: ()=>Navigator.pop(context),
            )
          ],
          title: Text('تماس با ما '),
        ),
        drawer: MyDrawer(),
        
        body: Container(
            // decoration: BoxDecoration(
            //   image: _buildBackgroundImage(),
            // ),
            padding: EdgeInsets.all(20.0),
            child: Center(
              child: SingleChildScrollView(
                child: Container(
                  width: targetWidth,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
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
                        _buildSubjectList(),
                        ScopedModelDescendant<MainModel>(
                          builder: (BuildContext context, Widget child,
                              MainModel model) {
                            return RaisedButton(
                              textColor: Colors.white,
                              child: Text('ارسال '),
                              onPressed: () => _submitForm(model.addContact),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
      ),
    );
  }
}
