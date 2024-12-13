import 'package:flutter/material.dart';
import 'package:localnexus/models/announcement.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:file_picker/file_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

class AddAnnouncementScreen extends StatefulWidget {
  final Function(Announcement) onAdd;

  AddAnnouncementScreen({required this.onAdd});

  @override
  _AddAnnouncementScreenState createState() => _AddAnnouncementScreenState();
}

class _AddAnnouncementScreenState extends State<AddAnnouncementScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _linkLabelController = TextEditingController();
  final _linkUrlController = TextEditingController();

  DateTime _startDate = DateTime.now();
  DateTime _expiryDate = DateTime.now().add(Duration(days: 7));
  AnnouncementPriority _priority = AnnouncementPriority.normal;
  List<String> _attachments = [];
  Set<String> _selectedTags = {};
  Set<String> _selectedAudience = {};
  Map<String, String> _actionableLinks = {};

  final List<String> _availableTags = [
    'Maintenance',
    'Safety',
    'Events',
    'Community',
    'Important',
    'Notice'
  ];

  final List<String> _availableAudiences = [
    'All Residents',
    'Property Owners',
    'Tenants',
    'Staff',
    'Vendors'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Announcement'),
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
                  labelText: 'Title*',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Title is required' : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description*',
                  border: OutlineInputBorder(),
                ),
                maxLines: 5,
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Description is required' : null,
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ListTile(
                      title: Text('Start Date'),
                      subtitle:
                          Text(DateFormat('MMM dd, yyyy').format(_startDate)),
                      trailing: Icon(Icons.calendar_today),
                      onTap: () => _selectDate(context, true),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: Text('Expiry Date'),
                      subtitle:
                          Text(DateFormat('MMM dd, yyyy').format(_expiryDate)),
                      trailing: Icon(Icons.calendar_today),
                      onTap: () => _selectDate(context, false),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text('Priority Level', style: TextStyle(fontSize: 16)),
              Row(
                children: [
                  Radio<AnnouncementPriority>(
                    value: AnnouncementPriority.normal,
                    groupValue: _priority,
                    onChanged: (value) {
                      setState(() => _priority = value!);
                    },
                  ),
                  Text('Normal'),
                  Radio<AnnouncementPriority>(
                    value: AnnouncementPriority.urgent,
                    groupValue: _priority,
                    onChanged: (value) {
                      setState(() => _priority = value!);
                    },
                  ),
                  Text('Urgent'),
                ],
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
              Text('Tags', style: TextStyle(fontSize: 16)),
              Wrap(
                spacing: 8,
                children: _availableTags.map((tag) {
                  return FilterChip(
                    label: Text(tag),
                    selected: _selectedTags.contains(tag),
                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
                          _selectedTags.add(tag);
                        } else {
                          _selectedTags.remove(tag);
                        }
                      });
                    },
                  );
                }).toList(),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: Icon(Icons.attach_file),
                      label: Text('Add Attachments'),
                      onPressed: _pickFiles,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: Icon(Icons.link),
                      label: Text('Add Link'),
                      onPressed: () => _showAddLinkDialog(context),
                    ),
                  ),
                ],
              ),
              if (_attachments.isNotEmpty) ...[
                SizedBox(height: 8),
                Text('Attachments:', style: TextStyle(fontSize: 16)),
                Wrap(
                  spacing: 8,
                  children: _attachments.map((file) {
                    return Chip(
                      label: Text(file),
                      onDeleted: () {
                        setState(() => _attachments.remove(file));
                      },
                    );
                  }).toList(),
                ),
              ],
              if (_actionableLinks.isNotEmpty) ...[
                SizedBox(height: 8),
                Text('Links:', style: TextStyle(fontSize: 16)),
                Wrap(
                  spacing: 8,
                  children: _actionableLinks.entries.map((entry) {
                    return Chip(
                      label: Text(entry.key),
                      onDeleted: () {
                        setState(() => _actionableLinks.remove(entry.key));
                      },
                    );
                  }).toList(),
                ),
              ],
              SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: Icon(LucideIcons.megaphone),
                  label: Text('Publish Announcement'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: _submitAnnouncement,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStartDate ? _startDate : _expiryDate,
      firstDate: isStartDate ? DateTime.now() : _startDate,
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (picked != null) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
          if (_expiryDate.isBefore(_startDate)) {
            _expiryDate = _startDate.add(Duration(days: 1));
          }
        } else {
          _expiryDate = picked;
        }
      });
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
          _attachments.addAll(result.files.map((file) => file.name));
        });
      }
    } catch (e) {
      print('Error picking files: $e');
    }
  }

  void _showAddLinkDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add Link'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _linkLabelController,
              decoration: InputDecoration(
                labelText: 'Link Label',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _linkUrlController,
              decoration: InputDecoration(
                labelText: 'URL',
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
              if (_linkLabelController.text.isNotEmpty &&
                  _linkUrlController.text.isNotEmpty) {
                setState(() {
                  _actionableLinks[_linkLabelController.text] =
                      _linkUrlController.text;
                });
                _linkLabelController.clear();
                _linkUrlController.clear();
                Navigator.pop(context);
              }
            },
            child: Text('Add'),
          ),
        ],
      ),
    );
  }

  void _submitAnnouncement() {
    if (_formKey.currentState?.validate() ?? false) {
      if (_selectedAudience.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please select at least one target audience')),
        );
        return;
      }

      final announcement = Announcement(
        id: const Uuid().v4(),
        title: _titleController.text,
        description: _descriptionController.text,
        targetAudience: _selectedAudience.toList(),
        startDate: _startDate,
        expiryDate: _expiryDate,
        priority: _priority,
        attachments: _attachments,
        tags: _selectedTags.toList(),
        actionableLinks: _actionableLinks,
        createdAt: DateTime.now(),
        createdBy: 'current_user_id', // Replace with actual user ID
      );

      widget.onAdd(announcement);
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _linkLabelController.dispose();
    _linkUrlController.dispose();
    super.dispose();
  }
}
