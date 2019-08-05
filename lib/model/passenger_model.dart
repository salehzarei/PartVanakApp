class PassengerModel {
  String id;
  String title;
  String type;
  String name;
  String family;
  String melicode;
  String nationality;
  String sex;
  String brith;

  PassengerModel(
      {this.id,
      this.title,
      this.type,
      this.name,
      this.family,
      this.melicode,
      this.nationality,
      this.sex,
      this.brith});

  toJson() {
    return {
      'Name': name,
      'Family': family,
      'Gender': sex,
      'Nationality': nationality.toString(),
      'National_code': melicode,
      'Birth_date': brith,
      'Ages': 1,
    };
  }
}
