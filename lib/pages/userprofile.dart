import 'package:flutter/material.dart';
import '../Theme/drawerTheme.dart';
import '../scoped_model.dart';
import 'package:scoped_model/scoped_model.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(builder: (context, child, model) {
      return model.userToken != null
          ? ListView(
            shrinkWrap: true,
              children: <Widget>[
                Container(
                  width: 20,
                  child: ListTile(
                    trailing: Icon(
                      Icons.edit,
                      color: Colors.white,
                      size: 20,
                    ),
                    title: Text(
                      'ابراهیم عباسی',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    dense: true,
                    onTap: () => Navigator.pushNamed(context, '/userprofile'),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text('تلفن : 09154127181',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 15.0, right: 15),
                  height: 1,
                  decoration: BoxDecoration(
                      color: Theme.of(context).accentColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          bottomLeft: Radius.circular(5))),
                ),
              ],
            )
          : GestureDetector(
              onTap: () => Navigator.pushNamed(context, '/login'),
              child: Container(
                width: 20,
                color: Theme.of(context).cardColor.withOpacity(0.7),
                margin: EdgeInsets.only(top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Container(
                        width: 110,
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 10, top: 5),
                              child: Icon(
                                Icons.account_circle,
                                color: Colors.black.withOpacity(0.5),
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'ورود/ثبت نام',
                              style: DarwerThemeData.textTheme.title,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
    });
  }
}
