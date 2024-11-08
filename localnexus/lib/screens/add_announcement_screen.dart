import 'package:flutter/material.dart';
import 'package:localnexus/models/announcement.dart';
import 'package:lucide_icons/lucide_icons.dart';

class AddAnnouncementScreen extends StatelessWidget {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final Function(Announcement) onAdd;

  AddAnnouncementScreen({required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 8),
            Text(
              'Share important information with the community.',
              style: TextStyle(color: Colors.grey[600]),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Announcement Title',
                hintText: 'Enter announcement title',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Announcement Content',
                hintText: 'Enter announcement details',
                border: OutlineInputBorder(),
              ),
              maxLines: 5, // Allow multiple lines for content
            ),
            SizedBox(height: 16),
            ElevatedButton.icon(
                icon: const Icon(LucideIcons.megaphone, size: 20),
                onPressed: () {
                  // Create a new announcement
                  Announcement announcement = Announcement(
                    title: _titleController.text,
                    description: _descriptionController.text,
                  );
                  onAdd(announcement); // Call the callback
                  Navigator.pop(context); // Go back to the dashboard
                },
                label: Text('New Announcement'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black, // Change button color
                  foregroundColor: Colors.white, // Change text color
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), // Rounded corners
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
