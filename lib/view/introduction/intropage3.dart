import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:bootcamp_project/constants/colors.dart';
import 'package:bootcamp_project/core/init/lang/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class IntroPage3 extends StatefulWidget {
  const IntroPage3({super.key});

  @override
  State<IntroPage3> createState() => _IntroPage3State();
}

class _IntroPage3State extends State<IntroPage3> {
  late final String _anim = 'https://lottie.host/1c16e794-f742-4fda-a060-fa5f435f0a5b/BiVMq4B3qY.json';

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
                          LocaleKeys.intro_page4.tr(),
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
