import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../scoped_model.dart';
import '../drawer.dart';
// import 'package:css_text/css_text.dart';
// import 'package:flutter_html/flutter_html.dart';
// import 'package:html/dom.dart' as dom;
class AboutUs extends StatefulWidget {
  final MainModel model;
  const AboutUs(this.model);

  @override
  State<StatefulWidget> createState() {
    return _AboutUsState();
  }
}

class _AboutUsState extends State<AboutUs> {
  @override
  void initState() {
    widget.model.getAboutData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Stack(
            //fit: StackFit.expand,
            //textDirection: TextDirection.rtl,
            children: <Widget>[
              Container(
                child: Image.network(
                  'https://images.unsplash.com/photo-1500835556837-99ac94a94552?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
                  fit: BoxFit.cover,
                ),
              ),
              Scaffold(
                  backgroundColor: Colors.transparent,
                  drawer: MyDrawer(),
                  appBar: AppBar(
                    elevation: 0.0,
                    backgroundColor: Colors.transparent,
                    centerTitle: true,
                    iconTheme: Theme.of(context).iconTheme,
                    title: Text(
                      'درباره ما',
                      style: Theme.of(context).textTheme.title,
                    ),
                  ),
                  body: Stack(children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 80, bottom: 60, left: 15, right: 15),
                      child: ListView(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10, right: 10, left: 10),
                            child: RichText(
                                textDirection: TextDirection.rtl,
                                overflow: TextOverflow.fade,
                                text: TextSpan(
                                    text:
                                        " ${model.aboutmodel.about} ${model.aboutmodel.about} ${model.aboutmodel.about}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .body1
                                        .copyWith(
                                            color: Colors.white,
                                            fontSize: 15))),
                          ),

                          Row(
                            textDirection: TextDirection.rtl,
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  'نام متصدی :',
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  '${model.aboutmodel.name}',
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),

                          // _buildCell(),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Container(
                        // width: MediaQuery.of(context).size.width,
                        height: 80,
                        alignment: Alignment.center,
                        color: Colors.transparent,
                        child: Image.asset(
                          'images/logo.png',
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 545, left: 15, right: 15),
                      child: Material(
                        color: Colors.transparent,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Theme.of(context)
                                  .accentColor
                                  .withOpacity(0.7)),
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Image.asset('images/instagram.png')),
                              SizedBox(
                                width: 15,
                              ),
                              InkWell(
                                  onTap: () {},
                                  child: Image.asset('images/telegram.png')),
                              SizedBox(
                                width: 15,
                              ),
                              InkWell(
                                  onTap: () {},
                                  child: Image.asset('images/twitter.png')),
                              SizedBox(
                                width: 15,
                              ),
                              InkWell(
                                  onTap: () {},
                                  child: Image.asset('images/facebook.png')),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ])),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCell() {
    Widget content = Container(
      width: 0.0,
      height: 0.0,
    );
    return content;
    // return ScopedModelDescendant(
    //   builder: (BuildContext context, Widget child, MainModel model) {
    //     if (model.contactSubjectList.length > 0 && !model.isLoading) {
    //       final List<DropdownMenuItem<String>> _subjectArr = [];
    //       model.contactSubjectList.forEach((subjectResponse) {
    //         _subjectArr.add(DropdownMenuItem<String>(
    //           value: subjectResponse.id,
    //           child: Text(subjectResponse.title),
    //         ));
    //       });

    //       content = DropdownButton(
    //           // value: _selected,
    //           hint: Text('انتخاب موضوع '),
    //           value: _selected,
    //           items: _subjectArr,
    //           onChanged: ((String newValue) {
    //             setState(() {
    //               _selected = newValue;
    //               _formData['subject'] = newValue;
    //             });
    //           }));
    //     } else if (model.isLoading) {
    //       content = Center(child: CircularProgressIndicator());
    //     }
    //     return RefreshIndicator(onRefresh: model.fetchSubject, child: content,) ;
    //   },
    // );
  }
}
