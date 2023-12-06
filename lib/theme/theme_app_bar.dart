import 'package:bootcamp_project/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomAppBarTheme extends AppBarTheme {
  CustomAppBarTheme({Key? key})
      : super(
            backgroundColor: CColor.abBg,
            iconTheme: IconThemeData(color: CColor.black),
            centerTitle: true,
            titleTextStyle: TextStyle(color: CColor.black, fontSize: 20));
}
