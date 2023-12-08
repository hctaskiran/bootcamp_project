import 'package:bootcamp_project/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomBNBTheme extends BottomNavigationBarThemeData {
  CustomBNBTheme({Key? key})
      : super(
          selectedIconTheme: const IconThemeData(size: 30),
          unselectedIconTheme: const IconThemeData(size: 24),
          unselectedItemColor: CColor.black,
          selectedItemColor: CColor.black,
          showUnselectedLabels: false,
          backgroundColor: CColor.bnbBg,
          type: BottomNavigationBarType.shifting,
        );
}

class CustomBABTheme extends BottomAppBarTheme {
  const CustomBABTheme({Key? key}) : super(shape: const CircularNotchedRectangle(), surfaceTintColor: Colors.green);
}
