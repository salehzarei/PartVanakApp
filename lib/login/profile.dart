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

  bool _emailEditing = true;
  TextEditingController _email = TextEditingController();
  TextEditingController _birthDate = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _cell = TextEditingController();
  TextEditingController _passport = TextEditingController();
  TextEditingController _address = TextEditingController();
  TextEditingController _postCode = TextEditingController();

  @override
  void initState() {
    MainModel _model = ScopedModel.of(context);
    _tabController = TabController(length: 3, vsync: this);
    super.initState();

    _model.getUserOrder();
    _email.text = _model.userProfile.email;
    _birthDate.text = _model.userProfile.birthDate;
    _phone.text = _model.userProfile.tell;
    _cell.text = _model.userProfile.cell;
    _passport.text = _model.userProfile.nationalCode;
    _address.text = _model.userProfile.address;
    _postCode.text = _model.userProfile.postalCode;
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
                                          BlendMode.lighten),
                                      image: model.userProfile.pic == ""
                                          ? AssetImage(
                                              'images/profile.jpg',
                                            )
                                          : NetworkImage(
                                              model.userProfile.pic))),
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
                                    maxRadius: 28,
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
                            Padding(
                              padding: EdgeInsets.only(top: 10, right: 300),
                              child: IconButton(
                                  icon: Icon(Icons.exit_to_app),
                                  color: Colors.black,
                                  onPressed: () => showDialog<void>(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Directionality(
                                            textDirection: TextDirection.rtl,
                                            child: AlertDialog(
                                              title: Text('توجه !'),
                                              content: Text(
                                                'مطمعن هستید که می خواهید خارج شوید؟',
                                                style: TextStyle(fontSize: 13),
                                              ),
                                              actions: <Widget>[
                                                FlatButton(
                                                  onPressed: () => model
                                                      .setToken(null)
                                                      .whenComplete(() {
                                                    Navigator.pushNamed(
                                                        context, '/');
                                                  }),
                                                  child:
                                                      Text('خروج از اپلیکیشن'),
                                                ),
                                                FlatButton(
                                                  child: Text('بستن'),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              20.0))),
                                            ),
                                          );
                                        },
                                      )),
                            )
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
                                  trailing: Container(
                                      width: 110,
                                      alignment: Alignment.centerLeft,
                                      child: TextField(
                                        controller: _email,
                                        onTap: () {
                                          setState(() {
                                            _emailEditing = false;
                                          });
                                        },
                                        style: TextStyle(fontSize: 12),
                                        decoration: InputDecoration(
                                          hintText: 'هنوز چیزی ثبت نشده',
                                        ),
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        readOnly: _emailEditing,
                                        onSubmitted: (ok) {
                                          print(ok);
                                          setState(() {
                                            _emailEditing = true;
                                          });
                                        },
                                      )),
                                  dense: true,
                                ),
                                ListTile(
                                  title: Text(
                                    'تاریخ تولد',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 12),
                                  ),
                                  trailing: Container(
                                      width: 110,
                                      alignment: Alignment.centerLeft,
                                      child: TextField(
                                        controller: _birthDate,
                                        textDirection: TextDirection.rtl,
                                        style: TextStyle(fontSize: 12),
                                        decoration: InputDecoration(
                                          hintText: 'هنوز چیزی ثبت نشده',
                                        ),
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        readOnly: _emailEditing,
                                        onSubmitted: (ok) {
                                          print(ok);
                                          setState(() {
                                            _emailEditing = false;
                                          });
                                        },
                                      )),
                                  dense: true,
                                ),
                                ListTile(
                                  title: Text(
                                    'شماره تلفن ثابت',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 12),
                                  ),
                                  trailing: Container(
                                      width: 110,
                                      alignment: Alignment.centerLeft,
                                      child: TextField(
                                        controller: _phone,
                                        style: TextStyle(fontSize: 12),
                                        decoration: InputDecoration(
                                          hintText: 'هنوز چیزی ثبت نشده',
                                        ),
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        readOnly: _emailEditing,
                                        onSubmitted: (ok) {
                                          print(ok);
                                          setState(() {
                                            _emailEditing = false;
                                          });
                                        },
                                      )),
                                  dense: true,
                                ),
                                ListTile(
                                  title: Text(
                                    'شماره تلفن همراه',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 12),
                                  ),
                                  trailing: Container(
                                      width: 110,
                                      alignment: Alignment.centerLeft,
                                      child: TextField(
                                        controller: _cell,
                                        textDirection: TextDirection.rtl,
                                        style: TextStyle(fontSize: 12),
                                        decoration: InputDecoration(
                                          hintText: 'هنوز چیزی ثبت نشده',
                                        ),
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        readOnly: true,
                                      )),
                                  dense: true,
                                ),
                                ListTile(
                                  title: Text(
                                    'کد ملی/پاسپورت',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 12),
                                  ),
                                  trailing: Container(
                                      width: 110,
                                      alignment: Alignment.centerLeft,
                                      child: TextField(
                                        controller: _passport,
                                        textDirection: TextDirection.rtl,
                                        style: TextStyle(fontSize: 12),
                                        decoration: InputDecoration(
                                          hintText: 'هنوز چیزی ثبت نشده',
                                        ),
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        readOnly: _emailEditing,
                                        onSubmitted: (ok) {
                                          print(ok);
                                          setState(() {
                                            _emailEditing = false;
                                          });
                                        },
                                      )),
                                  dense: true,
                                ),
                                ListTile(
                                  title: Text(
                                    'محل اقامت',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 12),
                                  ),
                                  trailing: Container(
                                      width: 110,
                                      alignment: Alignment.centerLeft,
                                      child: TextField(
                                        controller: _address,
                                        textDirection: TextDirection.rtl,
                                        style: TextStyle(fontSize: 12),
                                        decoration: InputDecoration(
                                          hintText: 'هنوز چیزی ثبت نشده',
                                        ),
                                        keyboardType: TextInputType.text,
                                        readOnly: _emailEditing,
                                        onSubmitted: (ok) {
                                          print(ok);
                                          setState(() {
                                            _emailEditing = false;
                                          });
                                        },
                                      )),
                                  dense: true,
                                ),
                                ListTile(
                                  title: Text(
                                    'کد پستی',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 12),
                                  ),
                                  trailing: Container(
                                      width: 110,
                                      alignment: Alignment.centerLeft,
                                      child: TextField(
                                        controller: _postCode,
                                        textDirection: TextDirection.rtl,
                                        style: TextStyle(fontSize: 12),
                                        decoration: InputDecoration(
                                          hintText: 'هنوز چیزی ثبت نشده',
                                        ),
                                        keyboardType: TextInputType.number,
                                        readOnly: _emailEditing,
                                        onSubmitted: (ok) {
                                          print(ok);
                                          setState(() {
                                            _emailEditing = false;
                                          });
                                        },
                                      )),
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
                      child: model.userOrders.length <= 1
                          ? Center(
                              child: Text('هنوز هیچ خریدی ثبت نشده'),
                            )
                          : ListView.builder(
                              itemCount: model.userOrders.length,
                              padding: EdgeInsets.only(
                                  top: 10, left: 10, right: 10, bottom: 10),
                              itemBuilder: (context, index) {
                                  return Card(
                                  color: Colors.grey.shade200,
                                  child: ListTile(
                                    subtitle: Text(' در تاریخ ' +
                                        model.userOrders[index].date +
                                        ' این تور ' +
                                        model.userOrders[index].statusTitle +
                                        ' به دلیل اینکه ' +
                                        model.userOrders[index].paymentTitle),
                                    dense: true,
                                    isThreeLine: true,
                                    leading: RotationTransition(
                                      turns:
                                          new AlwaysStoppedAnimation(45 / 360),
                                      child: model.userOrders[index].status == 5
                                          ? Icon(
                                              Icons.add_circle,
                                              color: Colors.redAccent,
                                            )
                                          : Icon(
                                              Icons.check_circle,
                                              color: Colors.greenAccent,
                                            ),
                                    ),
                                    title:
                                        Text(model.userOrders[index].tourTitle),
                                    trailing: Text(
                                        model.userOrders[index].id.toString()),
                                  ),
                                );
                              })),
                  Container(
                      child: Center(
                    child: Text('این قسمت هنوز طراحی نشده است'),
                  ))
                ],
                controller: _tabController,
              ),
            ),
          );
        }));
  }
}
