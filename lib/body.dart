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
                toureType: 2,
              ),
              ToureScrollTitle(type: 2),
              CatDivider(
                title: 'تورهای ویژه داخلی',
                toureType: 1,
              ),
              ToureScrollTitle(type: 1),
            ],
          )),
    );
  }
}

class ToureScrollTitle extends StatelessWidget {
  final int type;

  const ToureScrollTitle({Key key, this.type}) : super(key: key);

  makeList(List<Toure> toure) {
    return ListView.builder(
      itemCount: toure.length,
      shrinkWrap: true,
      // ضروری است
      physics: ClampingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      reverse: true,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: ToureTitle(
            toure: toure[index],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Toure> _external = [];
    List<Toure> _inernal = [];
    return ScopedModelDescendant<MainModel>(
      builder: (context, child, model) {
        model.tourelist.forEach((toure) {
          /// جدا سازی و ساخت لیست از تورهای داخلی و خارجی
          switch (toure.foreign.toString()) {
            case "2":
              {
                _external.add(toure);
              }
              break;

            case "1":
              {
                _inernal.add(toure);
              }
              break;
          }
        });

        return SizedBox(
            height: 171,
            child: model.isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : type == 2 ? makeList(_external) : makeList(_inernal));
      },
    );
  }
}
