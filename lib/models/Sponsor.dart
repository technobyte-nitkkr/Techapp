class Sponsor {
  final String imageurl;
  final String link;
  final String name;

  Sponsor({
    required this.imageurl,
    required this.link,
    required this.name,
  });

  factory Sponsor.fromJson(Map<String, dynamic> json) {
    return Sponsor(
      imageurl: json['imageUrl'] as String,
      link: json['link'] as String,
      name: json['name'] as String,
    );
  }
}
