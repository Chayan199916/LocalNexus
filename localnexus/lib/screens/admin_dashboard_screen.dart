import 'package:flutter/material.dart';
import 'package:localnexus/models/alert.dart';
import 'package:localnexus/models/announcement.dart';
import 'package:localnexus/models/event.dart';
import 'add_announcement_screen.dart';
import 'create_alert_screen.dart';
import 'schedule_event_screen.dart';

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
        title: Text('Community Dashboard'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Community Dashboard',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 24),
              _buildOverviewSection(),
              SizedBox(height: 24),
              _buildQuickActions(),
              SizedBox(height: 24),
              _buildContentSection('Recent Alerts', alerts),
              _buildContentSection('Latest Announcements', announcements),
              _buildContentSection('Upcoming Events', events),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildQuickActionButton(Icons.notifications, 'Alert', () {
          _showModal(context, CreateAlertScreen(onAdd: _addAlert));
        }),
        _buildQuickActionButton(Icons.announcement, 'Announce', () {
          _showModal(context, AddAnnouncementScreen(onAdd: _addAnnouncement));
        }),
        _buildQuickActionButton(Icons.calendar_today, 'Event', () {
          _showModal(context, ScheduleEventScreen(onAdd: _addEvent));
        }),
      ],
    );
  }

  Widget _buildQuickActionButton(
      IconData icon, String label, VoidCallback onPressed) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: Colors.blueAccent),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.blueAccent),
          SizedBox(width: 8),
          Text(label, style: TextStyle(color: Colors.blueAccent)),
        ],
      ),
    );
  }

  Widget _buildOverviewSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildOverviewCard('Alerts', alerts.length.toString()),
        _buildOverviewCard('Announcements', announcements.length.toString()),
        _buildOverviewCard('Events', events.length.toString()),
      ],
    );
  }

  Widget _buildOverviewCard(String title, String count) {
    return Expanded(
      child: Card(
        elevation: 2,
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                count,
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContentSection(String title, List<dynamic> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 24),
        Text(
          title,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: items.length,
          itemBuilder: (context, index) {
            return Card(
              margin: EdgeInsets.all(8.0),
              child: ListTile(
                title: Text(items[index].title),
                subtitle: Text(
                    items[index].description ?? 'No description available'),
              ),
            );
          },
        ),
      ],
    );
  }

  void _showModal(BuildContext context, Widget child) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: child,
        );
      },
    );
  }
}
