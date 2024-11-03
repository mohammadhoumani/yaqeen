import 'package:flutter/material.dart';
import 'package:yaqeen/components/menu.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const CustomAppBar({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false, // Hide the back button
      backgroundColor: const Color(0xFF4F6A42),
      title: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween, // Space between title and menu
        children: [
          const MenuPopup(), // Action (menu) aligned to the left
          Directionality(
            textDirection: TextDirection.rtl, // Right-to-left text alignment
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontFamily: "ReadexPro",
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
