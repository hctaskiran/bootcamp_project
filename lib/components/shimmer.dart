import 'package:bootcamp_project/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoad extends StatelessWidget {
  const ShimmerLoad({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: CColor.gry300,
      highlightColor: CColor.gry100,
      child: ListView.builder(
        itemCount: 8,
        itemBuilder: (context, index) {
          return ListTile(
            leading: SizedBox(
              width: 128,
              height: 64,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Shimmer.fromColors(
                  baseColor: CColor.gry300,
                  highlightColor: CColor.gry100,
                  child: Container(color: CColor.white),
                ),
              ),
            ),
            title: Shimmer.fromColors(
              baseColor: CColor.gry300,
              highlightColor: CColor.gry100,
              child: Container(height: 16, color: CColor.white),
            ),
            subtitle: Shimmer.fromColors(
              baseColor: CColor.gry300,
              highlightColor: CColor.gry100,
              child: Container(height: 16, color: CColor.white),
            ),
          );
        },
      ),
    );
  }
}
