// ignore_for_file: non_constant_identifier_names

import 'package:bootcamp_project/constants/colors.dart';
import 'package:bootcamp_project/constants/sized_box.dart';
import 'package:bootcamp_project/init/lang/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

Widget DataNotFound(VoidCallback onPressed) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(
        Icons.error,
        color: CColor.red,
        size: 40,
      ),
      SB.h10,
      Text(
        LocaleKeys.fails_failedData.tr(),
        style: TextStyle(color: CColor.red),
      ),
      SB.h10,
      ElevatedButton(
        onPressed: onPressed,
        child: Text(LocaleKeys.fails_refreshButton.tr()),
      ),
    ],
  );
}
