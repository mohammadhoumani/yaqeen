import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:yaqeen/model/awareness.dart';

class AwarenessService {
  final String apiUrl = 'https://yaqeen.onrender.com/api/awar';

  Future<List<Awareness>> fetchAwareness() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = json.decode(response.body);

      List<dynamic> awarenessList = jsonData['data'];

      return awarenessList.map((json) => Awareness.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load awareness data');
    }
  }
}
