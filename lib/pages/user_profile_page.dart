import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../scoped_model.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (context, child, model) {
        
        return Scaffold(
          body: Center(
            child: FlatButton(
                child: Text('خروج از حساب کاربری'),
                onPressed: () {
                  model.setToken(null);
                  Navigator.pushNamed(context, '/');
                }),
          ),
        );
      },
    );
  }
}
