import 'package:flutter/material.dart';
import 'package:yaqeen/components/appbar.dart';
import 'package:yaqeen/model/awareness.dart';
import 'package:yaqeen/service/awarenessservice.dart';

class AwarenessScreen extends StatefulWidget {
  const AwarenessScreen({super.key});

  @override
  AwarenessScreenState createState() => AwarenessScreenState();
}

class AwarenessScreenState extends State<AwarenessScreen> {
  late Future<List<Awareness>> futureAwareness;

  @override
  void initState() {
    super.initState();
    futureAwareness = AwarenessService().fetchAwareness();
  }

  Future<void> _refreshAwareness() async {
    setState(() {
      futureAwareness = AwarenessService().fetchAwareness();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfffffBDA), // Same background color
      appBar: const CustomAppBar(title: 'كُن مُلِماً بواقِعك'), // CustomAppBar
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: RefreshIndicator(
          color: const Color(0xFFFFD90E),
          backgroundColor: const Color(0xFF4F6A42),
          onRefresh: _refreshAwareness,
          child: FutureBuilder<List<Awareness>>(
            future: futureAwareness,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Color(0xFFFFD90E))));
              } else if (snapshot.hasError) {
                return const Center(child: Text('Check your internet connection',
                    style: TextStyle(
                        color: Color(0xFFFFD90E),
                        fontSize: 16,
                        fontFamily: "ReadexPro")));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No Awareness Data Found'));
              } else {
                final awarenessList = snapshot.data!;
                return ListView.builder(
                  itemCount: awarenessList.length,
                  itemBuilder: (context, index) {
                    final awareness = awarenessList[index];
                    return GestureDetector(
                      onTap: () {
                        print("Tapped on $index");
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 6.0,
                        ),
                        child: ListTile(
                          tileColor: const Color(0xFF4F6A42),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          title: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              awareness.title,
                              style: const TextStyle(
                                  color: Color(0xFFFFD90E),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "ReadexPro"),
                            ),
                          ),
                          subtitle: Align(
                            alignment: Alignment.centerRight,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const SizedBox(height: 8),
                                Text(
                                  awareness.content,
                                  style: const TextStyle(
                                      color: Color(0xfffffBDA),
                                      fontSize: 14,
                                      fontFamily: "ReadexPro"),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Icon(Icons.date_range,
                                        color: Color(0xFFFFD90E)),
                                    const SizedBox(width: 8),
                                    Text(
                                      "${awareness.createdAt.toLocal()}"
                                          .split(' ')[0],
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontFamily: "ReadexPro",
                                          fontSize: 10),
                                    ),
                                    const SizedBox(width: 16),
                                  ],
                                ),
                              ],
                            ),
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
