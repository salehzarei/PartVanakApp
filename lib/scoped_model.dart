import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
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
  List<Banks> bankList = [];
  List<CartModel> cart = [];
  List<ContactSubject> contactSubjectList = [];
  List<PassengerModel> passengers = [];
  List<GlobalKey<FormState>> userFormKey = [];
  AboutModel aboutmodel;
  String userToken;
  String verificationCode;
  String errorMassage;

//// اطلاعات موقت تور به ترتیب آی دی تور و آی دی هتل
  Map<String, String> tmpCartData = {'ToureID': '0', 'HotelID': '0'};
/////

  bool _isLoading = false;
  String _serverCartResponse;

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

///////// دریافت اطلاعات تور و هتل ها از سرور

  Future getTourData() async {
    tourelist.clear();
    _isLoading = true;
    notifyListeners();
    final response = await http.get(host + 'tours?');
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
        tourelist.add(_toure);
        notifyListeners();
      });
      _isLoading = false;
      notifyListeners();
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

  Future<bool> sendDataToServer(
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
        passengers: passengers);
    print(json.encode(_cartForOnePassenger));
    notifyListeners();
    return http
        .post(host + 'cart/add', body: json.encode(_cartForOnePassenger))
        .then((http.Response response) {
      if (response.statusCode != 200 && response.statusCode != 201) {
        print("اطلاعات بلیط با موفقیت به سرور ارسال شد");
        _isLoading = false;
        notifyListeners();
        return false;
      }
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['error']) {
        _isLoading = false;
        _serverCartResponse = responseData['error_msg'];
        notifyListeners();
        return false;
      }
      _isLoading = false;
      _serverCartResponse = responseData['url'];
      notifyListeners();
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
