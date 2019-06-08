import 'package:flutter/material.dart';

class ChekOut extends StatelessWidget {
  final List<Widget> passengersList;

  const ChekOut({Key key, this.passengersList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        // backgroundColor: Theme.of(context).primaryColor,
        title: Text('صورتحساب',
            style: TextStyle(color: Colors.white, fontSize: 20)),
      ),
      //hit Ctrl+space in intellij to know what are the options you can use in flutter widgets
      body: Container(
        // textAlign: TextAlign.left,
        padding: EdgeInsets.all(5.0),
        child: Container(
          child: ListView(
            children: <Widget>[
              Card(
                child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            textDirection: TextDirection.rtl,
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  'نام ونام خانوادگی',
                                  textDirection: TextDirection.rtl,
                                  textAlign: TextAlign.right,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: Text('ابرا هیم عباسی',
                                      textDirection: TextDirection.rtl,
                                      textAlign: TextAlign.right))
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            textDirection: TextDirection.rtl,
                            children: <Widget>[
                              Expanded(
                                  child: Text('کدملی/پاسپورت ',
                                      textDirection: TextDirection.rtl,
                                      textAlign: TextAlign.right)),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: Text('0876523659',
                                      textDirection: TextDirection.rtl,
                                      textAlign: TextAlign.right))
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            textDirection: TextDirection.rtl,
                            children: <Widget>[
                              Expanded(
                                  child: Text('جنسیت',
                                      textDirection: TextDirection.rtl,
                                      textAlign: TextAlign.right)),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: Text('مرد',
                                      textDirection: TextDirection.rtl,
                                      textAlign: TextAlign.right))
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            textDirection: TextDirection.rtl,
                            children: <Widget>[
                              Expanded(
                                  child: Text('تاریخ تولد',
                                      textDirection: TextDirection.rtl,
                                      textAlign: TextAlign.right)),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: Text('1398/03/12',
                                      textDirection: TextDirection.rtl,
                                      textAlign: TextAlign.right))
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            textDirection: TextDirection.rtl,
                            children: <Widget>[
                              Expanded(
                                  child: Text('هزینه',
                                      textDirection: TextDirection.rtl,
                                      textAlign: TextAlign.right)),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: Text('1.200.000 تومان',
                                      textDirection: TextDirection.rtl,
                                      textAlign: TextAlign.right))
                            ],
                          ),
                        ),
                      ],
                    )),
              ),
              Card(
                child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            textDirection: TextDirection.rtl,
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  'مجموع مبلغ',
                                  textDirection: TextDirection.rtl,
                                  textAlign: TextAlign.right,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: Text('4.500.000 تومان',
                                      textDirection: TextDirection.rtl,
                                      textAlign: TextAlign.right))
                            ],
                          ),
                        ),
                      ],
                    )),
              ),
              Padding(
            padding: EdgeInsets.only(top: 25),
            child: MaterialButton(
              onPressed: () =>{},
              minWidth: 300,
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Text(
                'خرید و پرداخت',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              elevation: 2,
              color: Theme.of(context).accentColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
            ),
          ),
           Padding(
            padding: EdgeInsets.only(top: 25),
            child: MaterialButton(
              onPressed: () =>{},
              minWidth: 300,
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Text(
                'ویرایش',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              elevation: 2,
              color: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
            ),
          )
            ],
          ),
        ),
      ),
    );
  }
}
