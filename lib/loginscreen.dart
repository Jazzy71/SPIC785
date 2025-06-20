import 'package:carnest/signup.dart';
import 'package:carnest/url.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'home.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool obscureText = true;
  bool isLoading = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Replace with your actual backend URL
  String baseUrl = "${Url.Urls}"; // Change this to your backend URL

  Future<void> _login() async {
    // Validate inputs
    if (emailController.text.trim().isEmpty || passwordController.text.trim().isEmpty) {
      _showErrorDialog('Please enter both email and password');
      return;
    }

    // Validate email format
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(emailController.text.trim())) {
      _showErrorDialog('Please enter a valid email address');
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'email': emailController.text.trim(),
          'password': passwordController.text,
        }),
      );

      final responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        // Login successful - submit email to recent emails
        await _submitEmailToRecent(emailController.text.trim());

        // Navigate to HomeScreen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(
              userName: _extractUserName(emailController.text),
            ),
          ),
        );
      } else if (response.statusCode == 401) {
        // Invalid credentials
        _showErrorDialog(responseData['message'] ?? 'Invalid email or password');
      } else if (response.statusCode == 400) {
        // Missing fields
        _showErrorDialog(responseData['message'] ?? 'Please fill in all fields');
      } else {
        // Other errors
        _showErrorDialog('Login failed. Please try again.');
      }
    } catch (e) {
      // Network or parsing error
      _showErrorDialog('Network error. Please check your connection and try again.');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

// New method to submit email to recent emails
  Future<void> _submitEmailToRecent(String email) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/submit-email'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'email': email,
        }),
      );

      // Optional: You can handle the response if needed
      if (response.statusCode == 201) {
        print('Email submitted to recent list successfully');
      } else {
        print('Failed to submit email to recent list: ${response.statusCode}');
      }
    } catch (e) {
      // Don't show error to user for this secondary operation
      print('Error submitting email to recent list: $e');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Login Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 48.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top spacing
                SizedBox(height: 40),

                // Header section
                Text(
                    'Hello!',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    )
                ),
                SizedBox(height: 8),
                Text(
                    'Welcome back',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white60,
                      fontWeight: FontWeight.w300,
                    )
                ),

                // Large spacing after header
                SizedBox(height: 60),

                // Email section
                Text(
                    'Email',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    )
                ),
                SizedBox(height: 12),
                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  enabled: !isLoading,
                  decoration: InputDecoration(
                    hintText: 'Enter your email',
                    hintStyle: TextStyle(color: Colors.grey.shade500),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: Colors.orangeAccent, width: 2),
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                  ),
                ),

                // Spacing between fields
                SizedBox(height: 28),

                // Password section
                Text(
                    'Password',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    )
                ),
                SizedBox(height: 12),
                TextField(
                  controller: passwordController,
                  obscureText: obscureText,
                  enabled: !isLoading,
                  decoration: InputDecoration(
                    hintText: 'Enter your password',
                    hintStyle: TextStyle(color: Colors.grey.shade500),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: Colors.orangeAccent, width: 2),
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                    suffixIcon: IconButton(
                      icon: Icon(
                        obscureText ? Icons.visibility_off : Icons.visibility,
                        color: Colors.grey.shade600,
                      ),
                      onPressed: () {
                        setState(() => obscureText = !obscureText);
                      },
                    ),
                  ),
                ),

                // Forgot password link
                SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '',
                    style: TextStyle(
                      color: Colors.orangeAccent,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                // Large spacing before button
                SizedBox(height: 48),

                // Login button with API integration
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : _login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orangeAccent,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      disabledBackgroundColor: Colors.grey.shade600,
                    ),
                    child: isLoading
                        ? SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                        : Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),

                // Spacing before register link
                SizedBox(height: 32),

                // Register link
                Center(
                  child: GestureDetector(
                    onTap: isLoading ? null : () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpScreen()),
                      );
                    },
                    child: RichText(
                      text: TextSpan(
                        text: 'Don\'t have an account? ',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                        children: [
                          TextSpan(
                            text: 'Sign up',
                            style: TextStyle(
                              color: isLoading ? Colors.grey : Colors.orangeAccent,
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline,
                              decorationColor: isLoading ? Colors.grey : Colors.orangeAccent,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),

                // Bottom spacing
                SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper function to extract user name from email
  String _extractUserName(String email) {
    if (email.isEmpty) return 'User';
    String name = email.split('@').first;
    return name.isEmpty ? 'User' : name[0].toUpperCase() + name.substring(1);
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}