class Blog {
  final  int id;
  final  String pic;
  final  String thumb;
  final  String title;
  final  String summary;
  final  String content;
  final  String date;
  final int hits;

  Blog({this.id, this.pic, this.thumb, this.title, this.date, this.summary,this.content,this.hits});

  factory Blog.fromJson(Map<String, dynamic> json) {
    return new Blog(
        id:json['id'],
        pic:json['pic'],
        thumb:json['thumb'],
        title:json['title'],
        date:json['date'],
        summary:json['summary'],
        hits:json['hits']
    );
  }
}
