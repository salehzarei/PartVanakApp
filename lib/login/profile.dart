import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<Profile>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("پروفایل من"),
        bottom: TabBar(
          unselectedLabelColor: Colors.white,
          labelColor: Colors.amber,
          tabs: [
            Tab(
              icon: Icon(Icons.account_circle),
              text: 'پروفایل',
            ),
            Tab(
              icon: Icon(Icons.payment),
              text: 'خرید های من',
            ),
            Tab(
              icon: Icon(Icons.attach_money),
              text: 'تراکنش ها',
            )
          ],
          controller: _tabController,
          indicatorColor: Colors.white,
          indicatorSize: TabBarIndicatorSize.tab,
        ),
        bottomOpacity: 1,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: TabBarView(
          children: [
            Container(
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        child: Image.asset(
                          'images/profile.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 140, right: 15),
                        child: Row(
                          children: <Widget>[
                            Container(
                              //decoration: BoxDecoration(shape: BoxShape.circle),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0)),

                              child: Image.asset(
                                'images/air.jpg',
                                width: 40,
                                height: 40,
                              ),
                            ),
                            Container(
                                child: Column(
                              children: <Widget>[
                                Text(
                                  'نوید نجاتی',
                                  style: TextStyle(fontSize: 20),
                                ),
                                Text(
                                  'امتیاز شما:50',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            )),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          print('ok');
                        },
                        child: Padding(
                          padding: EdgeInsets.only(top: 140, right: 350),
                          child: Container(
                            // decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
                            width: 30,
                            height: 30,
                            child: Icon(Icons.edit),
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: ListView(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Container(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  height: 30,
                                  color: Colors.white,
                                  child: Row(
                                    children: <Widget>[
                                      Text('موجودی حساب:'),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 270),
                                        child: Text('0ریال'),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 30,
                                  color: Colors.grey,
                                  child: Row(
                                    children: <Widget>[
                                      Text('ایمیل:'),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 200),
                                        child: Text('navidnejati76@gmail.com'),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 30,
                                  color: Colors.white,
                                  child: Row(
                                    children: <Widget>[
                                      Text('شماره همراه:'),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 250),
                                        child: Text('09309722107'),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 30,
                                  color: Colors.grey,
                                  child: Row(
                                    children: <Widget>[
                                      Text('جنیست:'),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 300),
                                        child: Text('مرد'),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 30,
                                  color: Colors.white,
                                  child: Row(
                                    children: <Widget>[
                                      Text('کد ملی:'),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 280),
                                        child: Text('0924258357'),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 30,
                                  color: Colors.grey,
                                  child: Row(
                                    children: <Widget>[
                                      Text('تاریخ تولد:'),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 280),
                                        child: Text('76/11/12'),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 70,
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
                child: ListView.builder(
                    itemCount: 10,
                    padding: EdgeInsets.only(
                        top: 50, left: 10, right: 10, bottom: 10),
                    itemBuilder: (context, index) {
                      return Column(
                        children: <Widget>[
                          SizedBox(
                            height: 10,
                          ),
                          Text('لیست بلیط ها')
                        ],
                      );
                    })),
            Container(
              child: ListView.builder(
                  itemCount: 10,
                  padding:
                      EdgeInsets.only(top: 50, left: 10, right: 10, bottom: 10),
                  itemBuilder: (context, index) {
                    return Column(
                      children: <Widget>[
                        SizedBox(
                          height: 10,
                        ),
                        Text('لیست تراکنش ها')
                      ],
                    );
                  }),
            )
          ],
          controller: _tabController,
        ),
      ),
    );
  }
}
