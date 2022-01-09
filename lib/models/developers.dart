class Developer {
  final String imageurl;
  final String github;
  final String linkedin;
  final String insta;
  final String name;
  final String year;

  Developer({
    required this.imageurl,
    required this.name,
    required this.linkedin,
    required this.github,
    required this.insta,
    required this.year,
  });

  factory Developer.fromJson(Map<String, dynamic> json) {
    return Developer(
      imageurl: json['imageUrl'] as String,
      name: json['name'] as String,
      linkedin: json['linkedin'] as String,
      github: json['github'] as String,
      insta: json['insta'] as String,
      year: json['year'] as String,
    );
  }
}
