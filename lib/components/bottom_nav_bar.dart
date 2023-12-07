// ignore_for_file: prefer_const_constructors

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:bootcamp_project/components/choose_language.dart';
import 'package:bootcamp_project/components/drawer.dart';
import 'package:bootcamp_project/components/main_fab.dart';
import 'package:bootcamp_project/constants/bnb_pages.dart';
import 'package:bootcamp_project/init/lang/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class NavBarController extends StatefulWidget {
  const NavBarController({Key? key}) : super(key: key);

  @override
  State<NavBarController> createState() => _NavBarControllerState();
}

class _NavBarControllerState extends State<NavBarController> {
  int _selectedIndex = 0;

  final List _icons = [
    Icon(Icons.fastfood_outlined),
    Icon(Icons.coffee_outlined),
    Icon(Icons.store_outlined),
    Icon(Icons.bedtime_outlined)
  ];

  final List _active = [Icon(Icons.fastfood), Icon(Icons.coffee), Icon(Icons.store), Icon(Icons.bedtime)];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: NavigationPages.pages.elementAt(_selectedIndex),
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: _selectedIndex == 0
            ? _animatedTitle(LocaleKeys.placeTypes_food.tr())
            : _selectedIndex == 1
                ? _animatedTitle(LocaleKeys.placeTypes_cafe.tr())
                : _selectedIndex == 2
                    ? _animatedTitle(LocaleKeys.placeTypes_store.tr())
                    : _animatedTitle(LocaleKeys.placeTypes_hotel.tr()),
        actions: [ChooseLanguage(context: context)],
      ),
      floatingActionButton: MainFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 14,
        unselectedFontSize: 10,
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: [
          BottomNavigationBarItem(
            icon: _icons[0],
            activeIcon: _active[0],
            label: LocaleKeys.placeTypes_food.tr(),
          ),
          BottomNavigationBarItem(
            icon: _icons[1],
            activeIcon: _active[1],
            label: LocaleKeys.placeTypes_cafe.tr(),
          ),
          BottomNavigationBarItem(
            icon: _icons[2],
            activeIcon: _active[2],
            label: LocaleKeys.placeTypes_store.tr(),
          ),
          BottomNavigationBarItem(
            icon: _icons[3],
            activeIcon: _active[3],
            label: LocaleKeys.placeTypes_hotel.tr(),
          ),
        ],
      ),
    );
  }

  AnimatedTextKit _animatedTitle(String text) {
    return AnimatedTextKit(
      repeatForever: true,
      pause: const Duration(seconds: 1),
      animatedTexts: [
        FadeAnimatedText(text, duration: const Duration(seconds: 5)),
      ],
    );
  }
}
