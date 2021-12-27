class Noti {
  String body;
  String title;
  String? link;
  String? image;

  Noti({required this.body, required this.title, this.link, this.image});

  Noti.fromJson(Map<String, dynamic> json)
      : body = json['body'],
        title = json['title'],
        link = json['link'] == null ? null : json['link'],
        image = json['image'] == null ? null : json['image'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['body'] = this.body;
    data['title'] = this.title;
    data['link'] = this.link != null ? this.link : null;
    data['image'] = this.image != null ? this.image : null;
    return data;
  }
}
