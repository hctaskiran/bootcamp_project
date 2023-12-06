import 'dart:convert';

import 'package:bootcamp_project/constants/application.dart';
import 'package:http/http.dart' as http;

class SearchService {
  String p = 'places';

  SearchService();
  Future<dynamic> searchText(String text) async {
    const url = 'https://places.googleapis.com/v1/places:searchText';
    // searchText

    final headers = {
      'Content-Type': 'application/json',
      'X-Goog-Api-Key': Application.apiKey,
      'X-Goog-FieldMask':
          '$p.rating,$p.photos,$p.displayName,$p.formattedAddress,$p.types,$p.location,$p.id,$p.nationalPhoneNumber,$p.businessStatus',
    };
    final body = {
      'textQuery': text,
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        // debugPrint('Response: ${response.body}');
        Map<String, dynamic> data = jsonDecode(response.body);
        return data;
      }
    } catch (e) {
      // Handle exceptions
      print('Exception: $e');
    }
  }
}
