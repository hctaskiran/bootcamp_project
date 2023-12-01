import 'package:bootcamp_project/product/constants/application.dart';
import 'package:bootcamp_project/product/enum/language_enum.dart';
import 'package:bootcamp_project/product/widgets/bottom_nav_bar/bottom_nav_bar.dart';
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
        title: 'Google API App',
        theme: ThemeData(
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
        backgroundColor: Colors.blue,
        // backgroundColor: Colors.grey[900],
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 24));
  }
}
