import 'package:bootcamp_project/product/map.dart';
import 'package:flutter/material.dart';

class MainFAB extends StatelessWidget {
  const MainFAB({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: 60,
          left: 170,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const MapSample()));
            },
            child: const Icon(Icons.map_outlined),
          ),
        ),
      ],
    );
  }
}
