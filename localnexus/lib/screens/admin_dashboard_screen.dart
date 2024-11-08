import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:localnexus/screens/smart_messages_screen.dart';
import 'package:localnexus/widgets/announcements_tab.dart';
import 'package:localnexus/widgets/events_tab.dart';
import 'package:localnexus/widgets/overview_card.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:localnexus/widgets/action_button.dart';
import 'package:localnexus/widgets/alerts_tab.dart';

final refreshingProvider = StateProvider<bool>((ref) => false);

class CommunityDashboard extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final refreshing = ref.watch(refreshingProvider);
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Community Dashboard'),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              // Open the drawer
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              LucideIcons.refreshCcw,
              color: refreshing ? Colors.blue : null,
            ),
            onPressed: () {
              ref.read(refreshingProvider.notifier).state = true;
              Future.delayed(const Duration(seconds: 1), () {
                ref.read(refreshingProvider.notifier).state = false;
              });
            },
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.person),
            onSelected: (value) {
              // Handle menu selection
              switch (value) {
                case 'Profile':
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()),
                  );
                  break;
                case 'Settings':
                  // Navigate to settings screen
                  break;
                case 'Log out':
                  // Handle log out
                  break;
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem<String>(
                  value: 'Profile',
                  child: Text('Profile'),
                ),
                const PopupMenuItem<String>(
                  value: 'Settings',
                  child: Text('Settings'),
                ),
                const PopupMenuItem<String>(
                  value: 'Log out',
                  child: Text('Log out'),
                ),
              ];
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: Icon(LucideIcons.home),
              title: const Text('Dashboard'),
              onTap: () {
                // Navigate to the Dashboard screen
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              leading: Icon(LucideIcons.messageSquare),
              title: const Text('Messages'),
              onTap: () {
                // Navigate to the Messages screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          SmartMessagesScreen()), // Navigate to Smart Messages
                );
              },
            ),
            ListTile(
              leading: Icon(LucideIcons.calendar),
              title: const Text('Events'),
              onTap: () {
                // Navigate to the Events screen
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              leading: Icon(LucideIcons.users),
              title: const Text('Members'),
              onTap: () {
                // Navigate to the Members screen
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              leading: Icon(LucideIcons.shield),
              title: const Text('Safety'),
              onTap: () {
                // Navigate to the Safety screen
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              leading: Icon(LucideIcons.settings),
              title: const Text('Settings'),
              onTap: () {
                // Navigate to the Settings screen
                Navigator.pop(context); // Close the drawer
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Overview Section with Responsive Layout
            isSmallScreen
                ? Column(
                    children: [
                      OverviewCard(
                        title: 'Alerts',
                        icon: LucideIcons.bell,
                        value: 2,
                        color: Colors.red,
                      ),
                      const SizedBox(height: 16),
                      OverviewCard(
                        title: 'Announcements',
                        icon: LucideIcons.megaphone,
                        value: 5,
                        color: Colors.blue,
                      ),
                      const SizedBox(height: 16),
                      OverviewCard(
                        title: 'Events',
                        icon: LucideIcons.calendar,
                        value: 3,
                        color: Colors.green,
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: OverviewCard(
                          title: 'Alerts',
                          icon: LucideIcons.bell,
                          value: 2,
                          color: Colors.red,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: OverviewCard(
                          title: 'Announcements',
                          icon: LucideIcons.megaphone,
                          value: 5,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: OverviewCard(
                          title: 'Events',
                          icon: LucideIcons.calendar,
                          value: 3,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
            const SizedBox(height: 16),
            // Action Buttons Section with Responsive Layout
            isSmallScreen
                ? Column(
                    children: [
                      ActionButton(
                        icon: LucideIcons.bell,
                        label: 'New Alert',
                        badgeValue: 0,
                        badgeColor: Colors.transparent,
                        fullWidth: true,
                      ),
                      const SizedBox(height: 16),
                      ActionButton(
                        icon: LucideIcons.megaphone,
                        label: 'New Announcement',
                        badgeValue: 0,
                        badgeColor: Colors.transparent,
                        fullWidth: true,
                      ),
                      const SizedBox(height: 16),
                      ActionButton(
                        icon: LucideIcons.calendar,
                        label: 'New Event',
                        badgeValue: 0,
                        badgeColor: Colors.transparent,
                        fullWidth: true,
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: ActionButton(
                          icon: LucideIcons.bell,
                          label: 'New Alert',
                          badgeValue: 0,
                          badgeColor: Colors.transparent,
                          fullWidth: true,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ActionButton(
                          icon: LucideIcons.megaphone,
                          label: 'New Announcement',
                          badgeValue: 0,
                          badgeColor: Colors.transparent,
                          fullWidth: true,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ActionButton(
                          icon: LucideIcons.calendar,
                          label: 'New Event',
                          badgeValue: 0,
                          badgeColor: Colors.transparent,
                          fullWidth: true,
                        ),
                      ),
                    ],
                  ),
            const SizedBox(height: 16),
            // Tab View for Content Sections
            DefaultTabController(
              length: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TabBar(
                    isScrollable: isSmallScreen, // Allow scrolling for tabs
                    tabs: [
                      Tab(text: 'Recent Alerts'),
                      Tab(text: 'Latest Announcements'),
                      Tab(text: 'Upcoming Events'),
                    ],
                  ),
                  Container(
                    height: isSmallScreen
                        ? 300
                        : 400, // Adjust height based on screen size
                    child: TabBarView(
                      children: [
                        AlertsTab(),
                        AnnouncementsTab(),
                        EventsTab(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Placeholder for ProfileScreen
class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Center(
        child: Text('Profile content goes here'),
      ),
    );
  }
}
