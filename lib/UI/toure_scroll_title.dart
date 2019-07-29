import 'package:flutter/material.dart';
import 'package:hello_flutter/model/tourefilter_model.dart';
import 'package:scoped_model/scoped_model.dart';
import '../model/toure_model.dart';
import '../scoped_model.dart';
import 'touretitle.dart';

class ToureScrollTitle extends StatefulWidget {
  final int toureTypeindex;

  const ToureScrollTitle({Key key, this.toureTypeindex}) : super(key: key);

  @override
  _ToureScrollTitleState createState() => _ToureScrollTitleState();
}

class _ToureScrollTitleState extends State<ToureScrollTitle> {
  List<Toure> _toure = [];

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

  fetchtoure(toureindex) {
    MainModel model = ScopedModel.of(context);
    ToureFilterModel filter = ToureFilterModel(
        foreign: model.touretypes[toureindex]['foregin'],
        special: model.touretypes[toureindex]['special']);
    model.getTourData(filter: filter).whenComplete(() {
      _toure = model.tourelist;
    });
  }

  @override
  Widget build(BuildContext context) {
    fetchtoure(widget.toureTypeindex);
    return ScopedModelDescendant<MainModel>(
      builder: (context, child, model) {
        return SizedBox(
            height: 200,
            child: model.isLoading 
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : makeList(_toure));
      },
    );
  }
}
