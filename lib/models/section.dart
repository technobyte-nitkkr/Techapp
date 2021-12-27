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
    imageUrl = json['imageUrl'] ?? "";
    name = json['name'] ?? "";
    post = json['post'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imageUrl'] = this.imageUrl;
    data['name'] = this.name;
    data['post'] = this.post;
    return data;
  }
}
