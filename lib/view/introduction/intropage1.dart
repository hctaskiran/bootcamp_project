import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:bootcamp_project/constants/colors.dart';
import 'package:bootcamp_project/core/init/lang/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class IntroPage1 extends StatefulWidget {
  const IntroPage1({super.key});

  @override
  State<IntroPage1> createState() => _IntroPage1State();
}

class _IntroPage1State extends State<IntroPage1> {
  late final String _anim = 'https://lottie.host/8cf4e7e1-ca15-4f8e-95db-c38da46fde41/ZyR2nfUdkx.json';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 200),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: AnimatedTextKit(
                      pause: const Duration(seconds: 30),
                      totalRepeatCount: 1,
                      animatedTexts: [
                        TyperAnimatedText(
                          LocaleKeys.intro_page2.tr(),
                          textAlign: TextAlign.center,
                          textStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: CColor.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Lottie.network(_anim)
          ],
        ),
      ),
    );
  }
}
