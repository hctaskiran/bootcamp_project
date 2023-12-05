import 'dart:convert';

import 'package:bootcamp_project/product/feature/constants/application.dart';
import 'package:http/http.dart' as http;

class PlacesService {
  String place = 'places';

  PlacesService();
  Future<dynamic> searchNearbyPlaces(double lat, double long, String searchType) async {
    final apiKey = Application.apiKey;

    const url = 'https://places.googleapis.com/v1/places:searchNearby';

    final headers = {
      'Content-Type': 'application/json',
      'X-Goog-Api-Key': apiKey,
      'X-Goog-FieldMask':
          '$place.rating,$place.photos,$place.displayName,$place.formattedAddress,$place.types,$place.location,$place.id,$place.nationalPhoneNumber,$place.businessStatus',
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
        Map<String, dynamic> data = jsonDecode(response.body);
        return data;
      } else {
        print('Error: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      print('Exception: $e');
    }
  }
}
