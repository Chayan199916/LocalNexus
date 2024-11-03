import 'package:flutter/material.dart';
import 'admin_dashboard_screen.dart'; // Import the Admin Dashboard screen

class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blueAccent,
        elevation: 0, // Remove shadow for a flatter look
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0), // Increased padding
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email or Phone',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12), // Rounded corners
                ),
                filled: true,
                fillColor: Colors.white, // White background for text field
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12), // Rounded corners
                ),
                filled: true,
                fillColor: Colors.white, // White background for text field
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Handle login logic here
                String email = _emailController.text;
                String password = _passwordController.text;
                // For now, just print the values and navigate to the dashboard
                print('Email: $email, Password: $password');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AdminDashboardScreen()),
                );
              },
              child: Text('Login'),
              style: ElevatedButton.styleFrom(
                primary: Colors.blueAccent,
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12), // Rounded corners
                ),
                elevation: 0, // Flat button style
              ),
            ),
          ],
        ),
      ),
    );
  }
}
