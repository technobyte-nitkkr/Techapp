class UserDetails {
  String email;
  String name;
  String picture;
  bool onBoard;
  String? phone;
  String? college;
  String? year;
  bool? admin;
  String? role;

  UserDetails(
      {required this.email,
      required this.name,
      required this.picture,
      required this.onBoard,
      required this.phone,
      required this.college,
      required this.year,
      required this.admin,
      required this.role});

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      email: json['email'],
      name: json['name'],
      picture: json['picture'],
      onBoard: json['onBoard'],
      phone: json['phone'] ?? null,
      college: json['college'] ?? null,
      year: json['year'] ?? null,
      admin: json['admin'] ?? null,
      role: json['role'] ?? null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['name'] = this.name;
    data['picture'] = this.picture;
    data['onBoard'] = this.onBoard;
    data['phone'] = this.phone;
    data['college'] = this.college;
    data['year'] = this.year;
    data['admin'] = this.admin;
    data['role'] = this.role;

    return data;
  }
}
