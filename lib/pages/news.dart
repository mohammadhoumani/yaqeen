import 'dart:convert';
import 'dart:io'; // Import for platform check
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:permission_handler/permission_handler.dart'; // Import the permission_handler
import 'package:yaqeen/components/appbar.dart';
import 'package:yaqeen/model/newsmodel.dart';
import 'package:yaqeen/service/apiservice.dart';

class News extends StatefulWidget {
  const News({super.key});

  @override
  NewsState createState() => NewsState();
}

class NewsState extends State<News> {
  late Future<List<Article>> futureArticles;
  late FirebaseMessaging messaging;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  bool isNotificationsEnabled = true;

  @override
  void initState() {
    super.initState();

    // Initialize the local notifications plugin
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = const DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings);

    // Firebase messaging setup
    messaging = FirebaseMessaging.instance;

    // Request notification permission
    _requestNotificationPermission();

    futureArticles = ApiService().fetchArticles();

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessage.listen(_handleMessage);

    _loadNotificationSettings(); // Load the notification setting
    _checkAndSendToken();
  }

  Future<void> _requestNotificationPermission() async {
    if (Platform.isIOS) {
      // iOS-specific permission request
      NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );
      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        print("iOS Notification permission granted");
      } else if (settings.authorizationStatus == AuthorizationStatus.denied) {
        print("iOS Notification permission denied");
        _showPermissionDeniedDialog(); // Handle denied permission
      }
    } else {
      // Android-specific permission request
      var status = await Permission.notification.request();
      if (status.isGranted) {
        print("Android Notification permission granted");
      } else if (status.isDenied || status.isPermanentlyDenied) {
        print("Android Notification permission denied");
        _showPermissionDeniedDialog(); // Handle denied permission
      }
    }
  }

  // Show dialog to redirect user to app settings if permission is denied
  void _showPermissionDeniedDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF4F6A42),
        title: const Text("Notification Permission"),
        content: const Text(
          "Notification permission is required for important updates. Please enable it in your phone's settings.",
          style: TextStyle(color: Color(0xfffffBDA)),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              openAppSettings(); // Redirect to app settings
            },
            child: const Text("Open Settings"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancel"),
          ),
        ],
      ),
    );
  }

  Future<void> _refreshArticles() async {
    setState(() {
      futureArticles = ApiService().fetchArticles();
    });
  }

  // Load notification settings from SharedPreferences
  Future<void> _loadNotificationSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isNotificationsEnabled = prefs.getBool('notificationsEnabled') ?? true;
    });
  }

  // Handling foreground messages
  void _handleMessage(RemoteMessage message) {
    if (message.notification != null) {
      _showCustomNotification(message.notification!);
    }
  }

  static Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    print("Handling background message: ${message.messageId}");
  }

  // Display custom notification
  void _showCustomNotification(RemoteNotification notification) async {
    var androidDetails = const AndroidNotificationDetails(
      'YaQeen', // Channel ID
      'YaQeen News', // Channel name
      importance: Importance.high,
      priority: Priority.high,
      color: Color(0xFFFFD90E), // Custom color for notification
      icon: '@mipmap/ic_launcher', // Custom icon
      enableVibration: true,
      playSound: true,
    );

    var iosDetails = const DarwinNotificationDetails(); // iOS notification settings
    var notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await flutterLocalNotificationsPlugin.show(
      0, // Notification ID
      notification.title,
      notification.body,
      notificationDetails,
    );
  }

  // Get FCM Token
  Future<String?> _getFCMToken() async {
    return await messaging.getToken().then((value) {
      print("Token: $value");
      return value;
    });
  }

  // Check if token is sent and send it if necessary (only if notifications are enabled)
  Future<void> _checkAndSendToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isTokenSent = prefs.getBool('tokenSent') ?? false;

    print('Token sent: $isTokenSent');

    if (isNotificationsEnabled) {
      String? token = await _getFCMToken();
      await _sendTokenToServer(token!);
      await prefs.setBool('tokenSent', true);
    } else {
      print('Notifications are disabled, no token will be sent.');
    }
  }

  // Send token to the server
  Future<void> _sendTokenToServer(String token) async {
    final url = Uri.parse('https://yaqeen.onrender.com/api/token');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'token': token}),
      ); 
      print('Response: ${response.body}');

      if (response.statusCode == 201) {
        print('Token created successfully');
      } else {
        print('Failed to create token: ${response.statusCode} ${response.reasonPhrase}');
      }
    } catch (error) {
      print('Error occurred while sending token: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfffffBDA),
      appBar: const CustomAppBar(title: 'الخبر اليقين'),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: RefreshIndicator(
          color: const Color(0xFFFFD90E),
          backgroundColor: const Color(0xFF4F6A42),
          onRefresh: _refreshArticles,
          child: FutureBuilder<List<Article>>(
            future: futureArticles,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFFD90E)),
                  ),
                );
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text(
                    'Check your internet connection',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: "ReadexPro",
                    ),
                  ),
                );
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No Articles Found'));
              } else {
                final articles = snapshot.data!;
                return ListView.builder(
                  itemCount: articles.length,
                  itemBuilder: (context, index) {
                    final article = articles[index];
                    return GestureDetector(
                      onTap: () {
                        print("Tapped on $index");
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 6.0,
                        ),
                        child: ListTile(
                          tileColor: const Color(0xFF4F6A42),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          title: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              article.title,
                              style: const TextStyle(
                                color: Color(0xFFFFD90E),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: "ReadexPro",
                              ),
                            ),
                          ),
                          subtitle: Align(
                            alignment: Alignment.centerRight,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const SizedBox(height: 8),
                                Text(
                                  article.content,
                                  style: const TextStyle(
                                    color: Color(0xfffffBDA),
                                    fontSize: 14,
                                    fontFamily: "ReadexPro",
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Icon(Icons.date_range, color: Color(0xFFFFD90E)),
                                    const SizedBox(width: 8),
                                    Text(
                                      article.getFormattedDate(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontFamily: "ReadexPro",
                                        fontSize: 10,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    const Icon(Icons.source, color: Color(0xFFFFD90E)),
                                    const SizedBox(width: 8),
                                    Text(
                                      article.source,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontFamily: "ReadexPro",
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
