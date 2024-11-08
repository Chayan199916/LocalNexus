import 'package:flutter/material.dart';
import 'package:localnexus/models/alert.dart';
import 'package:lucide_icons/lucide_icons.dart';

class CreateAlertScreen extends StatelessWidget {
  final TextEditingController _titleController = TextEditingController();
  final String? _selectedAlertType = null; // Initialize with null
  final Function(Alert) onAdd;

  CreateAlertScreen({required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // Added ScrollView for overflow handling
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 8),
            Text(
              'Provide details for the new safety alert.',
              style: TextStyle(color: Colors.grey[600]),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Alert Title',
                hintText: 'Enter alert title',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedAlertType,
              decoration: InputDecoration(
                labelText: 'Alert Type',
                border: OutlineInputBorder(),
              ),
              items:
                  <String>['Type 1', 'Type 2', 'Type 3'] // Example alert types
                      .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                // Handle alert type selection
              },
              hint: Text('Select alert type'),
            ),
            SizedBox(height: 16),
            ElevatedButton.icon(
              icon: const Icon(LucideIcons.bell, size: 20),
              onPressed: () {
                // Create a new alert
                Alert alert = Alert(
                  title: _titleController.text,
                  description:
                      'Your alert description here', // Added required description
                  // Add other properties as needed
                );
                onAdd(alert); // Call the callback
                Navigator.pop(context); // Go back to the dashboard
              },
              label: Text('New Alert'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black, // Change button color
                foregroundColor: Colors.white, // Change text color
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8), // Rounded corners
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
