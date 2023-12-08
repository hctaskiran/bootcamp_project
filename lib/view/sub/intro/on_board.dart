import 'package:bootcamp_project/components/bottom_nav_bar.dart';
import 'package:bootcamp_project/constants/colors.dart';
import 'package:bootcamp_project/init/lang/locale_keys.g.dart';
import 'package:bootcamp_project/theme/animations/slide_anim.dart';
import 'package:bootcamp_project/view/sub/intro/intropage0.dart';
import 'package:bootcamp_project/view/sub/intro/intropage1.dart';
import 'package:bootcamp_project/view/sub/intro/intropage2.dart';
import 'package:bootcamp_project/view/sub/intro/intropage3.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// "page3": "Pocket Place, etrafındaki yerleri keşfetmeni sağlayan bir uygulamadır. \n\nUygulamayı kullanmak için, haritada bulunan yerlerden birini seçmen yeterli."

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _controller = PageController();

  @override
  void initState() {
    super.initState();
    checkOnboardingStatus();
  }

  Future<void> checkOnboardingStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    late bool onboardingCompleted = prefs.getBool('onboardingCompleted') ?? false;

    if (onboardingCompleted) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => const NavBarController())));
    }
  }

  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        PageView(
          onPageChanged: (index) {
            setState(() {
              onLastPage = (index == 3);
            });
          },
          controller: _controller,
          children: const [IntroPage0(), IntroPage1(), IntroPage2(), IntroPage3()],
        ),
        Container(
          alignment: const Alignment(0, 0.8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SmoothPageIndicator(
                  controller: _controller,
                  count: 4,
                  effect: ExpandingDotsEffect(dotColor: CColor.white, activeDotColor: Colors.orange)),
              onLastPage
                  ? GestureDetector(
                      onTap: () {
                        Navigator.push(context, SlideAnim(page: const NavBarController()));
                      },
                      child: Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          decoration:
                              BoxDecoration(color: Colors.grey.shade700, borderRadius: BorderRadius.circular(8)),
                          child: Text(LocaleKeys.intro_done.tr())))
                  : GestureDetector(
                      onTap: () {
                        _controller.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.linear);
                      },
                      child: Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          decoration:
                              BoxDecoration(color: Colors.grey.shade700, borderRadius: BorderRadius.circular(8)),
                          child: Text(LocaleKeys.intro_next.tr())))
            ],
          ),
        )
      ],
    ));
  }
}
