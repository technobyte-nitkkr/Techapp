class AllEvents {
  String? eventName;
  String? eventCategory;

  AllEvents({required this.eventName, required this.eventCategory});

  AllEvents.fromJson(Map<String, dynamic> json) {
    eventName = json['eventName'];
    eventCategory = json['eventCategory'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['eventName'] = this.eventName;
    data['eventCategory'] = this.eventCategory;
    return data;
  }
}
