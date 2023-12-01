import 'package:bootcamp_project/product/constants/bnb_pages.dart';
import 'package:bootcamp_project/product/widgets/drawer/drawer.dart';
import 'package:flutter/material.dart';

class NavBarController extends StatefulWidget {
  const NavBarController({Key? key}) : super(key: key);

  @override
  State<NavBarController> createState() => _NavBarControllerState();
}

class _NavBarControllerState extends State<NavBarController> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _selectedIndex == 0
            ? const Text('Restaurants')
            : _selectedIndex == 1
                ? const Text('Cinema')
                : const Text('Cafe'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: NavigationPages.pages.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 18,
        unselectedFontSize: 10,
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.restaurant_rounded), label: "Restaurants"),
          BottomNavigationBarItem(icon: Icon(Icons.local_movies_outlined), label: 'Cinema'),
          BottomNavigationBarItem(icon: Icon(Icons.local_cafe_rounded), label: "Cafe"),
        ],
      ),
    );
  }
}
