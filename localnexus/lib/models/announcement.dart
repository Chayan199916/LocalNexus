enum AnnouncementPriority { normal, urgent }

class Announcement {
  final String id;
  final String title;
  final String description;
  final List<String> targetAudience;
  final DateTime startDate;
  final DateTime expiryDate;
  final AnnouncementPriority priority;
  final List<String> attachments; // URLs to attached files
  final List<String> tags;
  final Map<String, String> actionableLinks; // {label: url}
  final DateTime createdAt;
  final String createdBy;

  Announcement({
    required this.id,
    required this.title,
    required this.description,
    required this.targetAudience,
    required this.startDate,
    required this.expiryDate,
    this.priority = AnnouncementPriority.normal,
    this.attachments = const [],
    this.tags = const [],
    this.actionableLinks = const {},
    required this.createdAt,
    required this.createdBy,
  });
}
