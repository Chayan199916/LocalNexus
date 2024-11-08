import 'package:flutter/material.dart';
import 'package:localnexus/screens/create_alert_screen.dart';
import 'package:lucide_icons/lucide_icons.dart';

class AlertsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Recent Alerts',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Emergency and important notifications',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 16),
            // Add your alert items here
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Add your alerts items here
                  ],
                ),
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (BuildContext context) {
                    return CreateAlertScreen(
                      onAdd: (alert) {
                        print('Added Alert: ${alert.title}');
                      },
                    );
                  },
                );
              },
              icon: const Icon(LucideIcons.plus, size: 20),
              label: const Text('Create Alert'),
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).colorScheme.secondary,
                onPrimary: Colors.white,
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
