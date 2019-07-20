class Blog {
  final  int id;
  final  String pic;
  final  String thumb;
  final  String title;
  final  String summary;
  final  String date;
  final int hits;

  Blog._(this.id, this.pic, this.thumb, this.title, this.date, this.summary,this.hits);

  factory Blog.fromJson(Map<String, dynamic> json) {
    return new Blog._(
        json['id'],
        json['pic'],
        json['thumb'],
        json['title'],
        json['date'],
        json['summary'],
        json['hits']
    );
  }
}
