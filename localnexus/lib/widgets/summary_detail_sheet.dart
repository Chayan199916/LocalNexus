import 'package:flutter/material.dart';
import 'package:localnexus/models/message.dart';
import 'package:timeago/timeago.dart' as timeago;

class SummaryDetailSheet extends StatelessWidget {
  final ChatSummary summary;

  const SummaryDetailSheet({required this.summary});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: ListView(
            controller: scrollController,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${summary.type.toString().split('.').last} Summary',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${timeago.format(summary.startTime)} - ${timeago.format(summary.endTime)}',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              ),
              Divider(height: 32),
              Text(
                'Summary',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(summary.summaryText),
              SizedBox(height: 16),
              Text(
                'Key Topics',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: summary.keyTopics
                    .map((topic) => Chip(
                          label: Text(topic),
                          backgroundColor: Colors.blue[100],
                        ))
                    .toList(),
              ),
              SizedBox(height: 16),
              Text(
                'Mentioned Entities',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: summary.mentionedEntities
                    .map((entity) => Chip(
                          label: Text(entity),
                          backgroundColor: Colors.green[100],
                        ))
                    .toList(),
              ),
              SizedBox(height: 16),
              Text(
                'Overall Sentiment',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              LinearProgressIndicator(
                value: (summary.overallSentiment + 1) /
                    2, // Convert -1 to 1 range to 0 to 1
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation(
                  summary.overallSentiment > 0 ? Colors.green : Colors.red,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
