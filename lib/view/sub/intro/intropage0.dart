import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:bootcamp_project/constants/colors.dart';
import 'package:bootcamp_project/init/lang/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class IntroPage0 extends StatefulWidget {
  const IntroPage0({super.key});

  @override
  State<IntroPage0> createState() => _IntroPage0State();
}

class _IntroPage0State extends State<IntroPage0> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 200),
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: AnimatedTextKit(
                      totalRepeatCount: 1,
                      pause: const Duration(seconds: 30),
                      animatedTexts: [
                        TyperAnimatedText(
                          LocaleKeys.intro_page1.tr(),
                          textAlign: TextAlign.center,
                          textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: CColor.black),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Lottie.network('https://lottie.host/0cec8b88-f922-4684-8ff5-d84f4634610c/Le1FQ8mJwi.json',
                frameRate: FrameRate(60))
          ],
        ),
      ),
    );
  }
}
