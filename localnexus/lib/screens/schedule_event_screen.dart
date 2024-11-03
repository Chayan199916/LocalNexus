import 'package:flutter/material.dart';
import 'package:localnexus/models/event.dart';

class ScheduleEventScreen extends StatelessWidget {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final Function(Event) onAdd;

  ScheduleEventScreen({required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Schedule Event'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Event Title'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _dateController,
              decoration: InputDecoration(labelText: 'Date (YYYY-MM-DD)'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _timeController,
              decoration: InputDecoration(labelText: 'Time (HH:MM)'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Create a new event
                Event event = Event(
                  title: _titleController.text,
                  date: _dateController.text,
                  time: _timeController.text,
                );
                onAdd(event); // Call the callback
                Navigator.pop(context); // Go back to the dashboard
              },
              child: Text('Schedule Event'),
            ),
          ],
        ),
      ),
    );
  }
}
