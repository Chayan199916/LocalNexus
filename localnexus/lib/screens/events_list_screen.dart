import 'package:flutter/material.dart';
import 'package:localnexus/models/event.dart';

class EventsListScreen extends StatelessWidget {
  final List<Event> events;

  EventsListScreen({required this.events});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Events'),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(events[index].title),
              subtitle: Text('${events[index].date} at ${events[index].time}'),
            ),
          );
        },
      ),
    );
  }
}
