class AboutModel {
  String about;
  String name;
  List<dynamic> cell;
  List<dynamic> tell;
  String address;
  String email;
  String web;
  List<Social> social;

  AboutModel(
      {this.about,
      this.name,
      this.cell,
      this.tell,
      this.address,
      this.email,
      this.web,
      this.social});
}

class Social {
  String title;
  String link;
  String icon;
  Social(this.title,this.link,this.icon);

   factory Social.fromJson(Map<String, dynamic> json) {
    return Social(
     json['Title'],
     json['Link'],
     json['Icon']
    );
  }

}
