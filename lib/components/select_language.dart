import 'package:bootcamp_project/components/bottom_nav_bar.dart';
import 'package:bootcamp_project/constants/colors.dart';
import 'package:bootcamp_project/core/enum/locale_enum.dart';
import 'package:bootcamp_project/theme/animations/fade_anim.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ChooseLanguage extends Padding {
  final BuildContext context;

  ChooseLanguage({super.key, required this.context})
      : super(
          padding: const EdgeInsets.only(right: 15),
          child: Container(
            decoration: BoxDecoration(color: Colors.pink[400], borderRadius: BorderRadius.circular(10)),
            child: DropdownButton(
              iconEnabledColor: CColor.white,
              iconDisabledColor: CColor.white,
              padding: const EdgeInsets.all(5),
              isDense: true,
              hint: Icon(
                Icons.language_rounded,
                color: CColor.white,
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
                Navigator.push(
                  context,
                  FadeAnim(page: const NavBarController()),
                );
              },
            ),
          ),
        );
}
