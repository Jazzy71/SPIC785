import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'home.dart';
import 'url.dart'; // Add this import for your Url class

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool obscurePassword = true;
  bool obscureConfirm = true;
  bool isLoading = false;

  // Text controllers for form fields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  // Use the base URL from your Url class - NO /signup here
  final String baseUrl = Url.Urls; // This should be just 'http://192.168.69.210:5000'

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    mobileController.dispose();
    locationController.dispose();
    super.dispose();
  }

  Future<void> signUp() async {
    // Validate form fields
    if (nameController.text.trim().isEmpty ||
        emailController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty ||
        confirmPasswordController.text.trim().isEmpty ||
        mobileController.text.trim().isEmpty ||
        locationController.text.trim().isEmpty) {
      _showErrorDialog('All fields are required');
      return;
    }

    if (passwordController.text != confirmPasswordController.text) {
      _showErrorDialog('Passwords do not match');
      return;
    }

    // Email validation
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(emailController.text)) {
      _showErrorDialog('Please enter a valid email address');
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final url = '$baseUrl/signup';
      print('Making request to: $url'); // Debug log

      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'name': nameController.text.trim(),
          'email': emailController.text.trim(),
          'password': passwordController.text,
          'mobilenumber': mobileController.text.trim(),
          'location': locationController.text.trim(),
        }),
      );

      print('Response status: ${response.statusCode}'); // Debug log
      print('Response body: ${response.body}'); // Debug log

      if (response.statusCode == 201) {
        // Successful registration - submit email to recent emails
        await _submitEmailToRecent(emailController.text.trim());

        // Show success dialog
        final responseData = json.decode(response.body);
        _showSuccessDialog(responseData['message']);
      } else {
        // Handle errors
        final responseData = json.decode(response.body);
        String errorMessage = responseData['message'] ?? responseData['error'] ?? 'Registration failed';
        _showErrorDialog(errorMessage);
      }
    } catch (e) {
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
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success'),
          content: Text(message),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                // Navigate to home screen or login screen
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(userName: nameController.text),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with back button
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: IconButton(
                        icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    SizedBox(width: 16),
                    Text(
                        'Hello!',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 0.5,
                        )
                    ),
                  ],
                ),
                SizedBox(height: 12),
                RichText(
                  text: TextSpan(
                    text: 'Create an ',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white60,
                      fontWeight: FontWeight.w300,
                    ),
                    children: [
                      TextSpan(
                        text: 'account',
                        style: TextStyle(
                          color: Colors.orangeAccent,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 40),

                // Name field
                _buildLabelField('Name'),
                _buildCustomInputField('Enter your name', controller: nameController),

                // Email field
                _buildLabelField('Email Address'),
                _buildCustomInputField('Enter your email',
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress),

                // Password field
                _buildLabelField('Password'),
                _buildCustomInputField(
                  'Enter your password',
                  controller: passwordController,
                  isPassword: true,
                  obscureText: obscurePassword,
                  toggleVisibility: () => setState(() => obscurePassword = !obscurePassword),
                ),

                // Confirm Password field
                _buildLabelField('Confirm Password'),
                _buildCustomInputField(
                  'Re-enter your password',
                  controller: confirmPasswordController,
                  isPassword: true,
                  obscureText: obscureConfirm,
                  toggleVisibility: () => setState(() => obscureConfirm = !obscureConfirm),
                ),

                // Mobile Number field
                _buildLabelField('Mobile Number'),
                _buildCustomInputField('Enter your mobile number',
                    controller: mobileController,
                    keyboardType: TextInputType.phone),

                // Location field
                _buildLabelField('Location'),
                _buildCustomInputField('Enter your location', controller: locationController),

                SizedBox(height: 40),

                // Sign Up Button
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : signUp,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orangeAccent,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
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
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 24),

                // Already have an account
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: RichText(
                      text: TextSpan(
                        text: 'Already have an account? ',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                        children: [
                          TextSpan(
                            text: 'Login',
                            style: TextStyle(
                              color: Colors.orangeAccent,
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.orangeAccent,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabelField(String label) {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0, bottom: 12),
      child: Text(
        label,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildCustomInputField(
      String hint, {
        TextEditingController? controller,
        bool isPassword = false,
        bool obscureText = false,
        VoidCallback? toggleVisibility,
        TextInputType? keyboardType,
      }) {
    return TextField(
      controller: controller,
      obscureText: isPassword ? obscureText : false,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hint,
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
        suffixIcon: isPassword
            ? IconButton(
          icon: Icon(
            obscureText ? Icons.visibility_off : Icons.visibility,
            color: Colors.grey.shade600,
          ),
          onPressed: toggleVisibility,
        )
            : null,
      ),
    );
  }
}