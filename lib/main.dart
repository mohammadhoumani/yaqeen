import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:yaqeen/pages/home.dart';
import 'package:yaqeen/pages/news.dart'; 
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:url_launcher/url_launcher.dart'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Handle notification when the app is opened from a terminated state
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging.instance
      .getInitialMessage()
      .then((RemoteMessage? message) async {
    if (message != null) {
      // Check if notification contains an externalLink and open it in the browser
      if (message.data.containsKey('externalLink')) {
        String url = message.data['externalLink'];
        await launchUrl(Uri.parse(url));
      } else if (message.data['route'] == '/news') {
        runApp(const MyApp(startRoute: '/news'));
      } else {
        runApp(const MyApp());
      }
    } else {
      runApp(const MyApp());
    }
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  final String? startRoute;

  const MyApp({super.key, this.startRoute});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      initialRoute: startRoute ?? '/',
      routes: {
        '/': (context) => const Home(),
        '/news': (context) => const News(), // Add your News page route
      },
    );
  }
}

// Background message handler
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling background message: ${message.messageId}");
}
