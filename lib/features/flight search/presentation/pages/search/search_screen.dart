import 'package:flight_search_app/features/flight%20search/presentation/pages/search/result_screen.dart';
import 'package:flight_search_app/features/flight%20search/presentation/widgets/appbar.dart';
import 'package:flight_search_app/features/flight%20search/presentation/widgets/buttons.dart';
import 'package:flight_search_app/features/flight%20search/presentation/widgets/colors.dart';
import 'package:flight_search_app/features/flight%20search/presentation/widgets/dropdown.dart';
import 'package:flight_search_app/features/flight%20search/presentation/widgets/text.dart';
import 'package:flight_search_app/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchScreen extends StatefulWidget {
  final ValueChanged<bool>? onChanged;
  const SearchScreen({super.key, this.onChanged});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool _isDirectFlightsOnly = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        icon: Assets.svg.backArrow.svg(),
        title: 'Search Flights',
      ),
      backgroundColor: lightGrey,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.spMin),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 20.spMin),
                      DropdownSelector(
                        hintText: 'From',
                        options: ['Option 1', 'Option 2', 'Option 3'],
                        value: null,
                        onChanged: (value) {},
                      ),
                      SizedBox(height: 16.spMin),
                      DropdownSelector(
                        hintText: 'To',
                        options: ['Option 1', 'Option 2', 'Option 3'],
                        value: null,
                        onChanged: (value) {},
                      ),
                      SizedBox(height: 20.spMin),
                      FilterButton(
                        onFilterChanged: (selectedFilter) {
                          debugPrint('Selected filter: $selectedFilter');
                          // Handle filter change logic here
                        },
                      ),
                      SizedBox(height: 16.spMin),
                      Container(
                        width: double.infinity.spMin,
                        padding: EdgeInsets.all(16.spMin),
                        decoration: BoxDecoration(
                          color: lightGrey2,
                          borderRadius: BorderRadius.circular(12.spMin),
                        ),
                        child: CustomTextWidget(
                          text: 'Departure  Date',
                          fontSize: 16.spMin,
                          color: lightGrey4,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 20.spMin),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CustomTextWidget(
                            text: 'Optional Filters',
                            fontSize: 18.spMin,
                            color: black,
                            fontWeight: FontWeight.w700,
                          ),
                        ],
                      ),
                      SizedBox(height: 20.spMin),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomTextWidget(
                            text: 'Direct Flights Only',
                            fontSize: 16.spMin,
                            color: black,
                            fontWeight: FontWeight.w400,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _isDirectFlightsOnly = !_isDirectFlightsOnly;
                              });
                            },
                            child: Container(
                              width: 51.spMin,
                              height: 31.spMin,
                              decoration: BoxDecoration(
                                color: _isDirectFlightsOnly
                                    ? blueAccent
                                    : lightGrey2,
                                borderRadius: BorderRadius.circular(15.5.spMin),
                              ),
                              child: AnimatedAlign(
                                duration: const Duration(milliseconds: 200),
                                alignment: _isDirectFlightsOnly
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                                child: Container(
                                  width: 27.spMin,
                                  height: 27.spMin,
                                  margin: EdgeInsets.all(2.spMin),
                                  decoration: BoxDecoration(
                                    color: white,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.spMin),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomTextWidget(
                            text: 'Include Nearby Airports',
                            fontSize: 16.spMin,
                            color: black,
                            fontWeight: FontWeight.w400,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _isDirectFlightsOnly = !_isDirectFlightsOnly;
                              });
                            },
                            child: Container(
                              width: 51.spMin,
                              height: 31.spMin,
                              decoration: BoxDecoration(
                                color: _isDirectFlightsOnly
                                    ? blueAccent
                                    : lightGrey2,
                                borderRadius: BorderRadius.circular(15.5.spMin),
                              ),
                              child: AnimatedAlign(
                                duration: const Duration(milliseconds: 200),
                                alignment: _isDirectFlightsOnly
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                                child: Container(
                                  width: 27.spMin,
                                  height: 27.spMin,
                                  margin: EdgeInsets.all(2.spMin),
                                  decoration: BoxDecoration(
                                    color: white,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.spMin),
                    ],
                  ),
                ),
              ),
              AppButton(
                backGroundColor: blueAccent,
                text: CustomTextWidget(
                  text: 'Search Flights',
                  fontSize: 16.spMin,
                  color: white,
                  fontWeight: FontWeight.w700,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ResultScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
