import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../scoped_model.dart';
import '../model/passenger_model.dart';
import '../UI/userform.dart';

class Passenger extends StatefulWidget {
  final List<String> personcount;

  const Passenger({Key key, this.personcount}) : super(key: key);

  @override
  _PassengerState createState() => _PassengerState();
}

class _PassengerState extends State<Passenger> {
  @override
  void initState() {
    super.initState();
    // تبدیل لیست به مپ برای سهولت در انجام حذف لیست
    // for (var i = 0; i < widget.personcount.length; i++) {
    //   passengerListMap[i.toString()] = UserForm(type: widget.personcount[i]);

// ساخت یک لیست خالی از مسافرین
    MainModel model = ScopedModel.of(context);
    // خالی کردن لیست قبلی
    model.passengers.clear();
    widget.personcount.sort();
    for (var i = 0; i < widget.personcount.length; i++) {
      //// مشخص کردن تیتر هر مسافر
      String _title;
      switch (widget.personcount[i]) {
        case "a":
          {
            _title = 'مشخصات بزرگسال';
          }
          break;

        case "b":
          {
            _title = 'مشخصات نوجوان';
          }
          break;

        case "c":
          {
            _title = 'مشخصات کودک';
          }
          break;

        case "d":
          {
            _title = 'مشخصات نوزاد';
          }
          break;

        default:
          {
            _title = 'نامشخص';
          }
          break;
      }
      // اضافه کردن مسافر بدون نام و مشخصات به لیست مسافران
      PassengerModel _passenger = PassengerModel(
          id: i.toString(),
          title: _title,
          family: '',
          name: '',
          brith: '',
          melicode: '',
          sex: '');
      model.passengers.add(_passenger);
    }

    // }
  }

  void saveForm(MainModel model) {
    if (model.passengers.length > 0) {
      Navigator.push(
        context,
        MaterialPageRoute(
            fullscreenDialog: true,
            builder: (_) => Directionality(
                  textDirection: TextDirection.rtl,
                  child: Scaffold(
                    appBar: AppBar(
                      title: Text('List of Users'),
                    ),
                    body: ListView.builder(
                      itemCount: model.passengers.length,
                      itemBuilder: (_, i) => ListTile(
                            leading: CircleAvatar(
                              child: Text(model.passengers[i].id),
                            ),
                            //  title: Text(model.passengers[i].name),
                            subtitle: Text(model.passengers[i].title),
                          ),
                    ),
                  ),
                )),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    //var keys = selectedPersonList.keys.toList();
    return ScopedModelDescendant<MainModel>(
      builder: (context, child, model) {
        return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text('مشخصات مسافرین'),
              actions: <Widget>[
                FlatButton(
                    child: Text(
                      'تایید',
                      style: Theme.of(context)
                          .textTheme
                          .title
                          .copyWith(color: Colors.white, fontSize: 15),
                    ),
                    onPressed: () {
                      saveForm(model);
                    }
                    // => Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => ChekOut(
                    //               passengerlist: model.passengers,
                    //             ))),
                    )
              ],
            ),
            body: Directionality(
                textDirection: TextDirection.rtl,
                child: Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: ListView.builder(
                      // itemCount: keys.length,
                      addAutomaticKeepAlives: true,
                      itemCount: model.passengers.length,
                      itemBuilder: (context, index) {
                        //  String _key = keys[index];
                        return UserForm(
                          index: index,
                        );
                      },
                    ))));
      },
    );
  }
}
