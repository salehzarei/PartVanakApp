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
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        children: <Widget>[MainCategory(), CatDivider(), ToureTitle(),CatDivider(),],
      ),
    );
  }
}
