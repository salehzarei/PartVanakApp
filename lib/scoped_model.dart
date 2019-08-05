import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hello_flutter/model/tourefilter_model.dart';
import 'package:hello_flutter/model/user_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:url_launcher/url_launcher.dart';
import './model/toure_model.dart';
import './model/contact.dart';
import './model/passenger_model.dart';
import './model/bank_model.dart';
import './model/cart_model.dart';
import './model/about_model.dart';
import './model/accommodation_model.dart';

class MainModel extends Model {
  final String host = 'https://safirparvaz.ir/tourapi/';
  List<Toure> tourelist = [];
  List<Toure> specialToureList = [];
  List<Banks> bankList = [];
  List<CartModel> cart = [];
  List<ContactSubject> contactSubjectList = [];
  List<PassengerModel> passengers = [];
  List<GlobalKey<FormState>> userFormKey = [];
  AboutModel aboutmodel;
  UserModel userProfile;
  String userToken;
  String verificationCode;
  String errorMassage;
  bool _isLoading = false;
  String _serverCartResponse;
//// اطلاعات موقت تور به ترتیب آی دی تور و آی دی هتل
  Map<String, String> tmpCartData = {'ToureID': '0', 'HotelID': '0'};

/////لیستی از انواع تورها برای استفاده مختلف در اپ
  List<Map<String, String>> touretypes = [
    {
      'title': 'تورهای خارجی',
      'pushNamed': '/foreigntourelist',
      'foregin': '2',
      'special': ''
    },
    {
      'title': 'تورهای داخلی',
      'pushNamed': '/internaltourelist',
      'foregin': '1',
      'special': ''
    },
    {
      'title': 'تورهای یکروزه',
      'pushNamed': '/onedaytourelist',
      'foregin': '',
      'special': ''
    },
    {
      'title': 'تورهای لحظه آخری',
      'pushNamed': '/lassecondtourelist',
      'foregin': '',
      'special': '2'
    },
    {
      'title': 'پیشنهادات ویژه',
      'pushNamed': '/specialtourelist',
      'foregin': '',
      'special': '1'
    },

    /// بقیه انواع تور باید اینجا تعریف بشه
  ];

//توابع خواندن URL بازکردن
  launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  /// تبدیل رقم به تومان با نقاط جداکننده 1000 گان
  fixPrice(String price) {
    return MoneyMaskedTextController(
            precision: 0,
            thousandSeparator: '.',
            decimalSeparator: '',
            initialValue: double.parse(price))
        .text;
  }

  /// ساخت ستاره هتل ها
  makeStar(int type) {
    List<Widget> starIconList = [];
    for (int i = 1; i < 6; i++) {
      if (type > 0) {
        starIconList.add(Icon(
          Icons.star,
          size: 15,
          color: Colors.orange.shade300,
        ));
        type--;
      } else
        starIconList.add(
          Icon(
            Icons.star_border,
            size: 15,
            color: Colors.orange.shade300,
          ),
        );
    }
    return Row(
      children: starIconList,
      textDirection: TextDirection.rtl,
    );
  }

//// تابع دیالوگ باکس برای همه برنامه
  Future<void> ackAlert(BuildContext context, {String massage, String route }) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            title: Text('شرمنده !'),
            content: Text(massage == null
                ? 'متاسفانه هنوز برای این قسمت تور قرار گرفته نشده'
                : massage),
            actions: <Widget>[
              route != null
                  ? FlatButton(
                      onPressed: () => Navigator.pushNamed(context, route),
                      child: Text('ورود به اپلیکیشن'),
                    )
                  : null,
              FlatButton(
                child: Text('بستن'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
          ),
        );
      },
    );
  }

  bool get isLoading {
    return _isLoading;
  }

  String get serverCartResponse {
    return _serverCartResponse;
  }

  deleteFromList(index) {
    passengers.removeAt(index);
    userFormKey.removeAt(index);
    notifyListeners();
  }

