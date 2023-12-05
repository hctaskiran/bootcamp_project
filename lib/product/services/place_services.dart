import 'dart:convert';

import 'package:bootcamp_project/product/feature/constants/application.dart';
import 'package:http/http.dart' as http;

class PlacesService {
  String p = 'places';

  PlacesService();
  Future<dynamic> searchNearbyPlaces(double lat, double long, String searchType) async {
    const url = 'https://places.googleapis.com/v1/places:searchNearby';
    // searchText

    final headers = {
      'Content-Type': 'application/json',
      'X-Goog-Api-Key': Application.apiKey,
      'X-Goog-FieldMask':
          '$p.rating,$p.photos,$p.displayName,$p.formattedAddress,$p.types,$p.location,$p.id,$p.nationalPhoneNumber,$p.businessStatus',
    };

    final body = jsonEncode({
      'includedTypes': [searchType],
      'maxResultCount': 0,
      'locationRestriction': {
        'circle': {
          'center': {'latitude': lat, 'longitude': long},
          'radius': 500.0,
        },
      },
    });

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
