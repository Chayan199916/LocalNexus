import 'package:flutter/material.dart';
import 'package:localnexus/models/alert.dart';
import 'package:localnexus/models/announcement.dart';
import 'package:localnexus/models/event.dart';
import 'add_announcement_screen.dart';
import 'create_alert_screen.dart';
import 'schedule_event_screen.dart';
import 'announcements_list_screen.dart';
import 'alerts_list_screen.dart';
import 'events_list_screen.dart';

class AdminDashboardScreen extends StatefulWidget {
  @override
  _AdminDashboardScreenState createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  List<Announcement> announcements = [];
  List<Alert> alerts = [];
  List<Event> events = [];

  void _addAnnouncement(Announcement announcement) {
    setState(() {
      announcements.add(announcement);
    });
  }

  void _addAlert(Alert alert) {
    setState(() {
      alerts.add(alert);
    });
  }

  void _addEvent(Event event) {
    setState(() {
      events.add(event);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Overview',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                _buildOverviewCard('Safety Alerts', alerts.length.toString(),
                    Icons.notifications),
                _buildOverviewCard('Announcements',
                    announcements.length.toString(), Icons.announcement),
                _buildOverviewCard('Scheduled Events', events.length.toString(),
                    Icons.calendar_today),
              ],
            ),
            SizedBox(height: 24),
            Text(
              'Quick Actions',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Wrap(
              spacing: 16,
              children: [
                _buildActionButton('Create Announcement', Icons.announcement,
                    () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddAnnouncementScreen(
                        onAdd: _addAnnouncement,
                      ),
                    ),
                  );
                }),
                _buildActionButton('Create Alert', Icons.notifications, () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateAlertScreen(
                        onAdd: _addAlert,
                      ),
                    ),
                  );
                }),
                _buildActionButton('Schedule Event', Icons.calendar_today, () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ScheduleEventScreen(
                        onAdd: _addEvent,
                      ),
                    ),
                  );
                }),
              ],
            ),
            SizedBox(height: 24),
            Text(
              'View Lists',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Wrap(
              spacing: 16,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AnnouncementsListScreen(
                            announcements: announcements),
                      ),
                    );
                  },
                  child: Text('View Announcements'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AlertsListScreen(alerts: alerts),
                      ),
                    );
                  },
                  child: Text('View Alerts'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EventsListScreen(events: events),
                      ),
                    );
                  },
                  child: Text('View Events'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOverviewCard(String title, String count, IconData icon) {
    return Card(
      elevation: 4,
      child: Container(
        width: 100,
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.blueAccent),
            SizedBox(height: 8),
            Text(title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            Text(count,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(
      String title, IconData icon, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 20),
          SizedBox(width: 8),
          Text(title),
        ],
      ),
      style: ElevatedButton.styleFrom(
        primary: Colors.white,
        onPrimary: Colors.blueAccent,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: Colors.blueAccent),
        ),
      ),
    );
  }
}
