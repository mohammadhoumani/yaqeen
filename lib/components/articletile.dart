 import 'package:flutter/material.dart';
import 'package:yaqeen/model/newsmodel.dart';

Widget buildArticleTile(Article article) {

  const Color tileColor = Color(0xFF4F6A42);

    return ListTile(
      tileColor: tileColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      title: Align(
        alignment: Alignment.centerRight,
        child: Text(article.title, style: const TextStyle(color: Color(0xFFFFD90E), fontSize: 16)),
      ),
      subtitle: Align(
        alignment: Alignment.centerRight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const SizedBox(height: 8),
            Text(article.content, style: const TextStyle(color: Color(0xfffffBDA), fontSize: 14)),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(Icons.date_range, color: Color(0xFFFFD90E)),
                const SizedBox(width: 8),
                Text(article.getFormattedDate(), style: const TextStyle(color: Colors.white, fontSize: 10)),
                const SizedBox(width: 16),
                const Icon(Icons.source, color: Color(0xFFFFD90E)),
                const SizedBox(width: 8),
                Text(article.source, style: const TextStyle(color: Colors.white, fontSize: 10)),
              ],
            ),
          ],
        ),
      ),
    );
  }

