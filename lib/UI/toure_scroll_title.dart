import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../model/toure_model.dart';
import '../scoped_model.dart';
import 'touretitle.dart';

class ToureScrollTitle extends StatefulWidget {
  final List<Toure> toure;

  const ToureScrollTitle({Key key, this.toure}) : super(key: key);

  @override
  _ToureScrollTitleState createState() => _ToureScrollTitleState();
}

class _ToureScrollTitleState extends State<ToureScrollTitle> {
  makeList(List<Toure> toure) {
    return toure.length != 0 ? ListView.builder(
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
    ) : Center(
      child: Text('!هیچ توری موجود نیست'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (context, child, model) {
        return SizedBox(
            height: 200,
            child: model.isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : makeList(widget.toure));
      },
    );
  }
}
