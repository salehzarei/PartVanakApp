import 'package:flutter/material.dart';
import 'package:hello_flutter/model/tourefilter_model.dart';
import 'package:hello_flutter/model/user_model.dart';
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
  void initState() {
    super.initState();

    MainModel model = ScopedModel.of(context);
    ToureFilterModel filter = ToureFilterModel(special: '2');
    model.getTourData(filter: filter);
  }

  @override
  Widget build(BuildContext context) {
    List<Toure> _external = [];
    List<Toure> _inernal = [];
    return ScopedModelDescendant<MainModel>(
      builder: (context, child, model) {
        // List<String> s=string.split(":");

        return SizedBox(
            height: 200,
            child: model.isLoading || widget.toureTypeindex > 1
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : widget.toureTypeindex == 0
                    ? makeList(_external)
                    : makeList(_inernal));
      },
    );
  }
}
