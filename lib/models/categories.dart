class CategorySchema {
  String categoryName;
  String imgUrl;
  String icon;

  CategorySchema(
      {required this.categoryName, required this.imgUrl, required this.icon});

  factory CategorySchema.fromJson(Map<String, dynamic> json) {
    return CategorySchema(
        categoryName: json['categoryName'],
        imgUrl: json['imgUrl'],
        icon: json['icon']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['categoryName'] = this.categoryName;
    data['imgUrl'] = this.imgUrl;
    data['icon'] = this.icon;
    return data;
  }
}
