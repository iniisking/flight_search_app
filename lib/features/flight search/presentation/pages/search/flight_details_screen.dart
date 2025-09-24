import 'package:flight_search_app/features/flight%20search/presentation/widgets/appbar.dart';
import 'package:flight_search_app/features/flight%20search/presentation/widgets/colors.dart';
import 'package:flight_search_app/features/flight%20search/presentation/widgets/text.dart'; // Import your CustomTextWidget
import 'package:flight_search_app/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FlightDetailsScreen extends StatelessWidget {
  const FlightDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightGrey,
      appBar: CustomAppBar(
        icon: Icon(Icons.close, size: 24.spMin, color: black),
        title: 'Flight Details',
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.spMin),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 20.spMin),
                    //flight name and number
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 28.spMin,
                          backgroundColor: lightGrey2,
                          child: Icon(
                            Icons.flight,
                            size: 28.spMin,
                            color: black,
                          ),
                        ),
                        SizedBox(width: 16.spMin),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextWidget(
                              text: 'Alaska Airlines',
                              fontSize: 16.spMin,
                              fontWeight: FontWeight.w500,
                              color: black,
                            ),
                            SizedBox(height: 4.spMin),
                            CustomTextWidget(
                              text: 'Flight No: AS123',
                              fontSize: 14.spMin,
                              color: lightGrey4,
                              fontWeight: FontWeight.w400,
                            ),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(height: 24.spMin),
                    //aircraft type
                    Row(
                      children: [
                        Assets.svg.aircraft.svg(),
                        SizedBox(width: 16.spMin),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextWidget(
                              text: 'Alaska Airlines',
                              fontSize: 16.spMin,
                              fontWeight: FontWeight.w500,
                              color: black,
                            ),
                            SizedBox(height: 4.spMin),
                            CustomTextWidget(
                              text: 'Flight No: AS123',
                              fontSize: 14.spMin,
                              color: lightGrey4,
                              fontWeight: FontWeight.w400,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 30.spMin),
                    //Flight information
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CustomTextWidget(
                          text: 'Flight Information',
                          fontSize: 18.spMin,
                          color: black,
                          fontWeight: FontWeight.w700,
                        ),
                      ],
                    ),
                    SizedBox(height: 24.spMin),
                    Row(
                      children: [
                        Assets.svg.duration.svg(),
                        SizedBox(width: 16.spMin),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextWidget(
                              text: 'Total Duration',
                              fontSize: 16.spMin,
                              fontWeight: FontWeight.w500,
                              color: black,
                            ),
                            SizedBox(height: 4.spMin),
                            CustomTextWidget(
                              text: '5h 30m',
                              fontSize: 14.spMin,
                              color: lightGrey4,
                              fontWeight: FontWeight.w400,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 24.spMin),
                    Row(
                      children: [
                        Assets.svg.stops.svg(),
                        SizedBox(width: 16.spMin),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextWidget(
                              text: 'Layovers and Stops',
                              fontSize: 16.spMin,
                              fontWeight: FontWeight.w500,
                              color: black,
                            ),
                            SizedBox(height: 4.spMin),
                            CustomTextWidget(
                              text: 'Layovers and Stops',
                              fontSize: 14.spMin,
                              color: lightGrey4,
                              fontWeight: FontWeight.w400,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
