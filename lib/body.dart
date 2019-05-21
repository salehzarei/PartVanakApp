import 'package:flutter/material.dart';
import 'package:hello_flutter/UI/divider.dart';
import 'package:hello_flutter/UI/maincategorei.dart';
import 'package:hello_flutter/UI/touretitle.dart';

class HomeBody extends StatefulWidget {
  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              MainCategory(),
              CatDivider(),
              ToureScrollTitle(),
              CatDivider(),
              ToureScrollTitle(),
            ],
          )),
    );
  }
}

class ToureScrollTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /// برای نمایش لیست تورها باید حتما sizedbox باشد
    return SizedBox(
      height: 170,
      child: ListView.builder(
        itemCount: 5,
        shrinkWrap: true,
        // ضروری است
        physics: ClampingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        reverse: true,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: ToureTitle(),
          );
        },
      ),
    );
  }
}
