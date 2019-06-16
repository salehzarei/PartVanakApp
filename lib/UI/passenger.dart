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

  void onDelete(int index) {
    print("Run OnDelete for $index");
    
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (context, child, model) {
        model.userFormKey.clear();
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
                      model.userFormKey.forEach((index) {
                        index.currentState.save();
                      });
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
                      itemCount: model.passengers.length,
                      itemBuilder: (context, index) {
                        return UserForm(
                          index: index,
                          onDelete: onDelete ,
                        );
                      },
                    ))));
      },
    );
  }
}
