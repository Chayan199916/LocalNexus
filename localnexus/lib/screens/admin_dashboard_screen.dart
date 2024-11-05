import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Community Dashboard'),
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () {},
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
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: screenWidth < 600
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.spaceBetween,
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
            Row(
              mainAxisAlignment: screenWidth < 600
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ActionButton(
                    icon: LucideIcons.bell,
                    label: 'New Alert',
                    badgeValue: 2,
                    badgeColor: Colors.red,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ActionButton(
                    icon: LucideIcons.megaphone,
                    label: 'New Announcement',
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ActionButton(
                    icon: LucideIcons.calendar,
                    label: 'New Event',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: DefaultTabController(
                length: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TabBar(
                      tabs: [
                        Tab(text: 'Recent Alerts'),
                        Tab(text: 'Latest Announcements'),
                        Tab(text: 'Upcoming Events'),
                      ],
                    ),
                    Expanded(
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
            ),
          ],
        ),
      ),
    );
  }
}
