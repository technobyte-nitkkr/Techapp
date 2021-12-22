class EventCategory {
  final String categoryName;
  final String name;
  final String iconImage;

  EventCategory(
    this.categoryName, {
    required this.name,
    required this.iconImage,
  });
}

List<EventCategory> categories = [
  EventCategory("Astronomy",
      name: "Astronomy", iconImage: "assets/images/categories/astronomy.png"),
  EventCategory("Design",
      name: "Design", iconImage: "assets/images/categories/design.png"),
  EventCategory("Informals",
      name: "Informals", iconImage: "assets/images/categories/informals.png"),
  EventCategory("Managerial",
      name: "Managerial", iconImage: "assets/images/categories/managerial.png"),
  EventCategory("Online-Events",
      name: "Online-Events",
      iconImage: "assets/images/categories/online-events.png"),
  EventCategory("Papyrus-Vitae",
      name: "Papyrus-Vitae",
      iconImage: "assets/images/categories/papyrus-vitae.png"),
  EventCategory("Programming",
      name: "Programming",
      iconImage: "assets/images/categories/programming.png"),
  EventCategory("Quizzes",
      name: "Quizzes", iconImage: "assets/images/categories/quizzes.png"),
  EventCategory("Robotics",
      name: "Robotics", iconImage: "assets/images/categories/robotics.png"),
];
