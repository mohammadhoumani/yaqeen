import 'package:flutter/material.dart';
import 'package:yaqeen/pages/ad3eya.dart';
import 'package:yaqeen/pages/aware.dart';
import 'package:yaqeen/pages/home.dart';
import 'package:yaqeen/pages/news.dart';
import 'package:yaqeen/pages/settings.dart';

class MenuPopup extends StatelessWidget {
  const MenuPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(
        Icons.menu,
        color: Colors.white,
        size: 28, // Increased icon size for better visibility
      ),
      color: const Color(0xfffffBDA), // Custom background color for the menu
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(10.0), // Rounded corners for the menu
      ),
      onSelected: (value) {
        if (value == 'أخبار') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const News()),
          );
        } else if (value == 'ادعية') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Douaa()),
          );
        } else if (value == 'الاعدادت') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Settings()),
          );
        } else if (value == 'كُن مُلِماً بواقِعك') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AwarenessScreen()),
          );
        } else if (value == 'الرئيسية') {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const Home();
          }));
        }
      },
      itemBuilder: (BuildContext context) {
        return [
          _buildMenuItem(Icons.alarm, 'أخبار', Colors.red),
          _buildMenuItem(
              Icons.menu_book_sharp, 'ادعية', const Color(0xFFFFD90E)),
          _buildMenuItem(Icons.read_more, 'كُن مُلِماً بواقِعك', Colors.red),
          _buildMenuItem(Icons.settings, 'الاعدادت', Colors.blue),
          _buildMenuItem(Icons.home, 'الرئيسية', Colors.blue),
        ];
      },
    );
  }

  PopupMenuItem<String> _buildMenuItem(
      IconData icon, String text, Color iconColor) {
    return PopupMenuItem<String>(
      value: text,
      child: Directionality(
        textDirection: TextDirection.rtl, // Set direction to RTL
        child: Row(
          children: [
            Icon(icon, color: iconColor), // Icon on the left
            const SizedBox(width: 8), // Spacing between icon and text
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  text,
                  style: const TextStyle(
                    color: Color(0xFF4F6A42), // Text color
                    fontSize: 16,
                    fontFamily: "ReadexPro", // Custom font
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
