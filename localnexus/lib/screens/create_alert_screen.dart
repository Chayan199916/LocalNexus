import 'package:flutter/material.dart';
import 'package:localnexus/models/alert.dart';

class CreateAlertScreen extends StatelessWidget {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final Function(Alert) onAdd;

  CreateAlertScreen({required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Alert'),
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
                // Create a new alert
                Alert alert = Alert(
                  title: _titleController.text,
                  description: _descriptionController.text,
                );
                onAdd(alert); // Call the callback
                Navigator.pop(context); // Go back to the dashboard
              },
              child: Text('Create Alert'),
            ),
          ],
        ),
      ),
    );
  }
}
