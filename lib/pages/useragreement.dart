import 'package:flutter/material.dart';
import 'package:yaqeen/components/appbar.dart';

class UserAgreement extends StatelessWidget {
  const UserAgreement({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xfffffBDA), // Light background color
      appBar: CustomAppBar(title: 'اتفاقية المستخدم'),
      body: SingleChildScrollView(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'يرجى قراءة هذه الاتفاقية بعناية قبل استخدام تطبيق "يقين". باستخدام هذا التطبيق، فإنك توافق على الالتزام بالشروط والأحكام التالية:',
                  style: TextStyle(
                    fontFamily: 'ReadexPro', // Apply the custom font
                    fontSize: 16.0,
                    height: 1.5,
                    color: Color(0xFF4F6A42), // Dark green text color
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  'الاستخدام:',
                  style: TextStyle(
                    fontFamily: 'ReadexPro', // Apply the custom font
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4F6A42), // Dark green for headings
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  'يمنحك تطبيق "يقين" حق الوصول إلى المحتوى المقدم فقط لأغراض شخصية وغير تجارية. لا يجوز لك استخدام المحتوى بأي طريقة مخالفة للقوانين أو هذه الاتفاقية.',
                  style: TextStyle(
                    fontFamily: 'ReadexPro', // Apply the custom font
                    fontSize: 16.0,
                    height: 1.5,
                    color: Color(0xFF4F6A42), // Dark green text color
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  'حقوق الملكية الفكرية:',
                  style: TextStyle(
                    fontFamily: 'ReadexPro', // Apply the custom font
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4F6A42), // Dark green for headings
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  'جميع الحقوق المتعلقة بالتطبيق والمحتوى المقدم عليه تعود لتطبيق "يقين". لا يجوز لك نسخ أو توزيع أو تعديل أي جزء من المحتوى دون إذن خطي مسبق.',
                  style: TextStyle(
                    fontFamily: 'ReadexPro', // Apply the custom font
                    fontSize: 16.0,
                    height: 1.5,
                    color: Color(0xFF4F6A42), // Dark green text color
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  'تعديل الاتفاقية:',
                  style: TextStyle(
                    fontFamily: 'ReadexPro', // Apply the custom font
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4F6A42), // Dark green for headings
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  'يحتفظ تطبيق "يقين" بالحق في تعديل هذه الشروط في أي وقت. سيتم إعلامك بأي تغييرات، ويعد استمرارك في استخدام التطبيق بمثابة موافقة على الشروط المعدلة.',
                  style: TextStyle(
                    fontFamily: 'ReadexPro', // Apply the custom font
                    fontSize: 16.0,
                    height: 1.5,
                    color: Color(0xFF4F6A42), // Dark green text color
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  'إذا كانت لديك أي أسئلة حول هذه الاتفاقية، يمكنك التواصل معنا عبر صفحة "تواصل معنا".',
                  style: TextStyle(
                    fontFamily: 'ReadexPro', // Apply the custom font
                    fontSize: 16.0,
                    height: 1.5,
                    color: Color(0xFF4F6A42), // Dark green text color
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  'شكراً لاستخدامك تطبيق "يقين".',
                  style: TextStyle(
                    fontFamily: 'ReadexPro', // Apply the custom font
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
