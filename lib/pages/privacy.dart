import 'package:flutter/material.dart';
import 'package:yaqeen/components/appbar.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xfffffBDA), // Light background color
      appBar: CustomAppBar(title: 'سياسة الخصوصية'),
      body: SingleChildScrollView(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'نحن في تطبيق "يقين" ملتزمون بحماية خصوصيتك وضمان سريّة معلوماتك الشخصية. فيما يلي شرح لكيفية جمعنا واستخدامنا لمعلوماتك:',
                  style: TextStyle(
                    fontFamily: 'ReadexPro', // Apply the ReadexPro font
                    fontSize: 16.0,
                    height: 1.5,
                    color: Color(0xFF4F6A42), // Dark green text color
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  'المعلومات التي نجمعها:',
                  style: TextStyle(
                    fontFamily: 'ReadexPro', // Apply the ReadexPro font
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4F6A42), // Dark green for headings
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  'نحن لا نقوم بجمع أي معلومات شخصية منك سوى ما تقوم بتوفيره عند التواصل معنا عبر "تواصل معنا".',
                  style: TextStyle(
                    fontFamily: 'ReadexPro', // Apply the ReadexPro font
                    fontSize: 16.0,
                    height: 1.5,
                    color: Color(0xFF4F6A42), // Dark green text color
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  'كيفية استخدام المعلومات:',
                  style: TextStyle(
                    fontFamily: 'ReadexPro', // Apply the ReadexPro font
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4F6A42), // Dark green for headings
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  'نستخدم المعلومات التي تقدمها فقط لتقديم الدعم والإجابة على استفساراتك.',
                  style: TextStyle(
                    fontFamily: 'ReadexPro', // Apply the ReadexPro font
                    fontSize: 16.0,
                    height: 1.5,
                    color: Color(0xFF4F6A42), // Dark green text color
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  'حماية المعلومات:',
                  style: TextStyle(
                    fontFamily: 'ReadexPro', // Apply the ReadexPro font
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4F6A42), // Dark green for headings
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  'نحن نتخذ جميع الإجراءات اللازمة لحماية معلوماتك من الوصول غير المصرح به أو الإفصاح عنها.',
                  style: TextStyle(
                    fontFamily: 'ReadexPro', // Apply the ReadexPro font
                    fontSize: 16.0,
                    height: 1.5,
                    color: Color(0xFF4F6A42), // Dark green text color
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  'إذا كانت لديك أي أسئلة حول سياسة الخصوصية هذه، يمكنك التواصل معنا عبر صفحة "تواصل معنا".',
                  style: TextStyle(
                    fontFamily: 'ReadexPro', // Apply the ReadexPro font
                    fontSize: 16.0,
                    height: 1.5,
                    color: Color(0xFF4F6A42), // Dark green text color
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  'شكراً لثقتك في تطبيق "يقين".',
                  style: TextStyle(
                    fontFamily: 'ReadexPro', // Apply the ReadexPro font
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFFD90E), // Highlighted yellow text
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
