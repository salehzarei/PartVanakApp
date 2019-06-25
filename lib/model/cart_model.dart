import './passenger_model.dart';

class CartModel {
  int toure_id;
  int hotel_id;
  String cell;
  String tell;
  String email;
  List<PassengerModel> passengers;
  int paymentType;

  CartModel({
    this.toure_id,
    this.hotel_id,
    this.cell,
    this.tell,
    this.email,
    this.passengers,
    this.paymentType,
  });

  toJson() {
    return {
      'toureId': toure_id,
      'hotelId': hotel_id,
      'cell': cell,
      'tell': tell,
      'email': email,
      'data': passengers,
      'paymentType': paymentType,
    };
  }
}
