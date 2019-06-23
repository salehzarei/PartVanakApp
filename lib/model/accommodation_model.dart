import 'dart:convert';

class Accommodation {
  final int accommodation_id;
  final int accommodation_type;
  final String hotel_title;
  final int singel_price;
  final int adult_price;
  final int child_price;
  final int child_price_bed;
  final int baby_price;
  final dynamic specification;
  final List<Gallery> gallery;

  Accommodation(
      {this.accommodation_id,
      this.accommodation_type,
      this.hotel_title,
      this.singel_price,
      this.adult_price,
      this.child_price,
      this.child_price_bed,
      this.baby_price,
      this.specification,
      this.gallery});

  factory Accommodation.fromJson(Map<String, dynamic> json) {
    return Accommodation(
      accommodation_id: json['Id'],
      accommodation_type: json['Accommodation_type'],
      hotel_title: json['Hotel_title'],
      singel_price: json['Single_price'],
      adult_price: json['Adult_price'],
      child_price: json['Child_price'],
      child_price_bed: json['Child_price_bed'],
      baby_price: json['Baby_price'],
      specification: json['Specification'],
      gallery:
          (json['Gallery'] as List).map((g) => Gallery.fromJson(g)).toList(),
    );
  }
}

class Gallery {
  final String thumb;
  final String pic;

  Gallery({this.thumb, this.pic});

  factory Gallery.fromJson(Map<String, dynamic> galleryjson) {
    return Gallery(pic: galleryjson['Thumb'], thumb: galleryjson['Pic']);
  }
}
