class ToureFilterModel {
  String source;
  String destination;
  String date;
  String accommodation;
  String vehicl;
  String tour_type;
  String special;
  String foreign;
  String order;
  String sort;

  ToureFilterModel(
      {this.source = "",
      this.destination = "",
      this.date = "",
      this.accommodation = "",
      this.vehicl = "",
      this.tour_type = "",
      this.special = "",
      this.foreign = "",
      this.order = "",
      this.sort = ""});

  // factory ToureFilterModel.fromJson(Map<String, dynamic> json) {
  //   return ToureFilterModel(
  //       source: json['source'],
  //       destination: json['destination'],
  //       date: json['date'],
  //       accommodation: json['accommodation'],
  //       vehicl: json['vehicl'],
  //       tour_type: json['tour_type'],
  //       special: json['special'],
  //       foreign: json['foreign'],
  //       order: json['order'],
  //       sort: json['sort']);
  // }
  toJson() {
    return {
      "source": source,
      "destination": destination,
      "date": date,
      "accommodation": accommodation,
      "vehicl": vehicl,
      "tour_type": tour_type,
      "special": special,
      "foreign": foreign,
      "order": order,
      "sort": sort
    };
  }
}
