import 'package:flight_search_app/features/flight%20search/presentation/pages/search/flight_details_screen.dart';
import 'package:flight_search_app/features/flight%20search/presentation/widgets/appbar.dart';
import 'package:flight_search_app/features/flight%20search/presentation/widgets/colors.dart';
import 'package:flight_search_app/features/flight%20search/presentation/widgets/text.dart';
import 'package:flight_search_app/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  // Initialize PageController with viewportFraction
  final PageController _pageController = PageController(viewportFraction: 0.8);

  // Sample data for flights - replace with your actual data
  final List<Map<String, dynamic>> flights = [
    {
      'stops': '1 Stop',
      'airline': 'Alaska Airlines',
      'details': 'JFK 1:00 PM • LAX 4:00 PM • 6h 0m',
      'color': teal,
    },
    {
      'stops': 'Non-stop',
      'airline': 'Delta Airlines',
      'details': 'JFK 2:30 PM • LAX 5:30 PM • 5h 0m',
      'color': Colors.blue,
    },
    {
      'stops': '2 Stops',
      'airline': 'American Airlines',
      'details': 'JFK 8:00 AM • LAX 3:00 PM • 7h 0m',
      'color': Colors.orange,
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightGrey,
      appBar: CustomAppBar(icon: Assets.svg.backArrow.svg(), title: 'Flights'),
      body: Column(
        children: [
          // Result header
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.spMin),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // From column
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextWidget(
                      text: 'JFK',
                      fontSize: 16.spMin,
                      color: black,
                      fontWeight: FontWeight.w500,
                    ),
                    CustomTextWidget(
                      text: 'New York',
                      fontSize: 14.spMin,
                      color: lightGrey4,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
                Assets.svg.flightIcon.svg(),
                // To column
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextWidget(
                      text: 'LAX',
                      fontSize: 16.spMin,
                      color: black,
                      fontWeight: FontWeight.w500,
                    ),
                    CustomTextWidget(
                      text: 'Los Angeles',
                      fontSize: 14.spMin,
                      color: lightGrey4,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 20.spMin),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.spMin),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomTextWidget(
                  text: 'Fri, Jul 12 · 1 Adult',
                  fontSize: 18.spMin,
                  color: black,
                  fontWeight: FontWeight.w700,
                ),
              ],
            ),
          ),
          SizedBox(height: 20.spMin),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.spMin),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomTextWidget(
                  text: 'Sort & Filter',
                  fontSize: 16.spMin,
                  color: black,
                  fontWeight: FontWeight.w400,
                ),
                Assets.svg.filter.svg(),
              ],
            ),
          ),
          SizedBox(height: 14.spMin),

          // PageView of results
          Container(
            padding: EdgeInsets.only(top: 16.spMin, bottom: 16.spMin),
            color: white,
            height: 257.spMin,
            width: double.infinity,
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: flights.length,
                    onPageChanged: (int page) {
                      setState(() {});
                    },
                    itemBuilder: (context, index) {
                      final flight = flights[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FlightDetailsScreen(),
                            ),
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 8.spMin,
                            right: 8
                                .spMin, // Added right padding for gap between pages
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 139.spMin,
                                width: 293.spMin, // Changed to fixed width
                                decoration: BoxDecoration(
                                  color: flight['color'],
                                  borderRadius: BorderRadius.circular(12.spMin),
                                ),
                                child: Center(
                                  child: CustomTextWidget(
                                    text: 'Flight ${index + 1}',
                                    fontSize: 18.spMin,
                                    color: white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(height: 14.spMin),
                              CustomTextWidget(
                                text: flight['stops'],
                                fontSize: 14.spMin,
                                color: lightGrey4,
                                fontWeight: FontWeight.w400,
                              ),
                              CustomTextWidget(
                                text: flight['airline'],
                                fontSize: 16.spMin,
                                color: black,
                                fontWeight: FontWeight.w700,
                              ),
                              SizedBox(height: 4.spMin),
                              CustomTextWidget(
                                text: flight['details'],
                                fontSize: 14.spMin,
                                color: lightGrey4,
                                fontWeight: FontWeight.w400,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.spMin),

          // Smooth Page Indicator
          SmoothPageIndicator(
            controller: _pageController,
            count: flights.length,
            effect: WormEffect(
              dotHeight: 8.spMin,
              dotWidth: 8.spMin,
              activeDotColor: teal,
              dotColor: lightGrey3,
              spacing: 8.spMin,
            ),
            onDotClicked: (index) {
              _pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
          ),
        ],
      ),
    );
  }
}