///////// دریافت و چک کردن اطلاعات لاگین از سرور
  Future loginData({String mobile, String pass}) async {
    _isLoading = true;
    errorMassage = "";
    notifyListeners();
    final response = await http.post(host + 'user/login',
        encoding: Encoding.getByName('utf-8'),
        body: {'mobile': mobile, 'pass': pass});
    bool chekerror = json.decode(response.body)['error'];
    if (response.statusCode == 200 && !chekerror) {
      String _token = json.decode(response.body)['token'];
      setToken(_token);
    } else if (response.statusCode == 200 && chekerror) {
      errorMassage = json.decode(response.body)['error_msg'];
      notifyListeners();
    }
  }

  /// ثبت توکن جدید یا خالی در شیرپروفرمنس
  Future setToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  /// خواندن توکن از داخل گوشی برای احراز هویت مشتری
  Future getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final _userToken = prefs.getString('token');
    if (_userToken == null) {
      print("ShredPreTkoen is Empty");
      userToken = null;
      notifyListeners();
    } else {
      print("SharedTokne is : $_userToken");
      userToken = _userToken;
      notifyListeners();
    }
  }

  /////// ثبت نام  کاربر جدید

  Future<void> registerUser({
    String name,
    String family,
    String email,
    String mobile,
    String code,
    String pass,
  }) async {
    _isLoading = true;
    errorMassage = "";
    notifyListeners();
    final response = await http.post(host + 'user/register',
        encoding: Encoding.getByName('utf-8'),
        body: {
          'name': name,
          'family': family,
          'mobile': mobile,
          'email': email,
          'code': code,
          'pass': pass,
          'verification_token': verificationCode
        });
    bool chekerror = json.decode(response.body)['error'];
    if (response.statusCode == 200 && !chekerror) {
      print("کاربر ثبت نام شد!");
    } else if (response.statusCode == 200 && chekerror) {
      print(json.decode(response.body)['error_msg']);
      errorMassage = json.decode(response.body)['error_msg'];
      notifyListeners();
    }
  }

///////// دریافت و چک کردن اطلاعات شماره موبایل از سرور

  Future<bool> checkMobile(String mobile) async {
    errorMassage = "";
    _isLoading = true;
    notifyListeners();
    final response = await http.post(host + 'user/checkmobile',
        encoding: Encoding.getByName('utf-8'), body: {'mobile': mobile});
    bool chekerror = json.decode(response.body)['error'];
    if (response.statusCode == 200 && !chekerror) {
      print("کاربر وارد شد!");
      return true;
    } else {
      String _errorMassage = json.decode(response.body)['error_msg'];
      errorMassage = _errorMassage;
      notifyListeners();
    }
    _isLoading = false;
    notifyListeners();
    return false;
  }

///////// درخواست کد اهراز هویت به سرور پیامک

  Future<void> getVerificationCode(String mobile) async {
    verificationCode = "";
    notifyListeners();
    final response = await http.post(host + 'user/getVerificationCode',
        encoding: Encoding.getByName('utf-8'), body: {'mobile': mobile});
    bool chekerror = json.decode(response.body)['error'];
    if (response.statusCode == 200 && !chekerror) {
      verificationCode = json.decode(response.body)['verification_token'];
      print(verificationCode);
      notifyListeners();
    } else {
      print(json.decode(response.body)['error_msg']);
    }
  }

///////// دریافت اطلاعات پروفایل کاربری از سرور
  /// روش جدید و بهتر برای ارسال درخواست و دریافت داده ها وذخیره در مدل
  /// به ساختار مدل پروفایل توجه شود

  Future loadingUserData() async {
    _isLoading = true;
    notifyListeners();
    final response = await http.post(host + 'profile',
        encoding: Encoding.getByName('utf-8'), body: {'token': userToken});
    if (response.statusCode == 200) {
      userProfile = UserModel.fromJson(json.decode(response.body));
      _isLoading = false;
      notifyListeners();
    }
  }

