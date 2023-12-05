// ignore_for_file: prefer_const_constructors

import 'package:bootcamp_project/components/drawer.dart';
import 'package:bootcamp_project/components/main_fab.dart';
import 'package:bootcamp_project/constants/bnb_pages.dart';
import 'package:bootcamp_project/enum/locale_enum.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: _selectedIndex == 0 ? Text(LocaleKeys.placeTypes_food.tr()) : Text(LocaleKeys.placeTypes_cafe.tr()),
        actions: [_languageSelect(context)],
      ),
      floatingActionButton: MainFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _botNavBar(),
      drawer: const AppDrawer(),
      body: NavigationPages.pages.elementAt(_selectedIndex),
    );
  }

  Padding _languageSelect(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: Container(
          decoration: BoxDecoration(color: Colors.pink, borderRadius: BorderRadius.circular(10)),
          child: DropdownButton(
            iconEnabledColor: Colors.white,
            iconDisabledColor: Colors.white,
            padding: EdgeInsets.all(5),
            isDense: true,
            hint: const Icon(
              Icons.language_rounded,
              color: Colors.white,
            ),
            underline: const SizedBox(),
            items: AppLanguages.Languages.asMap()
                .map((index, value) => MapEntry(
                    index,
                    DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    )))
                .values
                .toList(),
            onChanged: (newValue) {
              int selectedIndex = AppLanguages.Languages.indexOf(newValue as String);
              context.setLocale(AppLanguages.supportedLanguages[selectedIndex]);
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const NavBarController()));
            },
          )),
    );
  }

  BottomNavigationBar _botNavBar() {
    return BottomNavigationBar(
        selectedFontSize: 18,
        unselectedFontSize: 10,
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.fastfood_outlined),
              activeIcon: Icon(Icons.fastfood),
              label: LocaleKeys.placeTypes_food.tr()),
          BottomNavigationBarItem(
              icon: Icon(Icons.coffee_outlined),
              label: LocaleKeys.placeTypes_cafe.tr(),
              activeIcon: Icon(Icons.coffee)),
          // BottomNavigationBarItem(
          //     icon: Icon(Icons.local_movies_outlined), label: LocaleKeys.placeTypes_cinema.tr()),
          // BottomNavigationBarItem(icon: Icon(Icons.local_cafe_rounded), label: LocaleKeys.placeTypes_cafe.tr()),
          // BottomNavigationBarItem(icon: const Icon(Icons.settings), label: LocaleKeys.placeTypes_map.tr()),
        ]);
  }
}
