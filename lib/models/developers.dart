class Developer {
  final String imageurl;
  final String link;
  final String name;
  final String year;

  Developer({
    required this.imageurl,
    required this.name,
    required this.link,
    required this.year,
  });

  factory Developer.fromJson(Map<String, dynamic> json) {
    return Developer(
      imageurl: json['imageUrl'] as String,
      name: json['name'] as String,
      link: json['link'] as String,
      year: json['year'] as String,
    );
  }
}
