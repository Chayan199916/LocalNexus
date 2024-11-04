import 'package:flutter/material.dart';
import 'admin_dashboard_screen.dart'; // Import the Admin Dashboard screen

class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F6F3), // Soft neutral background
      appBar: AppBar(
        title: Text('Log in',
            style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold)), // Clean typography
        backgroundColor: Colors.transparent, // Transparent app bar
        elevation: 0,
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 5,
                blurRadius: 15,
                offset: Offset(0, 5), // changes position of shadow
              ),
              BoxShadow(
                color: Colors.white,
                spreadRadius: 5,
                blurRadius: 15,
                offset: Offset(-5, -5), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Welcome back! Please enter your details.',
                  style: TextStyle(color: Colors.black54, fontSize: 16)),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Email',
                      style: TextStyle(color: Colors.black)), // Label for email
                  TextButton(
                    onPressed: () {
                      // Logic for using phone instead
                    },
                    child: Text('Use phone instead',
                        style: TextStyle(color: Colors.blue)), // Link for phone
                  ),
                ],
              ),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: 'Enter your email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                        color: Colors.grey[300]!), // Lighter border color
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                style: TextStyle(color: Colors.black), // Text color
              ),
              SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                        color: Colors.grey[300]!), // Lighter border color
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  suffixIcon: IconButton(
                    icon: Icon(
                        Icons.visibility), // Eye icon for password visibility
                    onPressed: () {
                      // Toggle password visibility logic
                    },
                  ),
                ),
                style: TextStyle(color: Colors.black), // Text color
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Checkbox(
                    value: false, // Change this to a state variable if needed
                    onChanged: (bool? value) {
                      // Handle checkbox state change
                    },
                  ),
                  Text('Remember me',
                      style:
                          TextStyle(color: Colors.black)), // Remember me text
                  Spacer(),
                  TextButton(
                    onPressed: () {
                      // Handle forgot password
                    },
                    child: Text("Forgot password?",
                        style: TextStyle(
                            color: Colors.blue)), // Forgot password link
                  ),
                ],
              ),
              SizedBox(height: 16),
              SizedBox(
                width: double.infinity, // Make button full width
                child: ElevatedButton(
                  onPressed: () {
                    String email = _emailController.text;
                    String password = _passwordController.text;
                    print('Email: $email, Password: $password');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AdminDashboardScreen()),
                    );
                  },
                  child: Text('Log in',
                      style: TextStyle(fontSize: 16)), // Clean typography
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, // Button color
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account? ",
                      style: TextStyle(color: Colors.black)),
                  TextButton(
                    onPressed: () {
                      // Navigate to sign up
                    },
                    child:
                        Text("Sign up", style: TextStyle(color: Colors.blue)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
