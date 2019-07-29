import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../model/tourefilter_model.dart';
import '../model/toure_model.dart';
import '../scoped_model.dart';
import 'touretitle.dart';

class SpecialToureScrollTitle extends StatefulWidget {
  final int toureTypeindex;

  const SpecialToureScrollTitle({Key key, this.toureTypeindex})
      : super(key: key);

  @override
  _SpecialToureScrollTitleState createState() =>
      _SpecialToureScrollTitleState();
}

class _SpecialToureScrollTitleState extends State<SpecialToureScrollTitle> {
  List<Toure> _specialtoure = [];

  @override
  void initState() {
    super.initState();
    MainModel model = ScopedModel.of(context);
    ToureFilterModel sfilter = ToureFilterModel(
        foreign: model.touretypes[widget.toureTypeindex]['foregin'],
        special: model.touretypes[widget.toureTypeindex]['special']);
    fetchList(model, sfilter);
  }

  Future fetchList(MainModel model, ToureFilterModel filter) async {
    _specialtoure = await model.getTourData(filter: filter);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 200,
        child: _specialtoure.length == 0
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: _specialtoure.length,
                shrinkWrap: true,
                // ضروری است
                physics: ClampingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                reverse: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: ToureTitle(
                      toure: _specialtoure[index],
                    ),
                  );
                },
              ));
  }
}
