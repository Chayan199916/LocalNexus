class Message {
  final String id;
  final String content;
  final DateTime timestamp;
  final String senderId;
  final String senderName;
  final Map<String, dynamic> nlpMetadata; // Stores NER, sentiment, topics
  final bool isImportant;

  Message({
    required this.id,
    required this.content,
    required this.timestamp,
    required this.senderId,
    required this.senderName,
    this.nlpMetadata = const {},
    this.isImportant = false,
  });
}

class ChatSummary {
  final String id;
  final DateTime startTime;
  final DateTime endTime;
  final String summaryText;
  final List<String> keyTopics;
  final double overallSentiment;
  final List<String> mentionedEntities;
  final List<String> messageIds; // References to original messages
  final SummaryType type;

  ChatSummary({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.summaryText,
    required this.keyTopics,
    required this.overallSentiment,
    required this.mentionedEntities,
    required this.messageIds,
    required this.type,
  });
}

enum SummaryType { hourly, daily, weekly, monthly }
