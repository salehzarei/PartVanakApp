class OrderModel {
  int id;
  String tourTitle;
  int tell;
  String email;
  String cell;
  String date;
  String paymentType;
  int status;
  String paymentTitle;
  String statusTitle;

  OrderModel(
      {this.id,
      this.tourTitle,
      this.tell,
      this.email,
      this.cell,
      this.date,
      this.paymentType,
      this.status,
      this.paymentTitle,
      this.statusTitle});

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      tourTitle: json['tourTitle'],
      tell: json['tell'],
      email: json['email'],
      cell: json['cell'],
      date: json['date'],
      paymentType: json['paymentType'],
      status: json['status'],
      paymentTitle: json['paymentTitle'],
      statusTitle: json['statusTitle'],
    );
  }
}
