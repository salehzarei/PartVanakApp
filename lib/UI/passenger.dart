import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../scoped_model.dart';
import '../model/passenger_model.dart';
import '../UI/userform.dart';
import '../UI/chekout.dart';

class Passenger extends StatefulWidget {
  final List<String> personcount;

  const Passenger({Key key, this.personcount}) : super(key: key);

  @override
  _PassengerState createState() => _PassengerState();
}

class _PassengerState extends State<Passenger> {
  int _itemCount;

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
          type: widget.personcount[i],
          family: '',
          name: '',
          brith: '',
          melicode: '',
          sex: '');
      model.passengers.add(_passenger);
    }
    _itemCount = model.passengers.length;
    // }
  }

  void onDelete(int index, MainModel model) {
    print("Run OnDelete for $index");
    model.deleteFromList(index);
    setState(() {
      _itemCount = model.passengers.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (context, child, model) {
        model.userFormKey.clear();
        return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              iconTheme: Theme.of(context)
                  .iconTheme
                  .copyWith(color: Theme.of(context).accentColor),
              title: Text(
                'مشخصات مسافرین',
                style: TextStyle(
                    color: Theme.of(context).accentColor, fontSize: 20),
              ),
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
                      bool b = true;
                      model.userFormKey.forEach((index) {
                        if (!index.currentState.validate()) {
                          b = false;
                          return;
                        }
                        index.currentState.save();
                      });

                      if (b)
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChekOut(
                                      passengerlist: model.passengers,
                                    )));
                    })
              ],
            ),
            body: Directionality(
                textDirection: TextDirection.rtl,
                child: Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: ListView.builder(
                      addAutomaticKeepAlives: true,
                      itemCount: _itemCount,
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return UserForm(
                            index: index,
                          );
                        } else {
                          return Dismissible(
                            direction: DismissDirection.startToEnd,
                            background: Container(
                              alignment: Alignment.centerRight,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.delete,
                                      size: 30,
                                      color: Colors.red,
                                    ),
                                    Text("حذف",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline
                                            .copyWith(color: Colors.red))
                                  ],
                                ),
                              ),
                            ),
                            key: Key(model.passengers[index].id),
                            onDismissed: (direction) {
                              onDelete(index, model);
                            },
                            child: UserForm(
                              index: index,
                            ),
                          );
                        }
                      },
                    ))));
      },
    );
  }
}
