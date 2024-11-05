import 'package:flutter/material.dart';
import 'package:localnexus/models/alert.dart';
import 'package:localnexus/models/announcement.dart';
import 'package:localnexus/models/event.dart';
import 'package:localnexus/screens/add_announcement_screen.dart';
import 'package:localnexus/screens/create_alert_screen.dart';
import 'package:localnexus/screens/schedule_event_screen.dart';
import 'package:localnexus/widgets/recent_alerts.dart';

class HyperlocalCommunityDashboard extends StatefulWidget {
  @override
  _HyperlocalCommunityDashboardState createState() =>
      _HyperlocalCommunityDashboardState();
}

class _HyperlocalCommunityDashboardState
    extends State<HyperlocalCommunityDashboard> {
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
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('Hyperlocal Community'),
        backgroundColor: Colors.blueGrey[800],
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: Colors.blueGrey[600],
              child: Icon(Icons.person, color: Colors.white),
            ),
          ),
        ],
      ),
      drawer: _buildDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildQuickActions(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildRecentAlerts(),
                    _buildContentSection('Latest Announcements', announcements,
                        Colors.yellow[100] ?? Colors.yellow),
                    _buildContentSection('Upcoming Events', events,
                        Colors.blue[100] ?? Colors.blue),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActions() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
      ),
    );
  }

  Widget _buildQuickActionButton(
      IconData icon, String label, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: Colors.blueGrey[800],
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white),
          SizedBox(height: 8),
          Text(label, style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }

  Widget _buildContentSection(String title, List<dynamic> items, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 24),
        Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.blueGrey[800],
          ),
        ),
        SizedBox(height: 8),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: items.length,
          itemBuilder: (context, index) {
            return Card(
              color: color,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 2,
              child: ListTile(
                title: Text(items[index].title,
                    style: TextStyle(color: Colors.blueGrey[800])),
                subtitle: Text(
                  items[index].description ?? 'No description available',
                  style: TextStyle(color: Colors.blueGrey[600]),
                ),
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
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: child,
        );
      },
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Text(
                'Hyperlocal Community',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey[800],
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.blueGrey[100],
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(16)),
              ),
            ),
            _buildDrawerItem(Icons.dashboard, 'Dashboard'),
            _buildDrawerItem(Icons.message, 'Messages'),
            _buildDrawerItem(Icons.event, 'Events'),
            _buildDrawerItem(Icons.group, 'Members'),
            _buildDrawerItem(Icons.security, 'Safety'),
            _buildDrawerItem(Icons.settings, 'Settings'),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: Colors.blueGrey[800]),
      title: Text(title, style: TextStyle(color: Colors.blueGrey[800])),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }

  Widget _buildRecentAlerts() {
    return RecentAlerts();
  }
}
