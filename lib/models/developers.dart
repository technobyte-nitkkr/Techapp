// ignore_for_file: non_constant_identifier_names

class Developers {
  final String imageurl;
  final String link;
  final String name;
  final String year;

  Developers({
    required this.imageurl,
    required this.name,
    required this.link,
    required this.year,
  });

  // Developers.fromJson(Map<String, dynamic> json)
  //     : imageurl = json['imageUrl'],
  //       link = json['link'],
  //       name = json['name'];

  // ignore: empty_constructor_bodies
  factory Developers.fromJson(Map<String, dynamic> json) {
    return Developers(
      imageurl: json['imageUrl'] as String,
      name: json['name'] as String,
      link: json['link'] as String,
      year: json['year'] as String,
    );
  }
}
