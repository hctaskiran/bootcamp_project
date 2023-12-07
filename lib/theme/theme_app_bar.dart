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
            backgroundColor: CColor.abBg,
            iconTheme: IconThemeData(color: CColor.black),
            centerTitle: true,
            titleTextStyle: TextStyle(color: CColor.black, fontSize: 20));
}