///////// دریافت اطلاعات تور و هتل ها از سرور

  Future getTourData({ToureFilterModel filter}) async {
    tourelist.clear();
    _isLoading = true;
    notifyListeners();
    final response = await http.post(host + 'tours', body: filter.toJson());
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      Toure _toure = Toure();
      data.forEach((touredata) {
        _toure = Toure(
          id: touredata['Id'],
          title: touredata['Title'],
          desc: touredata['Desc'],
          nights: touredata['Nights'],
          days: touredata['Days'],
          vehicl_went: touredata['Vehicl_went'],
          veicl_revert: touredata['Vehicl_revert'],
          sdate: touredata['SDate'],
          edate: touredata['EDate'],
          source_title: touredata['Source_title'],
          destination_title: touredata['Destination_title'],
          thumb: touredata['Thumb'],
          pic: touredata['Pic'],
          currency: touredata['Currency_title'],
          foreign: touredata['Foreign'],
          price: touredata['Price'],
          difficulty: touredata['Difficulty'],
          capacity: touredata['Capacity'],
          planning: touredata['Planning'],
          //اضافه کردن لیست از مپ هتل ها
          accommodation: (touredata['Accommodation'] as List)
              .map((i) => Accommodation.fromJson(i))
              .toList(),
        );
        if (filter.special == '1') specialToureList.add(_toure);
        tourelist.add(_toure);
        notifyListeners();
      });
      _isLoading = false;
      notifyListeners();
      return tourelist;
    } else {
      throw Exception('خطا اتصال به دیتابیس');
    }
  }

///////// دریافت اطلاعات درگاه های بانکی از سرور

  Future getBankData() async {
    bankList.clear();
    _isLoading = true;
    notifyListeners();
    final response = await http.get(host + 'cart/banks');
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      Banks _banks = Banks();
      data.forEach((bankdata) {
        _banks = Banks(bankid: bankdata['Id'], bankTitle: bankdata['Title']);
        bankList.add(_banks);
        notifyListeners();
      });
      _isLoading = false;
      notifyListeners();
    } else {
      throw Exception('خطا اتصال به دیتابیس');
    }
  }

  /// دریافت اصلاعات موضوع تماس از سرور
  Future<bool> fetchSubject() async {
    //  ContactSubject _contactSubjectList=ContactSubject();
    // for(int i=1; i<5 ;i++){
    //     contactSubjectList.add({'id':
    //       i.toString() ,'title':  'موضوع '+i.toString()});
    //     notifyListeners();
    // }
    // return true;
    contactSubjectList.clear();
    _isLoading = true;
    notifyListeners();
    final response = await http.get(host + 'contact/subjects');

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);

      if (data.isEmpty) {
        _isLoading = false;
        notifyListeners();
        return true;
      }
      ContactSubject _contactSubjectList;
      data.forEach((touredata) {
        _contactSubjectList = ContactSubject(
          id: touredata['Id'].toString(),
          title: touredata['Title'].toString(),
        );
        contactSubjectList.add(_contactSubjectList);
        _isLoading = false;
        notifyListeners();
      });
      return true;
    } else {
      throw Exception('خطا اتصال به دیتابیس');
    }
  }

