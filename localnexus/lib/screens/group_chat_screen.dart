import 'dart:async';

import 'package:flutter/material.dart';
import 'package:localnexus/models/message.dart';
import 'package:localnexus/services/nlp_service.dart';
import 'package:localnexus/widgets/message_bubble.dart';
import 'package:localnexus/widgets/summary_card.dart';
import 'package:localnexus/widgets/summary_detail_sheet.dart';

class GroupChatScreen extends StatefulWidget {
  @override
  _GroupChatScreenState createState() => _GroupChatScreenState();
}

class _GroupChatScreenState extends State<GroupChatScreen> {
  final List<dynamic> chatItems = []; // Can contain Message or ChatSummary
  final TextEditingController _controller = TextEditingController();
  final NLPService _nlpService = NLPService();
  Timer? _summaryTimer;

  @override
  void initState() {
    super.initState();
    _startSummaryTimer();
  }

  @override
  void dispose() {
    _summaryTimer?.cancel();
    super.dispose();
  }

  void _startSummaryTimer() {
    // Create hourly summaries
    _summaryTimer = Timer.periodic(const Duration(hours: 1), (_) {
      _createHourlySummary();
    });
  }

  Future<void> _createHourlySummary() async {
    final List<Message> lastHourMessages = _getLastHourMessages();
    if (lastHourMessages.isEmpty) return;

    final summary = await _nlpService.createSummary(
      messages: lastHourMessages,
      type: SummaryType.hourly,
    );

    setState(() {
      // Replace messages with summary
      chatItems.removeWhere(
          (item) => item is Message && lastHourMessages.contains(item));
      chatItems.add(summary);
    });
  }

  void _sendMessage() async {
    if (_controller.text.isNotEmpty) {
      final newMessage = Message(
        id: DateTime.now().toString(),
        content: _controller.text,
        timestamp: DateTime.now(),
        senderId: 'current_user_id',
        senderName: 'Current User',
      );

      // Process message with NLP
      final nlpMetadata = await _nlpService.processMessage(newMessage);
      final enrichedMessage = Message(
        id: newMessage.id,
        content: newMessage.content,
        timestamp: newMessage.timestamp,
        senderId: newMessage.senderId,
        senderName: newMessage.senderName,
        nlpMetadata: nlpMetadata,
        isImportant: nlpMetadata['importance_score'] > 0.7,
      );

      setState(() {
        chatItems.add(enrichedMessage);
        _controller.clear();
      });
    }
  }

  List<Message> _getLastHourMessages() {
    final oneHourAgo = DateTime.now().subtract(Duration(hours: 1));
    return chatItems
        .whereType<Message>()
        .where((msg) => msg.timestamp.isAfter(oneHourAgo))
        .toList();
  }

  void _showSummaryOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Icon(Icons.access_time),
            title: Text('Generate Hourly Summary'),
            onTap: () {
              Navigator.pop(context);
              _createHourlySummary();
            },
          ),
          ListTile(
            leading: Icon(Icons.calendar_today),
            title: Text('Generate Daily Summary'),
            onTap: () async {
              Navigator.pop(context);
              final summary = await _nlpService.createSummary(
                messages: chatItems.whereType<Message>().toList(),
                type: SummaryType.daily,
              );
              setState(() {
                chatItems.add(summary);
              });
            },
          ),
        ],
      ),
    );
  }

  void _showMessageOptions(BuildContext context, Message message) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Icon(Icons.copy),
            title: Text('Copy Message'),
            onTap: () {
              // Copy message to clipboard
              Navigator.pop(context);
            },
          ),
          if (message.isImportant)
            ListTile(
              leading: Icon(Icons.star_border),
              title: Text('Remove from Important'),
              onTap: () {
                Navigator.pop(context);
                // Implement importance toggle
              },
            )
          else
            ListTile(
              leading: Icon(Icons.star),
              title: Text('Mark as Important'),
              onTap: () {
                Navigator.pop(context);
                // Implement importance toggle
              },
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white, // White background for app bar
        title: Text(
          'Group Chat',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ), // Chat title with clean typography
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            icon: const Icon(Icons.summarize),
            onPressed: () => _showSummaryOptions(context),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              itemCount: chatItems.length,
              itemBuilder: (context, index) {
                final item = chatItems[index];

                if (item is ChatSummary) {
                  return SummaryCard(
                    summary: item,
                    onTap: () => _showDetailedSummary(context, item),
                  );
                }

                return MessageBubble(
                  message: item as Message,
                  onLongPress: () => _showMessageOptions(context, item),
                );
              },
            ),
          ),
          // Message input area with Notion-like style
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(30.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: TextField(
                          controller: _controller,
                          decoration: InputDecoration(
                            hintText: 'Type a message...',
                            hintStyle: TextStyle(
                                color: Colors.grey[600], fontSize: 14),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 14),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.attach_file), // Attach icon
                      onPressed: () {
                        // Implement attach functionality
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.send), // Send button
                      onPressed: _sendMessage,
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Optimal posting time: Now',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'High Activity',
                        style: TextStyle(fontSize: 12, color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showDetailedSummary(BuildContext context, ChatSummary summary) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => SummaryDetailSheet(summary: summary),
    );
  }
}
