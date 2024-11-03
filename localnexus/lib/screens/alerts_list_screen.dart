import 'package:flutter/material.dart';
import 'package:localnexus/models/alert.dart';

class AlertsListScreen extends StatelessWidget {
  final List<Alert> alerts;

  AlertsListScreen({required this.alerts});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alerts'),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView.builder(
        itemCount: alerts.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(alerts[index].title),
              subtitle: Text(alerts[index].description),
            ),
          );
        },
      ),
    );
  }
}
