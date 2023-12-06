import 'package:flutter/material.dart';

class PlaceDetails extends StatelessWidget {
  const PlaceDetails({super.key});

  @override
  Widget build(BuildContext context) {
    // double screenHeight = MediaQuery.of(context).size.height;
    // double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: const Text('Details')),
      extendBodyBehindAppBar: true,
    );
  }
}
