import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import './UI/toure_list_item.dart';
import './scoped_model.dart';
import './toureDetile.dart';
import 'model/toure_model.dart';

class ToureListPage extends StatefulWidget {
  final int type;

  const ToureListPage({Key key, this.type}) : super(key: key);

  @override
  _ToureListPageState createState() => _ToureListPageState();
}

class _ToureListPageState extends State<ToureListPage> {
  String _title;
  List<Toure> _toure;

  @override
  void initState() {
    super.initState();
    MainModel model = ScopedModel.of(context);
    switch (widget.type.toString()) {
      case "1":
        {
          _title = 'تورهای خارجی';
          _toure = model.tourelist;
        }
        break;

      case "2":
        {
          _title = 'تورهای داخلی';
          _toure = model.tourelist;
        }
        break;

      default:
        {
          _title = 'همه تورها';
          _toure = model.tourelist;
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(_title),
      ),
      body: Stack(
          // fit: StackFit.expand,
          textDirection: TextDirection.rtl,
          children: <Widget>[
            ScopedModelDescendant<MainModel>(
              builder: (context, child, model) {
                return ListView.builder(
                  itemCount: _toure.length,
                  padding: EdgeInsets.only(top: 50, left: 3, right: 3),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ToureDetilePage(
                                    toure: _toure[index],
                                  ))),
                      child: model.isLoading
                          ? Center(child: CircularProgressIndicator())
                          : ToureListItem(
                              toure: _toure[index],
                            ),
                    );
                  },
                );
              },
            ),
            Container(
              color: Colors.white,
              height: 45,
              child: Padding(
                padding: const EdgeInsets.only(top: 10, right: 5),
                child: Row(
                  textDirection: TextDirection.rtl,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text("فیلترکردن"),
                        Icon(Icons.filter_list),
                      ],
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Row(
                      children: <Widget>[
                        Text("مرتب سازی"),
                        Icon(Icons.sort),
                      ],
                    )
                  ],
                ),
              ),
            )
          ]),
    );
  }
}
