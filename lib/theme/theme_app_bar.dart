import 'package:bootcamp_project/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomAppBarTheme extends AppBarTheme {
  CustomAppBarTheme({Key? key})
      : super(
            toolbarHeight: 50,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.elliptical(30, 30),
              ),
            ),
            elevation: 0,
            scrolledUnderElevation: 0,
            backgroundColor: CColor.tr,
            iconTheme: IconThemeData(color: CColor.black),
            centerTitle: true,
            titleTextStyle: TextStyle(color: CColor.black, fontSize: 20));
}
