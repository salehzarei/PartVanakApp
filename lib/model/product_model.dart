class Product {
  final int id;
  final String title;
  final String summary;
  final String content;
  final String price;
  final int hits;
  final String pic;
  final String thumb;
  List<ProductComment> comment;
  List<String> gallery;

  Product(
      {this.id,
      this.title,
      this.summary,
      this.content,
      this.price,
      this.hits,
      this.thumb,
      this.pic,
      this.comment,
      this.gallery});

  factory Product.fromJson(Map<String, dynamic> json) {
    return new Product(
        id: json['id'],
        pic: json['pic'],
        thumb: json['thumb'],
        title: json['title'],
        summary: json['summary'],
        hits: json['hits'],
        gallery: (json['gallery'] as List)
              .map((i) =>i)
              .toList() );
  }
}

class ProductComment {
  String name;
  String message;
  String replay;
  String replayDate;
  String cDate;
  String userPic='https://safirparvaz.ir/skin/mobel/images/user-2.jpg';
  String adminPic='https://safirparvaz.ir/skin/mobel/images/user-2.jpg';

  ProductComment(this.name, this.message, this.replay, this.replayDate, this.cDate);

  factory ProductComment.fromJson(Map<String, dynamic> json) {
      return ProductComment(
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
