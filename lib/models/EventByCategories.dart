// ignore_for_file: non_constant_identifier_names

class Event {
  final String eventName;
  final String eventCategory;
  final String description;
  final String file;
  final List<String> rules;
  final String flagship;
  final String venue;
  final int endTime;
  final int startTime;
  final List<Cordinators> cordinators;

  Event(
      {required this.eventName,
      required this.eventCategory,
      required this.description,
      required this.file,
      required this.rules,
      required this.flagship,
      required this.venue,
      required this.endTime,
      required this.startTime,
      required this.cordinators});

  Event.fromJson(Map<String, dynamic> json)
      : eventName = json['eventName'],
        eventCategory = json['eventCategory'],
        description = json['description'],
        file = json['file'],
        rules =
            json['rules'] != null ? new List<String>.from(json['rules']) : [],
        flagship = json['flagship'],
        venue = json['venue'],
        endTime = json['endTime'],
        startTime = json['startTime'],
        cordinators = json['coordinators']
            .map<Cordinators>((json) => Cordinators.fromJson(json))
            .toList();
}

class Cordinators {
  final String coordinator_name;
  final String coordinator_number;

  Cordinators(
      {required this.coordinator_name, required this.coordinator_number});

  Cordinators.fromJson(Map<dynamic, dynamic> json)
      : coordinator_name = json['coordinator_name'],
        coordinator_number = json['coordinator_number'];
}
