import 'package:flutter/material.dart';
import 'package:localnexus/models/event.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:file_picker/file_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

class ScheduleEventScreen extends StatefulWidget {
  final Function(Event) onAdd;

  ScheduleEventScreen({required this.onAdd});

  @override
  _ScheduleEventScreenState createState() => _ScheduleEventScreenState();
}

class _ScheduleEventScreenState extends State<ScheduleEventScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();
  final _notesController = TextEditingController();
  final _capacityController = TextEditingController();
  final _organizerNameController = TextEditingController();
  final _organizerRoleController = TextEditingController();
  final _organizerContactController = TextEditingController();

  DateTime _startDateTime = DateTime.now();
  DateTime _endDateTime = DateTime.now().add(Duration(hours: 2));
  DateTime? _rsvpDeadline;
  EventType _eventType = EventType.social;
  List<String> _mediaUrls = [];
  Set<String> _selectedAudience = {};
  List<Organizer> _organizers = [];
  List<String> _sponsors = [];
  bool _hasFeedbackForm = false;
  RecurrencePattern? _recurrence;

  final List<String> _availableAudiences = [
    'All Residents',
    'Property Owners',
    'Tenants',
    'Families',
    'Seniors',
    'Youth'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Schedule Event'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Event Title*',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Title is required' : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Event Description*',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Description is required' : null,
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ListTile(
                      title: Text('Start Date & Time'),
                      subtitle: Text(
                        DateFormat('MMM dd, yyyy HH:mm').format(_startDateTime),
                      ),
                      trailing: Icon(Icons.calendar_today),
                      onTap: () => _selectDateTime(context, true),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: Text('End Date & Time'),
                      subtitle: Text(
                        DateFormat('MMM dd, yyyy HH:mm').format(_endDateTime),
                      ),
                      trailing: Icon(Icons.calendar_today),
                      onTap: () => _selectDateTime(context, false),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _locationController,
                decoration: InputDecoration(
                  labelText: 'Event Location*',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Location is required' : null,
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<EventType>(
                value: _eventType,
                decoration: InputDecoration(
                  labelText: 'Event Type*',
                  border: OutlineInputBorder(),
                ),
                items: EventType.values.map((type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Text(type.toString().split('.').last.toUpperCase()),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() => _eventType = value!);
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _capacityController,
                decoration: InputDecoration(
                  labelText: 'Capacity Limit (optional)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16),
              ListTile(
                title: Text('RSVP Deadline'),
                subtitle: Text(_rsvpDeadline == null
                    ? 'No deadline set'
                    : DateFormat('MMM dd, yyyy').format(_rsvpDeadline!)),
                trailing: Icon(Icons.calendar_today),
                onTap: () => _selectRSVPDeadline(context),
              ),
              SizedBox(height: 16),
              Text('Target Audience*', style: TextStyle(fontSize: 16)),
              Wrap(
                spacing: 8,
                children: _availableAudiences.map((audience) {
                  return FilterChip(
                    label: Text(audience),
                    selected: _selectedAudience.contains(audience),
                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
                          _selectedAudience.add(audience);
                        } else {
                          _selectedAudience.remove(audience);
                        }
                      });
                    },
                  );
                }).toList(),
              ),
              SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Organizers*', style: TextStyle(fontSize: 16)),
                      SizedBox(height: 8),
                      ..._organizers.map((organizer) => ListTile(
                            title: Text(organizer.name),
                            subtitle: Text(organizer.role),
                            trailing: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                setState(() {
                                  _organizers.remove(organizer);
                                });
                              },
                            ),
                          )),
                      ElevatedButton.icon(
                        icon: Icon(Icons.add),
                        label: Text('Add Organizer'),
                        onPressed: () => _showAddOrganizerDialog(context),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _notesController,
                decoration: InputDecoration(
                  labelText: 'Additional Notes',
                  border: OutlineInputBorder(),
                ),
                maxLines: 2,
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: Icon(Icons.attach_file),
                      label: Text('Add Media'),
                      onPressed: _pickFiles,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: CheckboxListTile(
                      title: Text('Enable Feedback Form'),
                      value: _hasFeedbackForm,
                      onChanged: (value) {
                        setState(() => _hasFeedbackForm = value!);
                      },
                    ),
                  ),
                ],
              ),
              if (_mediaUrls.isNotEmpty) ...[
                SizedBox(height: 8),
                Text('Media:', style: TextStyle(fontSize: 16)),
                Wrap(
                  spacing: 8,
                  children: _mediaUrls.map((file) {
                    return Chip(
                      label: Text(file),
                      onDeleted: () {
                        setState(() => _mediaUrls.remove(file));
                      },
                    );
                  }).toList(),
                ),
              ],
              SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: Icon(LucideIcons.calendar),
                  label: Text('Schedule Event'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: _submitEvent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDateTime(BuildContext context, bool isStart) async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: isStart ? _startDateTime : _endDateTime,
      firstDate: isStart ? DateTime.now() : _startDateTime,
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (date != null) {
      final TimeOfDay? time = await showTimePicker(
        context: context,
        initialTime:
            TimeOfDay.fromDateTime(isStart ? _startDateTime : _endDateTime),
      );
      if (time != null) {
        setState(() {
          if (isStart) {
            _startDateTime = DateTime(
              date.year,
              date.month,
              date.day,
              time.hour,
              time.minute,
            );
            if (_endDateTime.isBefore(_startDateTime)) {
              _endDateTime = _startDateTime.add(Duration(hours: 2));
            }
          } else {
            _endDateTime = DateTime(
              date.year,
              date.month,
              date.day,
              time.hour,
              time.minute,
            );
          }
        });
      }
    }
  }

  Future<void> _selectRSVPDeadline(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _rsvpDeadline ?? _startDateTime,
      firstDate: DateTime.now(),
      lastDate: _startDateTime,
    );
    if (picked != null) {
      setState(() => _rsvpDeadline = picked);
    }
  }

  Future<void> _pickFiles() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.any,
      );
      if (result != null) {
        setState(() {
          _mediaUrls.addAll(result.files.map((file) => file.name));
        });
      }
    } catch (e) {
      print('Error picking files: $e');
    }
  }

  void _showAddOrganizerDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add Organizer'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _organizerNameController,
              decoration: InputDecoration(
                labelText: 'Name*',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _organizerRoleController,
              decoration: InputDecoration(
                labelText: 'Role*',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _organizerContactController,
              decoration: InputDecoration(
                labelText: 'Contact Info',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (_organizerNameController.text.isNotEmpty &&
                  _organizerRoleController.text.isNotEmpty) {
                setState(() {
                  _organizers.add(Organizer(
                    id: const Uuid().v4(),
                    name: _organizerNameController.text,
                    role: _organizerRoleController.text,
                    contactInfo: _organizerContactController.text.isEmpty
                        ? null
                        : _organizerContactController.text,
                  ));
                });
                _organizerNameController.clear();
                _organizerRoleController.clear();
                _organizerContactController.clear();
                Navigator.pop(context);
              }
            },
            child: Text('Add'),
          ),
        ],
      ),
    );
  }

  void _submitEvent() {
    if (_formKey.currentState?.validate() ?? false) {
      if (_selectedAudience.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please select at least one target audience')),
        );
        return;
      }

      if (_organizers.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please add at least one organizer')),
        );
        return;
      }

      final event = Event(
        id: const Uuid().v4(),
        title: _titleController.text,
        description: _descriptionController.text,
        startDateTime: _startDateTime,
        endDateTime: _endDateTime,
        location: _locationController.text,
        capacityLimit: int.tryParse(_capacityController.text),
        rsvpDeadline: _rsvpDeadline,
        organizers: _organizers,
        sponsors: _sponsors,
        targetAudience: _selectedAudience.toList(),
        additionalNotes:
            _notesController.text.isEmpty ? null : _notesController.text,
        type: _eventType,
        recurrence: _recurrence,
        mediaUrls: _mediaUrls,
        hasFeedbackForm: _hasFeedbackForm,
        createdAt: DateTime.now(),
        createdBy: 'current_user_id', // Replace with actual user ID
      );

      widget.onAdd(event);
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    _notesController.dispose();
    _capacityController.dispose();
    _organizerNameController.dispose();
    _organizerRoleController.dispose();
    _organizerContactController.dispose();
    super.dispose();
  }
}
