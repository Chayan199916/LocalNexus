import 'package:flutter/material.dart';
import 'package:localnexus/screens/group_chat_screen.dart';

class SmartMessagesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Rest of the code remains exactly the same
    final TextStyle headlineStyle = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w500,
    );

    final TextStyle bodyStyle = TextStyle(
      fontSize: 16,
    );

    final TextStyle subtitleStyle = TextStyle(
      fontSize: 14,
      color: Colors.grey[600],
    );

    final TextStyle sectionHeaderStyle = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
    );

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Smart Messages',
          style: headlineStyle,
        ),
        centerTitle: true,
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
            ),
          ),
        ],
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text('John Doe', style: bodyStyle),
              accountEmail: Text('john@example.com', style: subtitleStyle),
              currentAccountPicture: CircleAvatar(
                child: Text('JD'),
              ),
            ),
            // Personal Settings Section
            ListTile(
              title: Text('Personal Settings', style: bodyStyle),
              onTap: () {},
            ),
            ListTile(
              title: Text('Profile Management', style: bodyStyle),
              onTap: () {},
            ),
            ListTile(
              title: Text('UI Preferences', style: bodyStyle),
              onTap: () {},
            ),
            ListTile(
              title: Text('Notification Settings', style: bodyStyle),
              onTap: () {},
            ),
            const Divider(),

            // Message Organization Section
            ListTile(
              title: Text('Message Organization', style: bodyStyle),
              onTap: () {},
            ),
            ListTile(
              title: Text('Custom Filters', style: bodyStyle),
              onTap: () {},
            ),
            ListTile(
              title: Text('View Preferences', style: bodyStyle),
              onTap: () {},
            ),
            ListTile(
              title: Text('Label Management', style: bodyStyle),
              onTap: () {},
            ),
            ListTile(
              title: Text('Importance Criteria', style: bodyStyle),
              onTap: () {},
            ),
            const Divider(),

            // Summary Settings Section
            ListTile(
              title: Text('Summary Settings', style: bodyStyle),
              onTap: () {},
            ),
            ListTile(
              title: Text('Frequency Controls', style: bodyStyle),
              onTap: () {},
            ),
            ListTile(
              title: Text('Format Preferences', style: bodyStyle),
              onTap: () {},
            ),
            ListTile(
              title: Text('Retention Rules', style: bodyStyle),
              onTap: () {},
            ),
            ListTile(
              title: Text('Topic Management', style: bodyStyle),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              style: bodyStyle,
              decoration: InputDecoration(
                hintText: 'Search messages and summaries...',
                hintStyle: subtitleStyle,
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(),
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber),
                      const SizedBox(width: 8),
                      Text('Important', style: sectionHeaderStyle),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Card(
                    elevation: 2,
                    child: ListTile(
                      title: Text('Team meeting summary for Project X',
                          style: bodyStyle),
                      subtitle: Text('2 hours ago • 5 responses',
                          style: subtitleStyle),
                      onTap: () {},
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Icon(Icons.book, color: Colors.blue),
                      const SizedBox(width: 8),
                      Text('Recent Summaries', style: sectionHeaderStyle),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Card(
                    elevation: 2,
                    child: ListTile(
                      title: Text('Daily Summary - Marketing Discussion',
                          style: bodyStyle),
                      subtitle: Text(
                          'Key points: Campaign metrics, Q4 planning',
                          style: subtitleStyle),
                      trailing: const Icon(Icons.arrow_forward),
                      onTap: () {},
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Icon(Icons.chat, color: Colors.green),
                      const SizedBox(width: 8),
                      Text('Active Chats', style: sectionHeaderStyle),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Card(
                    elevation: 2,
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text('MP'),
                      ),
                      title: Text('Marketing Project', style: bodyStyle),
                      subtitle: Text('Latest: Discussion about Q4 campaign',
                          style: subtitleStyle),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('12m ago', style: subtitleStyle),
                          const SizedBox(height: 4),
                          CircleAvatar(
                            radius: 12,
                            backgroundColor: Colors.blue,
                            child: Text(
                              '3',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                      onTap: () {},
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chats',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Summaries',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Important',
          ),
        ],
        currentIndex: 1,
        onTap: (index) {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => GroupChatScreen()),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
