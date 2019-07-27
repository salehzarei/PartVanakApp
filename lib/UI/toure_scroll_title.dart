import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../model/toure_model.dart';
import '../scoped_model.dart';
import 'touretitle.dart';

class ToureScrollTitle extends StatelessWidget {
  final int toureTypeindex;

  const ToureScrollTitle({Key key, this.toureTypeindex}) : super(key: key);

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
            height: 200,
            child: model.isLoading || toureTypeindex > 1 
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : toureTypeindex == 0 ? makeList(_external) : makeList(_inernal));
      },
    );
  }
}
