import 'package:flight_search_app/features/flight%20search/presentation/widgets/buttons.dart';
import 'package:flight_search_app/features/flight%20search/presentation/widgets/colors.dart';
import 'package:flight_search_app/features/flight%20search/presentation/widgets/text.dart';
import 'package:flight_search_app/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingPage> _pages = [
    OnboardingPage(
      backgroundColor: bluePrimary,
      image: Assets.images.onboarding1.image(),
      title: 'Search Flights Instantly',
      subtitle: 'Find the best flight deals in seconds',
    ),
    OnboardingPage(
      backgroundColor: purpleSecondary,
      image: Assets.images.onboarding2.image(),
      title: 'Compare Prices Easily',
      subtitle:
          'Find the best deals on flights from\nmultiple airlines in one place.',
    ),
    OnboardingPage(
      backgroundColor: orangeAccent,
      image: Assets.images.onboarding3.image(),
      title: 'Book with Confidence',
      subtitle: 'Secure your travel plans with our reliable\nbooking process.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _pages[_currentPage].backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 40.spMin),
            Expanded(
              flex: 3,
              child: PageView(
                controller: _pageController,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                children: _pages
                    .map((page) => _buildPageContent(page))
                    .toList(),
              ),
            ),
            SizedBox(height: 20.spMin),
            SmoothPageIndicator(
              controller: _pageController,
              count: _pages.length,
              effect: WormEffect(
                dotHeight: 8.spMin,
                dotWidth: 8.spMin,
                spacing: 12.spMin,
                dotColor: grey,
                activeDotColor: white,
              ),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.spMin),
              child: AppButton(
                backGroundColor: white,
                text: CustomTextWidget(
                  text: _currentPage == _pages.length - 1
                      ? 'Get Started'
                      : 'Next',
                  fontSize: 16.spMin,
                  color: black,
                  fontWeight: FontWeight.w700,
                ),
                onTap: () {
                  if (_currentPage < _pages.length - 1) {
                    _pageController.nextPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                    );
                  } else {
                    // Navigate to next screen
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => NextScreen()));
                  }
                },
              ),
            ),
            SizedBox(height: 40.spMin),
          ],
        ),
      ),
    );
  }

  Widget _buildPageContent(OnboardingPage page) {
    return Column(
      children: [
        page.image,
        SizedBox(height: 20.spMin),
        CustomTextWidget(
          text: page.title,
          fontSize: 28.spMin,
          color: white,
          fontWeight: FontWeight.w700,
        ),
        SizedBox(height: 12.spMin),
        CustomTextWidget(
          text: page.subtitle,
          fontSize: 16.spMin,
          color: white,
          fontWeight: FontWeight.w400,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class OnboardingPage {
  final Color backgroundColor;
  final Widget image;
  final String title;
  final String subtitle;

  OnboardingPage({
    required this.backgroundColor,
    required this.image,
    required this.title,
    required this.subtitle,
  });
}
