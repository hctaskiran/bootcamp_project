import 'dart:io';

import 'package:flutter/material.dart';

class ChoosePP extends StatelessWidget {
  final File? image;

  const ChoosePP({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey, // Change to your preferred color
      ),
      child: image != null
          ? ClipOval(
              child: Image.file(
                image!,
                width: 150,
                height: 150,
                fit: BoxFit.cover,
              ),
            )
          : const Icon(
              Icons.camera_alt,
              color: Colors.white,
            ),
    );
  }
}
