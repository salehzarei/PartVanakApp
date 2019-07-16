class NewsModel {
  List<Post> post;
  NewsModel({this.post});
}

class Post {
  String id;
  String pic;
  String title;
  String summary;
  String date;
  Post(this.id, this.pic, this.title, this.date, this.summary);

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        json['id'],
        json['pic'],
        json['title'],
        json['summary'],
        json['date']
        );
  }
}
