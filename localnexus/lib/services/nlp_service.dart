import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:localnexus/models/message.dart';

class NLPService {
  final String _baseUrl = 'YOUR_NLP_API_ENDPOINT';
  final http.Client _client = http.Client();

  Future<Map<String, dynamic>> processMessage(Message message) async {
    try {
      final response = await _client.post(
        Uri.parse('$_baseUrl/process-message'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'text': message.content,
          'timestamp': message.timestamp.toIso8601String(),
          'sender': message.senderName,
        }),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      }

      // Fallback to basic processing if API fails
      return _localProcessMessage(message.content);
    } catch (e) {
      print('Error processing message: $e');
      return _localProcessMessage(message.content);
    }
  }

  Map<String, dynamic> _localProcessMessage(String text) {
    return {
      'entities': _extractEntities(text),
      'sentiment': _analyzeSentiment(text),
      'topics': _extractTopics(text),
      'importance_score': _calculateImportance(text),
    };
  }

  List<String> _extractEntities(String text) {
    // Basic entity extraction using regex
    final namePattern = RegExp(r'@\w+');
    final emailPattern = RegExp(r'\b[\w\.-]+@[\w\.-]+\.\w+\b');
    final datePattern = RegExp(r'\d{1,2}\/\d{1,2}\/\d{4}');

    Set<String> entities = {};
    entities.addAll(namePattern.allMatches(text).map((m) => m.group(0)!));
    entities.addAll(emailPattern.allMatches(text).map((m) => m.group(0)!));
    entities.addAll(datePattern.allMatches(text).map((m) => m.group(0)!));

    return entities.toList();
  }

  double _analyzeSentiment(String text) {
    // Basic sentiment analysis using keyword matching
    final positiveWords = {'good', 'great', 'excellent', 'amazing', 'happy'};
    final negativeWords = {'bad', 'poor', 'terrible', 'awful', 'sad'};

    final words = text.toLowerCase().split(' ');
    int score = 0;

    for (var word in words) {
      if (positiveWords.contains(word)) score++;
      if (negativeWords.contains(word)) score--;
    }

    return score / (words.length > 0 ? words.length : 1);
  }

  List<String> _extractTopics(String text) {
    // Basic topic extraction using keyword frequency
    final words = text.toLowerCase().split(' ')
      ..removeWhere((word) => word.length < 4);

    final wordFrequency = <String, int>{};
    for (var word in words) {
      wordFrequency[word] = (wordFrequency[word] ?? 0) + 1;
    }

    // Convert map entries to a list and sort by frequency
    final sortedEntries = wordFrequency.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    // Take the top 3 most frequent words
    return sortedEntries.take(3).map((e) => e.key).toList();
  }

  double _calculateImportance(String text) {
    // Basic importance scoring
    final urgentWords = {'urgent', 'important', 'asap', 'emergency'};
    final words = text.toLowerCase().split(' ');

    int urgentCount = words.where((word) => urgentWords.contains(word)).length;
    return urgentCount > 0 ? 0.8 : 0.3;
  }

  Future<ChatSummary> createSummary({
    required List<Message> messages,
    required SummaryType type,
  }) async {
    try {
      final response = await _client.post(
        Uri.parse('$_baseUrl/create-summary'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'messages': messages
              .map((m) => {
                    'content': m.content,
                    'timestamp': m.timestamp.toIso8601String(),
                    'sender': m.senderName,
                  })
              .toList(),
          'type': type.toString(),
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return ChatSummary(
          id: DateTime.now().toString(),
          startTime: messages.first.timestamp,
          endTime: messages.last.timestamp,
          summaryText: data['summary'],
          keyTopics: List<String>.from(data['topics']),
          overallSentiment: data['sentiment'],
          mentionedEntities: List<String>.from(data['entities']),
          messageIds: messages.map((m) => m.id).toList(),
          type: type,
        );
      }

      // Fallback to local summary generation
      return _createLocalSummary(messages, type);
    } catch (e) {
      print('Error creating summary: $e');
      return _createLocalSummary(messages, type);
    }
  }

  Future<ChatSummary> _createLocalSummary(
    List<Message> messages,
    SummaryType type,
  ) async {
    final allText = messages.map((m) => m.content).join(' ');
    final entities = _extractEntities(allText);
    final topics = _extractTopics(allText);
    final sentiment = _analyzeSentiment(allText);

    return ChatSummary(
      id: DateTime.now().toString(),
      startTime: messages.first.timestamp,
      endTime: messages.last.timestamp,
      summaryText:
          'Discussion containing ${messages.length} messages about ${topics.join(", ")}',
      keyTopics: topics,
      overallSentiment: sentiment,
      mentionedEntities: entities,
      messageIds: messages.map((m) => m.id).toList(),
      type: type,
    );
  }
}
