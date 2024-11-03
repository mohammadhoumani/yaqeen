import 'package:flutter/material.dart';
import 'package:yaqeen/model/prayer.dart'; // Adjust the import path accordingly
import 'package:yaqeen/pages/douapage.dart';
import 'package:yaqeen/service/prayerservice.dart'; // Adjust the import path accordingly
import 'package:yaqeen/components/appbar.dart'; // Assuming you have a custom AppBar widget like in News

class Douaa extends StatefulWidget {
  const Douaa({super.key});

  @override
  State<Douaa> createState() => _DouaaState();
}

class _DouaaState extends State<Douaa> {
  late Future<List<Prayer>> _futurePrayers;

  @override
  void initState() {
    super.initState();
    // Fetch the prayers when the page is initialized
    _futurePrayers = PrayerService().fetchPrayers();
  }

  // Refresh functionality
  Future<void> _refreshPrayers() async {
    setState(() {
      _futurePrayers = PrayerService().fetchPrayers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfffffBDA), // Matching background color
      appBar: const CustomAppBar(
          title: 'ادْعُونِي أَسْتَجِبْ لَكُمْ'), // Custom AppBar like News page
      body: Directionality(
        textDirection: TextDirection.rtl, // Right-to-left alignment
        child: RefreshIndicator(
          color: const Color(
              0xFFFFD90E), // Match News page refresh indicator color
          backgroundColor:
              const Color(0xFF4F6A42), // Background color for refresh indicator
          onRefresh: _refreshPrayers, // Refresh functionality
          child: FutureBuilder<List<Prayer>>(
            future: _futurePrayers,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Color(0xFFFFD90E)))); // Spinner with custom color
              } else if (snapshot.hasError) {
                return const Center(child: Text('Check your internet connection',
                    style:  TextStyle(
                        color: Color(0xFFFFD90E), // Error text color
                        fontSize: 16,
                        fontFamily: "ReadexPro"))); // Font consistency
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No prayers available.'));
              } else {
                List<Prayer> prayers = snapshot.data!;
                return ListView.builder(
                  itemCount: prayers.length,
                  itemBuilder: (context, index) {
                    Prayer prayer = prayers[index];
                    return GestureDetector(
                      onTap: () {
                        // Navigate to PrayerDetailPage on tap
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                PrayerDetailPage(prayer: prayer),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 6.0,
                        ),
                        child: ListTile(
                          tileColor:
                              const Color(0xFF4F6A42), // Matching tile color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          title: Align(
                            alignment: Alignment.centerRight,
                            child: Row(
                              children: [
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    prayer.title,
                                    style: const TextStyle(
                                        color: Color(0xFFFFD90E), // Title color
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        fontFamily:
                                            "ReadexPro"), // Same font as News page
                                  ),
                                ),
                              ],
                            ),
                          ),
                          subtitle: Align(
                            alignment: Alignment.centerRight,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.person, // Icon for speaker
                                      color: Color(0xFFFFD90E),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        prayer.speaker, // Display speaker
                                        style: const TextStyle(
                                            color: Color(
                                                0xfffffBDA), // Subtitle color
                                            fontSize: 10,
                                            fontFamily:
                                                "ReadexPro"), // Font consistency
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                              ],
                            ),
                          ),
                          trailing: const Icon(
                            Icons.arrow_forward_ios, // Arrow icon
                            color: Color(0xFFFFD90E),
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
