import 'dart:convert';

class Accommodation {
  final int accommodation_type;
  final String title;
  final String hotel_title;
  final int singel_price;
  final int adult_price;
  final int child_price;
  final int child_price_bed;
  final int baby_price;
  final dynamic specification;

  Accommodation(
      {this.accommodation_type,
      this.title,
      this.hotel_title,
      this.singel_price,
      this.adult_price,
      this.child_price,
      this.child_price_bed,
      this.baby_price,
      this.specification});

  factory Accommodation.fromJson(Map<String, dynamic> json) {
    return Accommodation(
        accommodation_type: json['Accommodation_type'],
        title: json['Title'],
        hotel_title: json['Hotel_title'],
        singel_price: json['Single_price'],
        adult_price: json['Adult_price'],
        child_price: json['Child_price'],
        child_price_bed: json['Child_price_bed'],
        baby_price: json['Baby_price'],
        // specification: (json['Specification'] as List)
        //         .map((i) => String.fromJson(i))
        //         .toList(),
        specification: json['Specification']);
  }
}
