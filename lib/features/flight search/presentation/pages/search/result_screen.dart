import 'package:flight_search_app/features/flight%20search/presentation/pages/search/flight_details_screen.dart';
import 'package:flight_search_app/features/flight%20search/presentation/providers/flight_providers.dart';
import 'package:flight_search_app/features/flight%20search/presentation/widgets/appbar.dart';
import 'package:flight_search_app/features/flight%20search/presentation/widgets/colors.dart';
import 'package:flight_search_app/features/flight%20search/presentation/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flight_search_app/gen/assets.gen.dart';

class ResultScreen extends ConsumerStatefulWidget {
  final String departure;
  final String arrival;
  final DateTime date;

  const ResultScreen({
    super.key,
    required this.departure,
    required this.arrival,
    required this.date,
  });

  @override
  ConsumerState<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends ConsumerState<ResultScreen> {
  final PageController _pageController = PageController(viewportFraction: 0.8);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  String _getCityName(String iataCode) {
    final cityMap = {
      'JFK': 'New York',
      'LAX': 'Los Angeles',
      'LHR': 'London',
      'CDG': 'Paris',
      'DXB': 'Dubai',
      'SIN': 'Singapore',
      'HND': 'Tokyo',
      'FRA': 'Frankfurt',
      'AMS': 'Amsterdam',
      'IST': 'Istanbul',
    };
    return cityMap[iataCode] ?? iataCode;
  }

  Color _getFlightColor(int index) {
    final colors = [
      teal,
      Colors.blue,
      Colors.orange,
      Colors.purple,
      Colors.green,
    ];
    return colors[index % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(flightSearchNotifierProvider);
    final flights = state.flights;

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
                      text: widget.departure,
                      fontSize: 16.spMin,
                      color: black,
                      fontWeight: FontWeight.w500,
                    ),
                    CustomTextWidget(
                      text: _getCityName(widget.departure),
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
                      text: widget.arrival,
                      fontSize: 16.spMin,
                      color: black,
                      fontWeight: FontWeight.w500,
                    ),
                    CustomTextWidget(
                      text: _getCityName(widget.arrival),
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
                  text:
                      '${_formatDate(widget.date)} · ${flights.length} Flights Found',
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

          // Show loading or empty state
          if (state.isLoading)
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16.spMin),
                    CustomTextWidget(
                      text: 'Loading flights...',
                      fontSize: 16.spMin,
                      color: black,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
              ),
            )
          else if (flights.isEmpty)
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.flight, size: 64.spMin, color: lightGrey4),
                    SizedBox(height: 16.spMin),
                    CustomTextWidget(
                      text: 'No flights found',
                      fontSize: 18.spMin,
                      color: lightGrey4,
                      fontWeight: FontWeight.w400,
                    ),
                    SizedBox(height: 8.spMin),
                    CustomTextWidget(
                      text: 'Try different airports or dates',
                      fontSize: 14.spMin,
                      color: lightGrey4,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
              ),
            )
          else
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
                                builder: (context) =>
                                    FlightDetailsScreen(flight: flight),
                              ),
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: 8.spMin,
                              right: 8.spMin,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 139.spMin,
                                  width: 293.spMin,
                                  decoration: BoxDecoration(
                                    color: _getFlightColor(index),
                                    borderRadius: BorderRadius.circular(
                                      12.spMin,
                                    ),
                                  ),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CustomTextWidget(
                                          text:
                                              '\$${flight.price.toStringAsFixed(0)}',
                                          fontSize: 24.spMin,
                                          color: white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        SizedBox(height: 4.spMin),
                                        CustomTextWidget(
                                          text: flight.airlineName,
                                          fontSize: 14.spMin,
                                          color: white,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 14.spMin),
                                CustomTextWidget(
                                  text: flight.stops == 0
                                      ? 'Non-stop'
                                      : '${flight.stops} Stop${flight.stops > 1 ? 's' : ''}',
                                  fontSize: 14.spMin,
                                  color: lightGrey4,
                                  fontWeight: FontWeight.w400,
                                ),
                                CustomTextWidget(
                                  text: flight.airlineName,
                                  fontSize: 16.spMin,
                                  color: black,
                                  fontWeight: FontWeight.w700,
                                ),
                                SizedBox(height: 4.spMin),
                                CustomTextWidget(
                                  text:
                                      '${flight.departureIata} ${flight.formattedDepartureTime} • ${flight.arrivalIata} ${flight.formattedArrivalTime} • ${flight.duration}',
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

          if (flights.isNotEmpty) SizedBox(height: 16.spMin),

          if (flights.isNotEmpty)
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

  String _formatDate(DateTime date) {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return '${days[date.weekday - 1]}, ${months[date.month - 1]} ${date.day}';
  }
}
