class Speaker {
  final String date;
  final String desc;
  final String imageurl;
  final String name;
  final String time;

  Speaker({
    required this.date,
    required this.desc,
    required this.imageurl,
    required this.name,
    required this.time,
  });

  factory Speaker.fromJson(Map<String, dynamic> json) {
    return Speaker(
      date: json['date'] as String,
      desc: json['desc'] as String,
      imageurl: json['imageUrl'] as String,
      name: json['name'] as String,
      time:json['time'] as String,
    );
  }
}