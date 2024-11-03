import 'package:flutter/material.dart';
import 'package:yaqeen/components/appbar.dart';
import 'package:yaqeen/components/category.dart';
import 'package:yaqeen/pages/ad3eya.dart';
import 'package:yaqeen/pages/aware.dart';
import 'package:yaqeen/pages/news.dart';
import 'package:yaqeen/pages/settings.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final double titleFontSize = screenWidth * 0.05;
    final double dividerIndent = screenWidth * 0.1;
    final double avatarRadius = screenWidth < 400 ? 100 : 150;

    return Scaffold(
      backgroundColor: const Color(0xfffffBDA),
      appBar: const CustomAppBar(title: 'الرئيسية'),
      body: SingleChildScrollView(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: screenHeight * 0.02),
                Divider(
                  color: const Color(0xFF4F6A42),
                  thickness: 2,
                  indent: dividerIndent,
                  endIndent: dividerIndent,
                ),
                Text(
                  "{وَفِي الْأَرْضِ آيَاتٌ لِّلْمُوقِنِينَ}",
                  style: TextStyle(
                    color: const Color(0xFF4F6A42),
                    fontSize: titleFontSize,
                    fontWeight: FontWeight.bold,
                    fontFamily: "ReadexPro",
                  ),
                  textAlign: TextAlign.center,
                ),
                Divider(
                  color: const Color(0xFF4F6A42),
                  thickness: 2,
                  indent: dividerIndent,
                  endIndent: dividerIndent,
                ),
                SizedBox(height: screenHeight * 0.02),
                CircleAvatar(
                  radius: avatarRadius,
                  backgroundImage: const AssetImage('assets/test1.jpg'),
                ),
                SizedBox(height: screenHeight * 0.03),
                // Using CategoryCard widgets with responsive padding
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                  child: Column(
                    children: [
                      CategoryCard(
                        const Icon(Icons.alarm),
                        "أخبار",
                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) {
                                return const News();
                              },
                            ),
                          );
                        },
                      ),
                      CategoryCard(
                        const Icon(Icons.menu_book_outlined),
                        "أدعية",
                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) {
                                return const Douaa();
                              },
                            ),
                          );
                        },
                      ),
                      CategoryCard(
                        const Icon(Icons.read_more),
                        "كُن مُلِماً بواقِعك",
                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) {
                                return const AwarenessScreen();
                              },
                            ),
                          );
                        },
                      ),
                      CategoryCard(
                        const Icon(Icons.settings),
                        "الاعدادات",
                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) {
                                return const Settings();
                              },
                            ),
                          );
                        },
                      ),
                    ],
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
