enum EventType { social, safety, maintenance, educational, other }

enum RecurrenceType { none, daily, weekly, monthly, custom }

class Event {
  final String id;
  final String title;
  final String description;
  final DateTime startDateTime;
  final DateTime endDateTime;
  final String location;
  final int? capacityLimit;
  final DateTime? rsvpDeadline;
  final List<Organizer> organizers;
  final List<String> sponsors;
  final List<String> targetAudience;
  final String? additionalNotes;
  final EventType type;
  final RecurrencePattern? recurrence;
  final List<String> mediaUrls;
  final bool hasFeedbackForm;
  final int currentRsvpCount;
  final DateTime createdAt;
  final String createdBy;

  Event({
    required this.id,
    required this.title,
    required this.description,
    required this.startDateTime,
    required this.endDateTime,
    required this.location,
    this.capacityLimit,
    this.rsvpDeadline,
    required this.organizers,
    this.sponsors = const [],
    required this.targetAudience,
    this.additionalNotes,
    required this.type,
    this.recurrence,
    this.mediaUrls = const [],
    this.hasFeedbackForm = false,
    this.currentRsvpCount = 0,
    required this.createdAt,
    required this.createdBy,
  });
}

class Organizer {
  final String id;
  final String name;
  final String role;
  final String? contactInfo;

  Organizer({
    required this.id,
    required this.name,
    required this.role,
    this.contactInfo,
  });
}

class RecurrencePattern {
  final RecurrenceType type;
  final List<int>? daysOfWeek; // 1-7 for weekly
  final int? dayOfMonth; // 1-31 for monthly
  final DateTime? until;
  final int? occurrences;

  RecurrencePattern({
    required this.type,
    this.daysOfWeek,
    this.dayOfMonth,
    this.until,
    this.occurrences,
  });
}
