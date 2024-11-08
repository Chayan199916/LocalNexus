import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as picker;
import 'package:localnexus/models/event.dart';
import 'package:lucide_icons/lucide_icons.dart';

class ScheduleEventScreen extends StatelessWidget {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final Function(Event) onAdd;

  ScheduleEventScreen({required this.onAdd});

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
              'Add a new event to the community calendar.',
              style: TextStyle(color: Colors.grey[600]),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Event Title',
                border: OutlineInputBorder(),
                hintText: 'Enter event title',
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _dateController,
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'Event Date and Time',
                border: OutlineInputBorder(),
                hintText: 'Select date and time',
                suffixIcon: IconButton(
                  icon: Icon(Icons.calendar_today),
                  onPressed: () {
                    _selectDateTime(context);
                  },
                ),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _locationController,
              decoration: InputDecoration(
                labelText: 'Event Location',
                border: OutlineInputBorder(),
                hintText: 'Enter event location',
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Event Description',
                border: OutlineInputBorder(),
                hintText: 'Enter event description',
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton.icon(
                icon: const Icon(LucideIcons.calendar, size: 20),
                onPressed: () {
                  Event event = Event(
                    title: _titleController.text,
                    date: _dateController.text.split(' ')[0],
                    time: _dateController.text.split(' ')[1],
                    location: _locationController.text,
                    description: _descriptionController.text,
                  );
                  onAdd(event);
                  Navigator.pop(context);
                },
                label: Text('Schedule Event'),
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

  void _selectDateTime(BuildContext context) {
    picker.DatePicker.showDateTimePicker(
      context,
      showTitleActions: true,
      onConfirm: (date) {
        String formattedDate =
            "${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}";
        _dateController.text = formattedDate;
      },
      currentTime: DateTime.now(),
      locale: picker.LocaleType.en,
    );
  }
}
