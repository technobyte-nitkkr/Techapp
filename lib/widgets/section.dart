// @dart=2.9
class Contacts {
  String section;
  List<People> people = [];

  Contacts({this.section, this.people});

  Contacts.fromJson(Map<String, dynamic> json) {
    section = json['section'];
    if (json['people'] != null) {
      people = json["people"].map<People>((p) => People.fromJson(p)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['section'] = this.section;
    if (this.people != null) {
      data['people'] = this.people.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class People {
  String imageUrl;
  String name;
  String post;

  People({this.imageUrl, this.name, this.post});

  People.fromJson(Map<String, dynamic> json) {
    if (json['imageUrl'] == "")
      imageUrl =
          'https://www.google.com/url?sa=i&url=https%3A%2F%2Fcvbay.com%2Ftestimonial%2Fashley-j%2Fdummy-image%2F&psig=AOvVaw0GfkH-fBm6GWFfOF2QyOda&ust=1640702399536000&source=images&cd=vfe&ved=0CAsQjRxqFwoTCPizovGahPUCFQAAAAAdAAAAABAD';
    else
    imageUrl = json['imageUrl'];
    name = json['name'];
    post = json['post'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imageUrl'] = this.imageUrl;
    data['name'] = this.name;
    data['post'] = this.post;
    return data;
  }
}
