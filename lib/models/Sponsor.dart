// ignore_for_file: non_constant_identifier_names

class Sponsor {
  final String imageurl;
  final String link;
  final String name;
  
  Sponsor ({
    required this.imageurl,
    required this.link,
    required this.name,
  });

  // Sponsor.fromJson(Map<String, dynamic> json)
  //     : imageurl = json['imageUrl'],
  //       link = json['link'],
  //       name = json['name'];

  // ignore: empty_constructor_bodies
  factory Sponsor.fromJson(Map<String, dynamic> json) {
    return Sponsor(
      imageurl: json['imageUrl'] as String,
      link: json['link'] as String,
      name: json['name'] as String,
    );
  }
}