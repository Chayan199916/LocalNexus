import 'package:flutter/material.dart';

class RecentAlerts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Alerts',
          style: Theme.of(context).textTheme.headline6,
        ),
        SizedBox(height: 10),
        AlertCard(
          title: 'Weather Alert',
          message: 'Severe thunderstorm warning in effect',
          color: Colors.red,
          status: 'Urgent',
        ),
        AlertCard(
          title: 'Maintenance Notice',
          message: 'Water shutdown scheduled for tomorrow',
          color: Colors.yellow,
          status: 'Notice',
        ),
      ],
    );
  }
}

class AlertCard extends StatelessWidget {
  final String title;
  final String message;
  final Color color;
  final String status;

  AlertCard(
      {required this.title,
      required this.message,
      required this.color,
      required this.status});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color.withOpacity(0.1),
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Text(message),
            SizedBox(height: 5),
            Text(status, style: TextStyle(color: color)),
          ],
        ),
      ),
    );
  }
}
