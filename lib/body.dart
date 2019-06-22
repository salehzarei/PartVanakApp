import 'package:flutter/material.dart';
import './UI/divider.dart';
import './UI/maincategorei.dart';
import './UI/touretitle.dart';
import './scoped_model.dart';
import 'package:scoped_model/scoped_model.dart';

import 'model/toure_model.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              MainCategory(),
              CatDivider(
                title: 'تورهای ویژه خارجی',
              ),
              ToureScrollTitle(),
              CatDivider(title: 'تورهای ویژه داخلی'),
              ToureScrollTitle(),
            ],
          )),
    );
  }
}

class ToureScrollTitle extends StatefulWidget {
  final String query;

  const ToureScrollTitle({Key key, this.query}) : super(key: key);

  @override
  _ToureScrollTitleState createState() => _ToureScrollTitleState();
}

class _ToureScrollTitleState extends State<ToureScrollTitle> {
  List<Toure> toure = [];
  @override
  void initState() {
    MainModel model = ScopedModel.of(context);
    model.getTourData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /// برای نمایش لیست تورها باید حتما sizedbox باشد
    return ScopedModelDescendant<MainModel>(
      builder: (context, child, model) {
        return SizedBox(
          height: 171,
          child: ListView.builder(
            itemCount: model.foreign.length,
            shrinkWrap: true,
            // ضروری است
            physics: ClampingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            reverse: true,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: ToureTitle(
                  toure: model.foreign[index],
                ),
              );
            },
          ),
        );
      },
    );
  }
}


