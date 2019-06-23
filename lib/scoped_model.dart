import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:hello_flutter/model/about_model.dart';
import 'package:hello_flutter/model/accommodation_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import './model/toure_model.dart';
import './model/contact.dart';
import './model/passenger_model.dart';
import './model/cart_model.dart';

class MainModel extends Model {
  final String host = 'https://safirparvaz.ir/tourapi/';
  List<Toure> tourelist = [];
//  List<Toure> foreign = [];
 // List<Toure> internal = [];
  List<CartModel> cart = [];
  List<ContactSubject> contactSubjectList = [];
  List<PassengerModel> passengers = [];
  List<GlobalKey<FormState>> userFormKey = [];
  AboutModel aboutmodel;

//// اطلاعات موقت تور به ترتیب آی دی تور و آی دی هتل
  Map<String, String> tmpCartData = {'ToureID': '0', 'HotelID': '0'};
/////

  bool _isLoading = false;

  bool get isLoading {
    return _isLoading;
  }

///////// دریافت اطلاعات تور و هتل ها از سرور

  Future getTourData() async {
    tourelist.clear();
  //  internal.clear();
   // foreign.clear();
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

        // switch (_toure.foreign.toString()) {
        //   case "2":
        //     {
        //       foreign.add(_toure);
        //     }
        //     break;

        //   case "1":
        //     {
        //       internal.add(_toure);
        //     }
        //     break;

        //   default:
        //     {
        //       tourelist.add(_toure);
        //     }
        //     break;
        // }
        tourelist.add(_toure);

        notifyListeners();
      });
      _isLoading = false;
      notifyListeners();
      // return tourelist;
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

      if (data == null) {
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
///////////////////// ارسال فرم تماس به سرور

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

  //    --------------  ./contact

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
          web: data['Web'],
          social: data['Social']);
      _isLoading = false;
      notifyListeners();
      return true;
    } else {
      throw Exception('خطا اتصال به دیتابیس');
    }
  }
}
