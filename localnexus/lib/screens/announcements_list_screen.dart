import 'package:flutter/material.dart';
import 'package:localnexus/models/announcement.dart';

class AnnouncementsListScreen extends StatelessWidget {
  final List<Announcement> announcements;

  AnnouncementsListScreen({required this.announcements});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Announcements'),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView.builder(
        itemCount: announcements.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(announcements[index].title),
              subtitle: Text(announcements[index].description),
            ),
          );
        },
      ),
    );
  }
}
