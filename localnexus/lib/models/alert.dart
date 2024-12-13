enum AlertSeverity { low, medium, high, critical }

enum AlertSource { admin, system, external }

class Alert {
  final String id;
  final String title;
  final String description;
  final AlertSeverity severity;
  final List<String> targetAudience;
  final double? geofenceRange; // in meters
  final String? actionPlan;
  final DateTime createdAt;
  final DateTime expiresAt;
  final List<String> attachments; // URLs to attached files
  final AlertSource source;
  final Map<String, dynamic>? metadata; // For additional source-specific data

  Alert({
    required this.id,
    required this.title,
    required this.description,
    required this.severity,
    required this.targetAudience,
    this.geofenceRange,
    this.actionPlan,
    required this.createdAt,
    required this.expiresAt,
    this.attachments = const [],
    required this.source,
    this.metadata,
  });
}
