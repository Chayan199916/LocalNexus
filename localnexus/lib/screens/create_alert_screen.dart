import 'package:flutter/material.dart';
import 'package:localnexus/models/alert.dart';
import 'package:file_picker/file_picker.dart';
import 'package:lucide_icons/lucide_icons.dart';

class CreateAlertScreen extends StatefulWidget {
  final Function(Alert) onAdd;

  CreateAlertScreen({required this.onAdd});

  @override
  _CreateAlertScreenState createState() => _CreateAlertScreenState();
}

class _CreateAlertScreenState extends State<CreateAlertScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _actionPlanController = TextEditingController();
  final _geofenceController = TextEditingController();

  AlertSeverity _severity = AlertSeverity.low;
  AlertSource _source = AlertSource.admin;
  DateTime _expiryDate = DateTime.now().add(Duration(days: 1));
  List<String> _attachments = [];
  Set<String> _selectedAudience = {};

  final List<String> _availableAudiences = [
    'Admins',
    'Moderators',
    'Residents',
    'Vendors',
    'All'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Alert'),
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
                  labelText: 'Alert Title*',
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
                maxLines: 3,
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Description is required' : null,
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<AlertSeverity>(
                value: _severity,
                decoration: InputDecoration(
                  labelText: 'Severity Level*',
                  border: OutlineInputBorder(),
                ),
                items: AlertSeverity.values.map((severity) {
                  return DropdownMenuItem(
                    value: severity,
                    child:
                        Text(severity.toString().split('.').last.toUpperCase()),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() => _severity = value!);
                },
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
              TextFormField(
                controller: _geofenceController,
                decoration: InputDecoration(
                  labelText: 'Geofence Range (meters)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _actionPlanController,
                decoration: InputDecoration(
                  labelText: 'Action Plan',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              SizedBox(height: 16),
              ListTile(
                title: Text('Expiry Date & Time'),
                subtitle: Text(_expiryDate.toString()),
                trailing: Icon(Icons.calendar_today),
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: _expiryDate,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(Duration(days: 365)),
                  );
                  if (date != null) {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.fromDateTime(_expiryDate),
                    );
                    if (time != null) {
                      setState(() {
                        _expiryDate = DateTime(
                          date.year,
                          date.month,
                          date.day,
                          time.hour,
                          time.minute,
                        );
                      });
                    }
                  }
                },
              ),
              SizedBox(height: 16),
              ElevatedButton.icon(
                icon: Icon(Icons.attach_file),
                label: Text('Add Attachments'),
                onPressed: () async {
                  final result = await FilePicker.platform.pickFiles(
                    allowMultiple: true,
                    type: FileType.any,
                  );
                  if (result != null) {
                    setState(() {
                      _attachments.addAll(
                        result.files.map((file) => file.name),
                      );
                    });
                  }
                },
              ),
              if (_attachments.isNotEmpty) ...[
                SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: _attachments.map((attachment) {
                    return Chip(
                      label: Text(attachment),
                      onDeleted: () {
                        setState(() {
                          _attachments.remove(attachment);
                        });
                      },
                    );
                  }).toList(),
                ),
              ],
              SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: Icon(LucideIcons.bell),
                  label: Text('Create Alert'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      final alert = Alert(
                        id: DateTime.now().toString(),
                        title: _titleController.text,
                        description: _descriptionController.text,
                        severity: _severity,
                        targetAudience: _selectedAudience.toList(),
                        geofenceRange:
                            double.tryParse(_geofenceController.text),
                        actionPlan: _actionPlanController.text,
                        createdAt: DateTime.now(),
                        expiresAt: _expiryDate,
                        attachments: _attachments,
                        source: _source,
                      );
                      widget.onAdd(alert);
                      Navigator.pop(context);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
