import 'package:bootcamp_project/product/feature/constants/application.dart';
import 'package:bootcamp_project/product/feature/enum/language_enum.dart';
import 'package:bootcamp_project/product/widgets/bottom_nav_bar.dart';
import 'package:bootcamp_project/theme/theme_bottom_navigation_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await EasyLocalization.ensureInitialized();
  runApp(EasyLocalization(
      startLocale: Application.language.toLocale(),
      supportedLocales: Application.supportedLanguages.toLocale().toList(),
      path: Application.paths.translation,
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        scrollBehavior: const MaterialScrollBehavior().copyWith(overscroll: false),
        title: 'Pocket Place',
        theme: ThemeData(
          drawerTheme: const DrawerThemeData(surfaceTintColor: Colors.black),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          appBarTheme: _appBarTheme(),
          bottomNavigationBarTheme: const CustomBNBTheme(),
          textTheme:
              const TextTheme(bodyLarge: TextStyle(color: Colors.white), bodyMedium: TextStyle(color: Colors.white)),
          useMaterial3: true,
        ),
        home: const NavBarController());
  }

  AppBarTheme _appBarTheme() {
    return const AppBarTheme(
        backgroundColor: Color.fromARGB(255, 244, 206, 219),
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        titleTextStyle: TextStyle(color: Colors.black, fontSize: 24));
  }
}
