import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../model/passenger_model.dart';

class ChekOut extends StatelessWidget {
  final List<Passenger> passengersList;

  const ChekOut({Key key, this.passengersList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // List<DataCell> _dataCells = ['عبدالصالح زارعی', '0941716244', '1363/12/12']
    //     .map((c) => DataCell(Text(c)))
    //     .toList();

    ///
    List<Passenger> pList = [
      Passenger(
          name: 'هبدالصالح',
          family: 'زارعی',
          melicode: '09417162444',
          brith: '1363/12/12',
          sex: 'مرد'),
      Passenger(
          name: 'محمدرضا',
          family: 'برومند',
          melicode: '1561561565',
          brith: '1363/12/12',
          sex: 'مرد'),
      Passenger(
          name: 'ابراهیم',
          family: 'عباسی',
          melicode: '0972166255',
          brith: '1363/12/12',
          sex: 'مرد')
    ];

    List<DataRow> listpassanger = pList
        .map((i) => DataRow(cells: [
              DataCell(Text(i.name + " " + i.family , style: Theme.of(context).textTheme.subtitle)),
              DataCell(Text(i.melicode, style: Theme.of(context).textTheme.subtitle)),
              DataCell(Text(i.brith, style: Theme.of(context).textTheme.subtitle)),
            ]))
        .toList();

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
                          padding: const EdgeInsets.symmetric(vertical: 3),
                          child: Text(
                            'مشخصات خریدار اصلی',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).accentColor),
                          ),
                        ),
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
                      ],
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  'مشخصات سایر مسافرین',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15,
                  fontWeight: FontWeight.bold,
                                color: Theme.of(context).accentColor
                ),),
              ),
              Padding(
                  padding: const EdgeInsets.only(left:8 , right: 8 ,bottom: 5),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columns: [
                          DataColumn(
                            label: Text('نام',
                                style: Theme.of(context).textTheme.headline),
                          ),
                          DataColumn(
                            label: Text('کدملی',
                                style: Theme.of(context).textTheme.headline),
                          ),
                          DataColumn(
                            label: Text('تاریخ تولد',
                                style: Theme.of(context).textTheme.headline),
                          ),
                        ],
                        rows: listpassanger,
                      ),
                    ),
                  )),
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
                                  child: Text('هزینه برای هر نفر',
                                      textDirection: TextDirection.rtl,
                                      textAlign: TextAlign.right)),
                              Spacer(),
                              Expanded(
                                  child: Text('1.200.000 تومان',
                                      textDirection: TextDirection.rtl,
                                      textAlign: TextAlign.left))
                            ],
                          ),
                        ),
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
                              Spacer(),
                              Expanded(
                                  child: Text('4.500.000 تومان',
                                      textDirection: TextDirection.rtl,
                                      textAlign: TextAlign.left))
                            ],
                          ),
                        ),
                      ],
                    )),
              ),
              Padding(
                padding: EdgeInsets.only(top: 25),
                child: MaterialButton(
                  onPressed: () => {},
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
                  onPressed: () => {},
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
