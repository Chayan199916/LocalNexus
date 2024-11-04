class Event {
  final String title;
  final String date;
  final String time;
  final String location;
  final String description;

  Event({
    required this.title,
    required this.date,
    required this.time,
    required this.location,
    this.description = '',
  });
}
