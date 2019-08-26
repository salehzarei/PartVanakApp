class Ticket {
  final int id;
  final String subject;
  final String abestract;
  final String sender;
  final int read;
  Ticket({
    this.id,
    this.subject,
    this.abestract,
    this.sender,
    this.read});
    
  factory Ticket.fromJson(Map<String, dynamic> json) {
    return new Ticket(
        id: json['id'],
        subject: json['subject'],
        abestract: json['abestract'],
        sender: json['sender'],
        read: json['read']);
  }
}

class ReplyModel {
  final int id;
  final String sender;
  final String message;
  final String date;
  final String pic;


  ReplyModel({
    this.id,
    this.sender,
    this.message,
    this.date,
    this.pic});
    
  factory ReplyModel.fromJson(Map<String, dynamic> json) {
    return new ReplyModel(
        id: json['id'],
        sender: json['sender'],
        message: json['message'],
        date: json['date'],
        pic: json['pic']);
  }
}

//  "id": 238,
//             "sender": "مدیریت",
//             "message": "kmk;lml;kkopk;",
//             "date": "1398/05/31  16:09:30",
//             "pic": null

//             "id": 237,
//             "subject": "موضوع در اپ",
//             "abestract": "من از اپ پیام میدم",
//             "sender": "مسافر",
//             "read": 0