///// ارسال اطلاعات مسافر به سرور

  Future<bool> sendDataToServer(BuildContext context,
      {String cell, String tell, String email}) async {
    cart.clear();
    notifyListeners();
    CartModel _cartForOnePassenger = CartModel(
        toure_id: int.parse(tmpCartData['ToureID']),
        hotel_id: int.parse(tmpCartData['HotelID']),
        cell: cell,
        tell: tell,
        email: email,
        paymentType: 7,
        token: userToken,
        passengers: passengers);
    _isLoading = true;
    notifyListeners();
    print("Cell: " +
        _cartForOnePassenger.cell +
        " Email: " +
        _cartForOnePassenger.email +
        " Tell: " +
        _cartForOnePassenger.tell +
        " TourId: " +
        _cartForOnePassenger.toure_id.toString() +
        " HotelId: " +
        _cartForOnePassenger.hotel_id.toString() +
        " PaymentType: " +
        _cartForOnePassenger.paymentType.toString() +
        " Token: " +
        _cartForOnePassenger.token +
        " Passenger id: " +
        _cartForOnePassenger.passengers[0].id +
        " Passenger name : " +
        _cartForOnePassenger.passengers[0].name +
        " Passenger family : " +
        _cartForOnePassenger.passengers[0].family +
        " Passenger gender : " +
        _cartForOnePassenger.passengers[0].sex +
        " Passenger nationality : " +
        _cartForOnePassenger.passengers[0].nationality +
        " Passenger National_code : " +
        _cartForOnePassenger.passengers[0].melicode +
        " Birth_date : " +
        _cartForOnePassenger.passengers[0].brith +
        " Ages : " +
        _cartForOnePassenger.passengers[0].type);
    await http
        .post(host + 'cart/add', body: json.encode(_cartForOnePassenger))
        .then((http.Response response) {
      if (response.statusCode == 200) {
        print(response.body);
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['error']) {
          _isLoading = false;
          _serverCartResponse = responseData['error_msg'];
          ackAlert(context, massage: _serverCartResponse);
          notifyListeners();
          return false;
        } else {
          _isLoading = false;
          _serverCartResponse = responseData['url'];
          launchURL(_serverCartResponse);
          print(responseData['url']);
          notifyListeners();
          return true;
        }
      }
      return true;
    }).catchError((error) {
      _isLoading = false;
      notifyListeners();
      return false;
    });
  }

///// ارسال فرم تماس به سرور

  Future<bool> addContact(Map<String, dynamic> contactData) {
    _isLoading = true;
    notifyListeners();
    return http
        .post(host + 'contact/add', body: json.encode(contactData))
        .then((http.Response response) {
      if (response.statusCode != 200 && response.statusCode != 201) {
        _isLoading = false;
        notifyListeners();
        return false;
      }
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['error']) {
        _isLoading = false;
        notifyListeners();
        return false;
      }
      _isLoading = false;
      notifyListeners();
      return true;
    }).catchError((error) {
      _isLoading = false;
      notifyListeners();
      return false;
    });
  }

  ///// ارسال فرم تماس به سرور

  Future<bool> addComment(Map<String, dynamic> contactData) {
    _isLoading = true;
    notifyListeners();
    // {
    //     'token': contactData['token'],
    //     'name': contactData['name'],
    //     'email': contactData['email'],
    //     'cell': contactData['cell'],
    //     'message': contactData['message'],
    //     'bId': contactData['bId']
    //     }
    return http
        .post(host + 'blog/addcomment',
            encoding: Encoding.getByName('utf-8'), body: contactData)
        .then((http.Response response) {
      if (response.statusCode != 200 && response.statusCode != 201) {
        print(response);
        _isLoading = false;
        notifyListeners();
        return false;
      }

      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['error']) {
        _isLoading = false;
        notifyListeners();
        return false;
      }
      _isLoading = false;
      notifyListeners();
      return true;
    }).catchError((error) {
      _isLoading = false;
      notifyListeners();
      return false;
    });
  }

///// دریافت اطلاعات درباره ما از سرور
  Future<bool> getAboutData() async {
    _isLoading = true;
    notifyListeners();
    final response = await http.get(host + 'about');

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      aboutmodel = AboutModel(
        about: data['About'],
        name: data['Name'],
        cell: data['Cell'],
        tell: data['Tell'],
        address: data['Address'],
        email: data['Email'],
        back: data['back'],
        web: data['Web'],
        social:
            (data['Social'] as List).map((i) => Social.fromJson(i)).toList(),
      );
      _isLoading = false;
      notifyListeners();
      return true;
    } else {
      throw Exception('خطا اتصال به دیتابیس');
    }
  }
}
