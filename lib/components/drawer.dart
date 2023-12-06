import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:bootcamp_project/constants/colors.dart';
import 'package:bootcamp_project/init/lang/locale_keys.g.dart';
import 'package:bootcamp_project/view/sub/favorites.dart';
import 'package:bootcamp_project/view/sub/profile_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  final String _title = "POCKET   PLACE";

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          _drawerHeaderTitle(),
          _divider(),
          const SizedBox(
            height: 10,
          ),
          Column(
            children: [
              ListTile(
                leading: const Icon(Icons.person_2_outlined),
                title: Text(LocaleKeys.drawer_profile.tr()),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileView()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.favorite_border_outlined),
                title: Text(LocaleKeys.placeTypes_favorites.tr()),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const FavoritesView()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.info_outline),
                title: Text(LocaleKeys.drawer_aboutAppTitle.tr()),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Text(
                          LocaleKeys.drawer_aboutAppText.tr(),
                          style: TextStyle(color: CColor.black),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Padding _divider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Divider(
        color: CColor.black,
        thickness: 1,
      ),
    );
  }

  SizedBox _drawerHeaderTitle() {
    return SizedBox(
      height: 100,
      child: Center(
        child: AnimatedTextKit(repeatForever: true, animatedTexts: [
          WavyAnimatedText((_title),
              speed: const Duration(milliseconds: 300), textStyle: TextStyle(color: CColor.black, fontSize: 24))
        ]),
      ),
    );
  }
}
