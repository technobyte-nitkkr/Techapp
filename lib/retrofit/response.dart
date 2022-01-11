import 'package:techapp/models/Speaker.dart';
import 'package:techapp/models/Sponsor.dart';
import 'package:techapp/models/categories.dart';
import 'package:techapp/models/developers.dart';
import 'package:techapp/models/event_all.dart';
import 'package:techapp/models/event_by_categories.dart';
import 'package:techapp/models/section.dart';
import 'package:techapp/models/user.dart';
import 'package:techapp/providers/fetch_data_provider.dart';

class ResponseData {
  bool success;
  Map<String, dynamic> data;
  String message;

  ResponseData({
    required this.success,
    required this.data,
    required this.message,
  });

  factory ResponseData.fromJson(Map<String, dynamic> json) {
    // print(json.toString());
    return ResponseData(
      success: json["success"],
      data: Map.from(json["data"] ?? {})
          .map((k, v) => MapEntry<String, dynamic>(k, v)),
      message: json["message"],
    );
  }

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "message": message,
      };

  List<Sponsor> getFoodSponsors() {
    List<Sponsor> datad = [];
    for (var item in data["foodSponsors"]) {
      datad.add(Sponsor.fromJson(item));
      // print(item);
    }
    return datad;
  }

  List<Event> getEventList() {
    List<Event> datad = [];
    for (var item in data["events"]) {
      datad.add(Event.fromJson(item));
      // print(item);
    }
    return datad;
  }

  List<Event> getMyEvents() {
    List<Event> datad = [];
    for (var item in data["events"]) {
      datad.add(Event.fromJson(item));
      // print(item);
    }
    FetchDataProvider.myEvents = datad;
    return datad;
  }

  Event getEvent() {
    // print(data);
    // print(message);
    return Event.fromJson(data);
  }

  List<Developer> getDevelopers() {
    List<Developer> datad = [];
    for (var item in data["information"]) {
      datad.add(Developer.fromJson(item));
      // print(item);
    }
    return datad;
  }

  List<Contacts> getTeam() {
    List<Contacts> datad = [];
    for (var item in data["contacts"]) {
      datad.add(Contacts.fromJson(item));
      // print(item);
    }
    return datad;
  }

  List<Speaker> getLectures() {
    List<Speaker> datad = [];
    for (var item in data["lectures"]) {
      datad.add(Speaker.fromJson(item));
      // print(item);
    }
    return datad;
  }

  List<CategorySchema> getCategories() {
    List<CategorySchema> datad = [];
    for (var item in data["categories"]) {
      datad.add(CategorySchema.fromJson(item));
      // print(item);
    }
    return datad;
  }

  List<AllEvents> getAllEvents() {
    List<AllEvents> datad = [];
    for (var item in data["events"]) {
      datad.add(AllEvents.fromJson(item));
      // print(item);
    }
    FetchDataProvider.allEvents = datad;
    return datad;
  }

  UserDetails getProfile() {
    print(data);
    return UserDetails.fromJson(data["user"]);
  }
}
