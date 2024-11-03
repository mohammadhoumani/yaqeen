import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:yaqeen/model/prayer.dart';  // Adjust the import based on your file structure

class PrayerService {
  final String apiUrl = 'https://yaqeen.onrender.com/api/prayers';

  
  Future<List<Prayer>> fetchPrayers() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      
      Map<String, dynamic> jsonData = json.decode(response.body);

      
      List<dynamic> prayerList = jsonData['data'];

 
      return prayerList.map((json) => Prayer.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load prayer times');
    }
  }
}
