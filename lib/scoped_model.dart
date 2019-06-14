import 'dart:convert';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import './model/toure_model.dart';

class MainModel extends Model {
  List<Toure> tourelist = [];
  bool isloading = false;

 // List<Toure> get tourData => _tourelist;

 // bool get isloading => _isloading;

  Future getTourData() async {
    tourelist.clear();
    isloading = true;
    notifyListeners();
    final response = await http.get('http://partvanak.com/tourapi/tours');
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
          price: touredata['Price'],
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
}
