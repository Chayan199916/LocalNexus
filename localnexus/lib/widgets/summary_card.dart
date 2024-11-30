import 'package:flutter/material.dart';
import 'package:localnexus/models/message.dart';

class SummaryCard extends StatelessWidget {
  final ChatSummary summary;
  final VoidCallback onTap;

  const SummaryCard({
    required this.summary,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.summarize, color: Colors.blue),
                  SizedBox(width: 8),
                  Text(
                    '${summary.type.toString().split('.').last} Summary',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                summary.summaryText,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: summary.keyTopics
                    .map((topic) => Chip(
                          label: Text(topic),
                          backgroundColor: Colors.grey[200],
                        ))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
