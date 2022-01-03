class Contacts {
  final String section;
  List<People> people = [];

  Contacts({required this.section, required this.people});

  factory Contacts.fromJson(Map<String, dynamic> json) {
    return Contacts(
      section: json['section'],
      people: (json['people'] as List<dynamic>)
          .map((e) => People.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['section'] = this.section;

    // ignore: unnecessary_null_comparison
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

  People({required this.imageUrl, required this.name, required this.post});

  factory People.fromJson(Map<String, dynamic> json) {
    return People(
      imageUrl: json['imageUrl'] ?? '',
      name: json['name'] ?? '',
      post: json['post'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imageUrl'] = this.imageUrl;
    data['name'] = this.name;
    data['post'] = this.post;
    return data;
  }
}
