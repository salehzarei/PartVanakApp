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
              ToureScrollTitle(type: 1),
              CatDivider(title: 'تورهای ویژه داخلی'),
              ToureScrollTitle(type: 2),
            ],
          )),
    );
  }
}

class ToureScrollTitle extends StatelessWidget {
  final int type;

  const ToureScrollTitle({Key key, this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Toure> toure = [];
    return ScopedModelDescendant<MainModel>(
      builder: (context, child, model) {
        switch (type.toString()) {
          case "1":
            {
              toure = model.tourelist;
            }
            break;

          case "2":
            {
              toure = model.tourelist;
            }
            break;
        }
        return SizedBox(
          height: 171,
          child: model.isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
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
                ),
        );
      },
    );
  }
}
