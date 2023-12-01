import 'package:bootcamp_project/product/constants/application.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';

class RestaurantView extends StatelessWidget {
  RestaurantView({super.key});

  final _places = GoogleMapsPlaces(apiKey: Application.apiKey);

  Future<List<PlacesSearchResult>> searchPlaces(String query, LatLng location) async {
    final result = await _places.searchNearbyWithRadius(
      Location(lat: location.latitude, lng: location.longitude),
      5000,
      type: "restaurant",
      keyword: query,
    );
    if (result.status == "OK") {
      return result.results;
    } else {
      throw Exception(result.errorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            extendBody: true,
            body: FutureBuilder(
                future: Geolocator.getCurrentPosition(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.done:
                      final data = snapshot.data;
                      if (data == null) {
                        return const Text('No data');
                      }
                    default:
                      const CircularProgressIndicator();
                  }
                  return const ListTile();
                })));
  }
}
