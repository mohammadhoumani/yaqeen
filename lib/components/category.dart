import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard(this.icon, this.text, this.onTap, {super.key});

  final String text;
  final Icon icon;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.all(10),
        elevation: 5,
        child: ListTile(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          leading: icon,
          trailing: const Icon(Icons.arrow_forward_ios,
              color: Color(0xFFFFD90E)), // Arrow icon on the right
          title: Text(
            text,
            style: const TextStyle(
                fontFamily: "ReadexPro", fontWeight: FontWeight.bold),
          ),
          tileColor: const Color(0xFF4F6A42),
          textColor: const Color(0xfffffBDA),
          iconColor: const Color(0xFFFFD90E),
        ),
      ),
    );
  }
}
