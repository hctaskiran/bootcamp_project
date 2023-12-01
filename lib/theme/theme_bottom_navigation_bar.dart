import 'package:flutter/material.dart';

class CustomBNBTheme extends BottomNavigationBarThemeData {
  const CustomBNBTheme({Key? key})
      : super(
          selectedIconTheme: const IconThemeData(size: 30),
          unselectedIconTheme: const IconThemeData(size: 24),
          unselectedItemColor: Colors.white,
          selectedItemColor: Colors.white,
          showUnselectedLabels: false,
          backgroundColor: Colors.blue,
          type: BottomNavigationBarType.fixed,
        );
}
