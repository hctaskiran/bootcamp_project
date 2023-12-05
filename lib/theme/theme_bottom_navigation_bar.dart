import 'package:flutter/material.dart';

class CustomBNBTheme extends BottomNavigationBarThemeData {
  const CustomBNBTheme({Key? key})
      : super(
          selectedIconTheme: const IconThemeData(size: 30),
          unselectedIconTheme: const IconThemeData(size: 24),
          unselectedItemColor: Colors.white,
          selectedItemColor: Colors.green,
          // selectedItemColor: const Color.fromARGB(255, 190, 26, 26),
          showUnselectedLabels: false,
          backgroundColor: const Color.fromARGB(255, 244, 206, 219),
          type: BottomNavigationBarType.fixed,
        );
}

class CustomBABTheme extends BottomAppBarTheme {
  const CustomBABTheme({Key? key}) : super(shape: const CircularNotchedRectangle(), surfaceTintColor: Colors.green);
}
