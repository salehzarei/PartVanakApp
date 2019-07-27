import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:scoped_model/scoped_model.dart';
import '../drawer.dart';
import '../scoped_model.dart';

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
    return Directionality(
        textDirection: TextDirection.rtl,
        child:
            ScopedModelDescendant<MainModel>(builder: (context, child, model) {
          return Scaffold(
            drawer: MyDrawer(),
            appBar: AppBar(
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  ),
                  onPressed: () => Navigator.pop(context),
                )
              ],
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
                              margin: EdgeInsets.symmetric(horizontal: 7),
                              height: 180,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10)),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    colorFilter: ColorFilter.mode(
                                        Colors.white.withOpacity(0.5),
                                        BlendMode.overlay),
                                    image: model.userProfile.pic == "" ? AssetImage(
                                      'images/profile.jpg',
                                    ) : NetworkImage(model.userProfile.pic)
                                  )),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 115, right: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    width: 10,
                                  ),
                                  CircleAvatar(
                                    backgroundImage: model.userProfile.thumb ==
                                            ""
                                        ? AssetImage('images/air.jpg')
                                        : NetworkImage(model.userProfile.thumb),
                                    maxRadius: 25,
                                  ),
                                  Spacer(
                                    flex: 1,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        '${model.userProfile.name} ${model.userProfile.family}',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      Text(
                                        'نام کاربری : ${model.userProfile.user}',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                  Spacer(
                                    flex: 12,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 7, horizontal: 7),
                            decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(10)),
                            child: ListView(
                              children: <Widget>[
                                ListTile(
                                  title: Text(
                                    'آدرس ایمیل',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 12),
                                  ),
                                  trailing: model.userProfile.email != ""
                                      ? Text(model.userProfile.email)
                                      : Text('هنوز ثبت نشده'),
                                  dense: true,
                                  
                                ),
                                
                                ListTile(
                                  title: Text(
                                    'تاریخ تولد',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 12),
                                  ),
                                  trailing: model.userProfile.birthDate != ""
                                      ? Text(model.userProfile.birthDate)
                                      : Text('هنوز ثبت نشده'),
                                  dense: true,
                                ),
                                ListTile(
                                  title: Text(
                                    'شماره تلفن ثابت',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 12),
                                  ),
                                  trailing: model.userProfile.tell != ""
                                      ? Text(model.userProfile.tell)
                                      : Text('هنوز ثبت نشده'),
                                  dense: true,
                                ),
                                ListTile(
                                  title: Text(
                                    'شماره تلفن همراه',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 12),
                                  ),
                                  trailing: model.userProfile.cell != ""
                                      ? Text(model.userProfile.cell)
                                      : Text('هنوز ثبت نشده'),
                                  dense: true,
                                ),
                                ListTile(
                                  title: Text(
                                    'کد ملی/پاسپورت',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 12),
                                  ),
                                  trailing: model.userProfile.nationalCode != ""
                                      ? Text(model.userProfile.nationalCode)
                                      : Text('هنوز ثبت نشده'),
                                  dense: true,
                                ),
                                ListTile(
                                  title: Text(
                                    'محل اقامت',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 12),
                                  ),
                                  trailing: model.userProfile.address != ""
                                      ? Text(
                                          "${model.userProfile.ostan} ${model.userProfile.city} ${model.userProfile.address}")
                                      : Text('هنوز ثبت نشده'),
                                  dense: true,
                                ),
                                ListTile(
                                  title: Text(
                                    'کد پستی',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 12),
                                  ),
                                  trailing: model.userProfile.postalCode != ""
                                      ? Text(model.userProfile.postalCode)
                                      : Text('هنوز ثبت نشده'),
                                  dense: true,
                                ),
                              ],
                            ),
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
                        padding: EdgeInsets.only(
                            top: 50, left: 10, right: 10, bottom: 10),
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
        }));
  }
}
