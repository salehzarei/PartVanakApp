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

//             "id": 237,
//             "subject": "موضوع در اپ",
//             "abestract": "من از اپ پیام میدم",
//             "sender": "مسافر",
//             "read": 0
