class UserModel {
  String user;
  int status;
  String name;
  String family;
  String tell;
  String cell;
  String email;
  int ostan;
  int city;
  String address;
  String birthDate;
  String pic;
  String thumb;
  String nationalCode;
  String postalCode;

  UserModel(
      {this.user,
      this.status,
      this.name,
      this.family,
      this.tell,
      this.cell,
      this.email,
      this.ostan,
      this.city,
      this.address,
      this.birthDate,
      this.pic,
      this.thumb,
      this.nationalCode,
      this.postalCode
      });

      factory UserModel.fromJson(Map<String, dynamic> json){
        return UserModel(
          user: json['User'],
          status: json['Status'],
          name: json['Name'],
          family: json['Family'],
          tell: json['Tell'],
          cell: json['Cell'],
          email: json['Email'],
          ostan: json['Ostan'],
          city: json['City'],
          address: json['Address'],
          birthDate: json['BirthDate'],
          pic: json['Pic'],
          thumb: json['Thumb'],
          nationalCode: json['NationalCode'],
          postalCode: json['PostalCode']
          );
      }
}
