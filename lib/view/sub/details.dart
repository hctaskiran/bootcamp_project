import 'package:bootcamp_project/model/place_models.dart';
import 'package:flutter/material.dart';

class PlaceDetails extends StatefulWidget {
  const PlaceDetails({super.key});

  @override
  State<PlaceDetails> createState() => _PlaceDetailsState();
}

class _PlaceDetailsState extends State<PlaceDetails> {
  @override
  Widget build(BuildContext context) {
    // double screenHeight = MediaQuery.of(context).size.height;
    // double screenWidth = MediaQuery.of(context).size.width;
    List<PlaceElement> nearbyPlaces = [];

    return Scaffold(
        // appBar: AppBar(title: const Text('Details')),
        body: ListView.builder(
            itemCount: nearbyPlaces.length,
            itemBuilder: (context, index) {
              return const Column(
                children: [],
              );
            }));
  }
}
