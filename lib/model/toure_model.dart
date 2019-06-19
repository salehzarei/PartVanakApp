import './accommodation_model.dart';

class Toure {
  final int id;
  final String title;
  final String desc;
  final int nights;
  final int days;
  final String vehicl_went;
  final String veicl_revert;
  final String sdate;
  final String edate;
  final String source_title;
  final String destination_title;
  final String thumb;
  final String pic;
  final String currency;
  final int foreign;
  final int price;
  final String difficulty;
  final int capacity;
  final dynamic planning;
  final List<Accommodation> accommodation;
  

  Toure(
      {this.id,
      this.title,
      this.desc,
      this.nights,
      this.days,
      this.vehicl_went,
      this.veicl_revert,
      this.sdate,
      this.edate,
      this.source_title,
      this.destination_title,
      this.thumb,
      this.pic,
      this.currency,
      this.foreign,
      this.price,
      this.difficulty,
      this.capacity,
      this.planning,
      this.accommodation,
     });
}

// Id: 30,
// Title: "دبی",
// Nights: 3,
// Days: 4,
// Vehicl_went: " هواپیما",
// Vehicl_revert: " هواپیما",
// Accommodation_type: 3,
// SDate: "شنبه 25 خرداد 1398",
// EDate: "سه شنبه 28 خرداد 1398",
// Source_title: "تهران",
// Destination_title: "دبی",
// Thumb: "http://partvanak.com/store/files/tours/30-thumb.jpg",
// Pic: "http://partvanak.com/store/files/tours/30-pic.jpg",
// Price: "3500000",
// Currency_title: "تومان"
