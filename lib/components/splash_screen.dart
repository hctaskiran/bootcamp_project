import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:bootcamp_project/constants/colors.dart';
import 'package:bootcamp_project/view/introduction/on_board.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        children: [
          Image.asset('assets/img/splash.png', width: 300, height: 300),
          AnimatedTextKit(pause: const Duration(seconds: 3), animatedTexts: [
            TypewriterAnimatedText('Pocket Place',
                speed: const Duration(milliseconds: 100),
                textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: CColor.black))
          ])
        ],
      ),
      splashIconSize: 350,
      backgroundColor: Colors.pink[100]!,
      nextScreen: const OnBoardingScreen(),
      duration: 6500,
      splashTransition: SplashTransition.scaleTransition,
    );
  }
}
