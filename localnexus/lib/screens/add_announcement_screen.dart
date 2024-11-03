import 'package:flutter/material.dart';
import 'package:localnexus/models/announcement.dart';

class AddAnnouncementScreen extends StatelessWidget {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final Function(Announcement) onAdd;

  AddAnnouncementScreen({required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Announcement'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Create a new announcement
                Announcement announcement = Announcement(
                  title: _titleController.text,
                  description: _descriptionController.text,
                );
                onAdd(announcement); // Call the callback
                Navigator.pop(context); // Go back to the dashboard
              },
              child: Text('Add Announcement'),
            ),
          ],
        ),
      ),
    );
  }
}
