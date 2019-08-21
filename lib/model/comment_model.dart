class Comment {
  String name;
  String message;
  String replay;
  String replayDate;
  String cDate;
  String userPic='https://safirparvaz.ir/skin/mobel/images/user-2.jpg';
  String adminPic='https://safirparvaz.ir/skin/mobel/images/user-2.jpg';

  Comment(this.name, this.message, this.replay, this.replayDate, this.cDate);

  factory Comment.fromJson(Map<String, dynamic> json) {
      return Comment(
        json['name'],
        json['message'], 
        json['replay'],
        json['replayDate'], 
        json['cDate']);
  }
}
// name	"ایرانی"
// message	"تسسستت تسسستتیتسیب تسسستتیتسیبیتسیب"
// replay	"تبل نلا لبل نمت"
// replayDate	"1396/02/29"
// cDate	"1396/02/28"
