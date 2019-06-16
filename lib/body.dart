import 'package:flutter/material.dart';
import './UI/divider.dart';
import './UI/maincategorei.dart';
import './UI/touretitle.dart';
import './scoped_model.dart';
import 'package:scoped_model/scoped_model.dart';

class HomeBody extends StatefulWidget {
  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: ScopedModelDescendant<MainModel>(
            builder: (context,child,model){
              Widget _tour_listin_main = ToureScrollTitle();
              if(model.isLoading) _tour_listin_main = CircularProgressIndicator();
              return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              MainCategory(),
              CatDivider(),
              _tour_listin_main,
              CatDivider(),
              _tour_listin_main,
            ],
          );
            },
          ) ),
    );
  }
}

class ToureScrollTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /// برای نمایش لیست تورها باید حتما sizedbox باشد
    return ScopedModelDescendant<MainModel>(
      builder: (context,child,model){
        return SizedBox(
      height: 171,
      child: ListView.builder(
        itemCount: model.tourelist.length,
        shrinkWrap: true,
        // ضروری است
        physics: ClampingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        reverse: true,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: ToureTitle(
              toure: model.tourelist[index],
            ),
          );
        },
      ),
    );
      },
    );
  }
}
