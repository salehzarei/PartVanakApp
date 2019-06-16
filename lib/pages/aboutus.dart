import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;
import 'package:scoped_model/scoped_model.dart';
import '../scoped_model.dart';

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
    // final _top= MediaQuery.of(context).size.height;
    final _text_long =
        'خرید آنلاین بلیط هواپیما خارجیخرید آنلاین بلیط هواپیما خارجیخرید آنلاین بلیط هواپیما خارجیخرید آنلاین بلیط هواپیما خارجیخرید آنلاین بلیط هواپیما خارجیخرید آنلاین بلیط هواپیما خارجیخرید آنلاین بلیط هواپیما خارجیخرید آنلاین بلیط هواپیما خارجیخرید آنلاین بلیط هواپیما خارجیخرید آنلاین بلیط هواپیما خارجیخرید آنلاین بلیط هواپیما خارجیخرید آنلاین بلیط هواپیما خارجیخرید آنلاین بلیط هواپیما خارجیخرید آنلاین بلیط هواپیما خارجیخرید آنلاین بلیط هواپیما خارجیخرید آنلاین بلیط هواپیما خارجیخرید آنلاین بلیط هواپیما خارجیخرید آنلاین بلیط هواپیما خارجیخرید آنلاین بلیط هواپیما خارجیخرید آنلاین بلیط هواپیما خارجیخرید آنلاین بلیط هواپیما خارجیخرید آنلاین بلیط هواپیما خارجیخرید آنلاین بلیط هواپیما خارجیخرید آنلاین بلیط هواپیما خارجی';
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        print(model.aboutmodel.cell);
        return Stack(
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
              appBar: AppBar(
                actions: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: //Icon(
                        //   Icons.airplanemode_active,
                        //   color: Theme.of(context).accentColor,
                        //   size: 30,
                        // ),
                        InkWell(
                      onTap: () {},
                      child: Image.asset('images/logo.png'),
                    ),
                  ),
                ],
                elevation: 0.0,
                backgroundColor: Colors.transparent,
                centerTitle: true,
                iconTheme: Theme.of(context).iconTheme,
                title: Text(
                  'درباره ما',
                  style: Theme.of(context).textTheme.title,
                ),
              ),
              body: Stack(
                //fit: StackFit.expand,
                alignment: Alignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.black26.withOpacity(0.2),
                      ),
                      child: ListView(
                        children: <Widget>[
                          Html(
                            defaultTextStyle: TextStyle(color: Colors.white),
                            data: """
                            ${model.aboutmodel.about}
                                    """,
                            padding: EdgeInsets.all(15.0),
                            customRender: (node, children) {
                              if (node is dom.Element) {
                                switch (node.localName) {
                                  case "custom_tag":
                                    return Column(children: children);
                                }
                              }
                            },
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
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 600),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Theme.of(context).accentColor.withOpacity(0.5)),
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
            )
          ],
        );
      },
    );
  }


Widget _buildCell() {
    Widget content= Container(width: 0.0,height: 0.0,) ;
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
