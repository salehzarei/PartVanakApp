import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import './model/toure_model.dart';
import './model/contact.dart';
import './model/passenger_model.dart';


class MainModel extends Model {
  final String host = 'https://safirparvaz.ir/tourapi/';
  List<Toure> tourelist = [];
  List<ContactSubject> contactSubjectList = [];
  List<PassengerModel> passengers = [];
  List<GlobalKey<FormState>> userFormKey = [];

  
  bool isloading = false;

  // List<Toure> get tourData => _tourelist;

  // bool get isloading => _isloading;

  Future getTourData() async {
    tourelist.clear();
    isloading = true;
    notifyListeners();
    final response = await http.get(host + 'tours');
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      Toure _toure = Toure();
      data.forEach((touredata) {
        _toure = Toure(
          id: touredata['Id'],
          title: touredata['Title'].toString(),
          nights: touredata['Nights'],
          days: touredata['Days'],
          vehicl_went: touredata['Vehicl_went'],
          veicl_revert: touredata['Vehicl_revert'],
          accommodation_type: touredata['Accommodation_type'],
          sdate: touredata['SDate'],
          edate: touredata['EDate'],
          source_title: touredata['Source_title'],
          destination_title: touredata['Destination_title'],
          thumb: touredata['Thumb'],
          pic: touredata['Pic'],
          price: touredata['Adult_price'],
          currency: touredata['Currency_title'],
        );
        tourelist.add(_toure);
        notifyListeners();
      });
      isloading = false;
      notifyListeners();
      return tourelist;
    } else {
      throw Exception('خطا اتصال به دیتابیس');
    }
  }

//    --------------  contact
  Future<bool> fetchSubject() async {
    //  ContactSubject _contactSubjectList=ContactSubject();
    // for(int i=1; i<5 ;i++){
    //     contactSubjectList.add({'id':
    //       i.toString() ,'title':  'موضوع '+i.toString()});
    //     notifyListeners();
    // }
    // return true;
    contactSubjectList.clear();
    isloading = true;
    notifyListeners();
    final response = await http.get(host + 'contact/subjects');
    
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);

     // print(response.body);

      if (data == null) {
        isloading = false;
        notifyListeners();
        return true;
      }
      ContactSubject _contactSubjectList;
       data.forEach((touredata) {
        _contactSubjectList = ContactSubject(
          id:touredata['Id'].toString(),
          title: touredata['Title'].toString(),
         
        );
         contactSubjectList.add(_contactSubjectList);
        
          isloading = false;
        notifyListeners();
      });
    //  print(contactSubjectList);
      return true;
    } else {
      throw Exception('خطا اتصال به دیتابیس');
    }
  }

  Future<bool> addContact(Map<String, dynamic> contactData) {
    return http
    .post(host + 'contact/add', body: json.encode(contactData))
      .then((http.Response response) {
        if (response.statusCode != 200 && response.statusCode != 201) {
          return false;
        }
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['error']) {
          return false;
        }

        return true;
      })
    .catchError((error) {
      return false;
    });
  }

  //    --------------  ./contact
}
