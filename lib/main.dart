import 'package:bootcamp_project/components/splash_screen.dart';
import 'package:bootcamp_project/constants/application.dart';
import 'package:bootcamp_project/constants/colors.dart';
import 'package:bootcamp_project/core/enum/language_enum.dart';
import 'package:bootcamp_project/theme/theme_app_bar.dart';
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
        // scrollBehavior: const MaterialScrollBehavior().copyWith(overscroll: false),
        title: 'Pocket Place',
        theme: ThemeData(
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              foregroundColor: CColor.r500,
              backgroundColor: CColor.gry100,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
          ),
          drawerTheme: DrawerThemeData(backgroundColor: CColor.white, surfaceTintColor: CColor.black),
          splashColor: CColor.tr,
          highlightColor: CColor.tr,
          appBarTheme: CustomAppBarTheme(),
          bottomNavigationBarTheme: CustomBNBTheme(),
          textTheme: TextTheme(bodyLarge: TextStyle(color: CColor.white), bodyMedium: TextStyle(color: CColor.white)),
        ),
        home: const SplashScreen());
  }
}
