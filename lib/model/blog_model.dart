class Blog {
  final int id;
  final String pic;
  final String thumb;
  final String title;
  final String summary;
  final String content;
  final String date;
  final int hits;
  List<BlogComment> comment;

  Blog(
      {this.id,
      this.pic,
      this.thumb,
      this.title,
      this.date,
      this.summary,
      this.content,
      this.hits,
      this.comment});

  factory Blog.fromJson(Map<String, dynamic> json) {
    return new Blog(
        id: json['id'],
        pic: json['pic'],
        thumb: json['thumb'],
        title: json['title'],
        date: json['date'],
        summary: json['summary'],
        hits: json['hits']);
  }
}

class BlogComment {
  String name;
  String message;
  String replay;
  String replayDate;
  String cDate;
  String userPic='https://safirparvaz.ir/skin/mobel/images/user-2.jpg';
  String adminPic='https://safirparvaz.ir/skin/mobel/images/user-2.jpg';

  BlogComment(this.name, this.message, this.replay, this.replayDate, this.cDate);

  factory BlogComment.fromJson(Map<String, dynamic> json) {
      return BlogComment(
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
