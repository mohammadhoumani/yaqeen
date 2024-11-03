import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:yaqeen/components/appbar.dart';
import 'package:yaqeen/pages/contactus.dart';
import 'package:yaqeen/pages/privacy.dart';
import 'package:yaqeen/pages/useragreement.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  SettingsState createState() => SettingsState();
}

class SettingsState extends State<Settings> {
  bool isNotificationsEnabled = true;

  @override
  void initState() {
    super.initState();
    _loadNotificationSettings();
  }

  // Load the current notification setting from SharedPreferences
  Future<void> _loadNotificationSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isNotificationsEnabled = prefs.getBool('notificationsEnabled') ?? true;
    });
  }

  // Update notification status
  Future<void> _updateNotificationStatus(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notificationsEnabled', value);

    // Call the method to send the notification status to the server
    await _sendNotificationStatusToServer(value);
  }

  // Send notification status to the server
  Future<void> _sendNotificationStatusToServer(bool isActive) async {
    final url = Uri.parse('https://yaqeen.onrender.com/api/token');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('fcmToken'); // Fetch FCM token

    if (token == null || token.isEmpty) {
      print('No token found. Fetching a new token.');
      // Fetch and send token if it's not available
      token = await _getFCMToken();
      if (token == null) {
        print('Could not retrieve a token to send the notification status.');
        return; // Exit if token retrieval fails
      }
    }

    try {
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'token': token,
          'isActive': isActive,
        }),
      );

      if (response.statusCode == 200) {
        print('Notification status updated successfully');
      } else {
        print('Failed to update notification status: ${response.body}');
      }
    } catch (error) {
      print('Error occurred: $error');
    }
  }

  // Fetch FCM Token (ensure it's stored)
  Future<String?> _getFCMToken() async {
    // Assume you have the messaging instance available here
    String? token = await FirebaseMessaging.instance.getToken();
    if (token != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('fcmToken', token); // Store the token
      print("Fetched token: $token");
    }
    return token;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'الإعدادات'),
      body: Directionality(
        // Wrap the body in Directionality for RTL
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SwitchListTile(
                title: const Text('تفعيل الإشعارات',
                    style: TextStyle(
                      color: Color(0xFF4F6A42),
                      fontSize: 18,
                      fontFamily: "ReadexPro",
                    )),
                value: isNotificationsEnabled,
                onChanged: (value) {
                  setState(() {
                    isNotificationsEnabled = value;
                  });
                  _updateNotificationStatus(value); // Call the update method
                },
                activeColor: const Color(0xFFFFD90E),
                inactiveThumbColor: const Color(0xFF4F6A42),
              ),
              const SizedBox(height: 20),
              ListTile(
                title: const Text('تواصل معنا',
                    style: TextStyle(
                      color: Color(0xFF4F6A42),
                      fontSize: 18,
                      fontFamily: "ReadexPro",
                    )),
                leading: const Icon(Icons.email, color: Color(0xFF4F6A42)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ContactUs(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              ListTile(
                title: const Text('سياسة الخصوصية',
                    style: TextStyle(
                      color: Color(0xFF4F6A42),
                      fontSize: 18,
                      fontFamily: "ReadexPro",
                    )),
                leading:
                    const Icon(Icons.privacy_tip, color: Color(0xFF4F6A42)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PrivacyPolicy(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              ListTile(
                title: const Text('اتفاقية المستخدم',
                    style: TextStyle(
                      color: Color(0xFF4F6A42),
                      fontSize: 18,
                      fontFamily: "ReadexPro",
                    )),
                leading: const Icon(Icons.rule, color: Color(0xFF4F6A42)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const UserAgreement(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 100),
              Center(
                child: Text(
                  "Powered by Devmode",
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
