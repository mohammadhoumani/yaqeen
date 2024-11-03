import 'package:flutter/material.dart';
import 'package:yaqeen/components/appbar.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xfffffBDA), // Light background color
      appBar: CustomAppBar(title: 'تواصل معنا'),
      body: SingleChildScrollView(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'إذا كانت لديك أي استفسارات أو اقتراحات، لا تتردد في التواصل معنا عبر الوسائل التالية:',
                  style: TextStyle(
                    fontSize: 16.0,
                    height: 1.5,
                    color: Color(0xFF4F6A42),
                    fontFamily: "ReadexPro", // Custom font
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  'البريد الإلكتروني: support@yaqeenapp.com',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4F6A42),
                    fontFamily: "ReadexPro", // Custom font
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  'رقم الهاتف: +961 81717464',
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4F6A42),
                      fontFamily: "ReadexPro"),
                ),
                SizedBox(height: 20.0),
                Text(
                  'نحن هنا لمساعدتك، وسنقوم بالرد على جميع استفساراتك في أسرع وقت ممكن.',
                  style: TextStyle(
                    fontSize: 16.0,
                    height: 1.5,
                    color: Color(0xFF4F6A42),
                    fontFamily: "ReadexPro",
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  'شكراً لتواصلكم معنا!',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFFD90E),
                    fontFamily: "ReadexPro",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
