class Speaker {
  final String date;
  final String desc;
  final String imageurl;
  final String name;
  final String time;
  final String linkedin;
  final String insta;
  final String facebook;
  final String link;

  Speaker({
    required this.date,
    required this.desc,
    required this.imageurl,
    required this.name,
    required this.time,
    required this.linkedin,
    required this.insta,
    required this.facebook,
    required this.link,
  });

  factory Speaker.fromJson(Map<String, dynamic> json) {
    return Speaker(
      date: json['date'] as String,
      desc: json['desc'] as String,
      imageurl: json['imageUrl'] as String,
      name: json['name'] as String,
      time: json['time'] as String,
      linkedin: json['linkedin'] as String,
      insta: json['insta'] as String,
      facebook: json['facebook'] as String,
      link: json['link'] as String,
    );
  }
}
