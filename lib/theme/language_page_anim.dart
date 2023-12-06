import 'package:flutter/material.dart';

class LanguageAnim extends PageRouteBuilder {
  final Widget page;

  LanguageAnim({required this.page})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = 0.0;
            const end = 1.0;
            var tween = Tween(begin: begin, end: end);
            var opacityAnimation = animation.drive(tween);

            return FadeTransition(
              opacity: opacityAnimation,
              child: child,
            );
          },
        );
}
