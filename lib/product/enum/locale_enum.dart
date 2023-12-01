import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

enum LocaleEnums {
  english(Locale('en', 'US')),
  turkish(Locale('tr', 'TR')),
  russian(Locale('ru', 'RU'));

  final Locale locale;
  const LocaleEnums(this.locale);

  void updateLanguage(BuildContext context) =>
      context.mounted ? context.setLocale(locale) : null;
}
