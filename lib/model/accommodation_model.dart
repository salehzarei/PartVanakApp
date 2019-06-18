class Accommodation {
  final int accommodation_type;
  final String title;
  final String hotel_title;
  final int singel_price;
  final int adult_price;
  final int child_price;
  final int child_price_bed;
  final int baby_price;
  final List<String> specification;

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
}
