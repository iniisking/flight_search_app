import 'package:flight_search_app/features/flight%20search/presentation/pages/search/result_screen.dart';
import 'package:flight_search_app/features/flight%20search/presentation/providers/flight_providers.dart';
import 'package:flight_search_app/features/flight%20search/presentation/widgets/appbar.dart';
import 'package:flight_search_app/features/flight%20search/presentation/widgets/buttons.dart';
import 'package:flight_search_app/features/flight%20search/presentation/widgets/colors.dart';
import 'package:flight_search_app/features/flight%20search/presentation/widgets/dropdown.dart';
import 'package:flight_search_app/features/flight%20search/presentation/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flight_search_app/gen/assets.gen.dart';

class SearchScreen extends ConsumerStatefulWidget {
  final ValueChanged<bool>? onChanged;
  const SearchScreen({super.key, this.onChanged});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final List<String> popularAirports = [
    'JFK',
    'LAX',
    'LHR',
    'CDG',
    'DXB',
    'SIN',
    'HND',
    'FRA',
    'AMS',
    'IST',
  ];

  String? _selectedDeparture;
  String? _selectedArrival;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now().add(const Duration(days: 1));
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(flightSearchNotifierProvider);

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
                        hintText: 'From (IATA Code)',
                        options: popularAirports,
                        value: _selectedDeparture,
                        onChanged: (value) {
                          setState(() {
                            _selectedDeparture = value;
                          });
                          ref
                              .read(flightSearchNotifierProvider.notifier)
                              .setDeparture(value ?? '');
                        },
                      ),
                      SizedBox(height: 16.spMin),
                      DropdownSelector(
                        hintText: 'To (IATA Code)',
                        options: popularAirports,
                        value: _selectedArrival,
                        onChanged: (value) {
                          setState(() {
                            _selectedArrival = value;
                          });
                          ref
                              .read(flightSearchNotifierProvider.notifier)
                              .setArrival(value ?? '');
                        },
                      ),
                      SizedBox(height: 20.spMin),
                      FilterButton(
                        onFilterChanged: (selectedFilter) {
                          debugPrint('Selected filter: $selectedFilter');
                          // Handle filter change logic here
                        },
                      ),
                      SizedBox(height: 16.spMin),
                      GestureDetector(
                        onTap: _selectDate,
                        child: Container(
                          width: double.infinity.spMin,
                          padding: EdgeInsets.all(16.spMin),
                          decoration: BoxDecoration(
                            color: lightGrey2,
                            borderRadius: BorderRadius.circular(12.spMin),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomTextWidget(
                                text: _selectedDate != null
                                    ? 'Departure Date: ${_formatDate(_selectedDate!)}'
                                    : 'Select Departure Date',
                                fontSize: 16.spMin,
                                color: lightGrey4,
                                fontWeight: FontWeight.w400,
                              ),
                              Icon(
                                Icons.calendar_today,
                                color: lightGrey4,
                                size: 20.spMin,
                              ),
                            ],
                          ),
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
                      _buildToggleOption(
                        text: 'Direct Flights Only',
                        value: state.directFlightsOnly,
                        onChanged: (value) {
                          ref
                              .read(flightSearchNotifierProvider.notifier)
                              .setDirectFlightsOnly(value);
                        },
                      ),
                      SizedBox(height: 20.spMin),
                      _buildToggleOption(
                        text: 'Include Nearby Airports',
                        value: state.includeNearbyAirports,
                        onChanged: (value) {
                          ref
                              .read(flightSearchNotifierProvider.notifier)
                              .setIncludeNearbyAirports(value);
                        },
                      ),
                      SizedBox(height: 20.spMin),

                      // Error message
                      if (state.error != null)
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(12.spMin),
                          decoration: BoxDecoration(
                            color: Colors.red.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8.spMin),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.error_outline,
                                color: Colors.red,
                                size: 16.spMin,
                              ),
                              SizedBox(width: 8.spMin),
                              Expanded(
                                child: CustomTextWidget(
                                  text: state.error!,
                                  fontSize: 14.spMin,
                                  color: Colors.red,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              AppButton(
                backGroundColor: blueAccent,
                text: CustomTextWidget(
                  text: state.isLoading ? 'Searching...' : 'Search Flights',
                  fontSize: 16.spMin,
                  color: white,
                  fontWeight: FontWeight.w700,
                ),
                onTap: _performSearch,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildToggleOption({
    required String text,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomTextWidget(
          text: text,
          fontSize: 16.spMin,
          color: black,
          fontWeight: FontWeight.w400,
        ),
        GestureDetector(
          onTap: () {
            onChanged(!value);
          },
          child: Container(
            width: 51.spMin,
            height: 31.spMin,
            decoration: BoxDecoration(
              color: value ? blueAccent : lightGrey2,
              borderRadius: BorderRadius.circular(15.5.spMin),
            ),
            child: AnimatedAlign(
              duration: const Duration(milliseconds: 200),
              alignment: value ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                width: 27.spMin,
                height: 27.spMin,
                margin: EdgeInsets.all(2.spMin),
                decoration: BoxDecoration(color: white, shape: BoxShape.circle),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
      ref.read(flightSearchNotifierProvider.notifier).setDate(picked);
    }
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  void _performSearch() {
    if (_selectedDeparture == null ||
        _selectedArrival == null ||
        _selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select departure, arrival, and date'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (_selectedDeparture!.length != 3 || _selectedArrival!.length != 3) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter valid 3-letter IATA codes'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    ref.read(flightSearchNotifierProvider.notifier).searchFlights().then((_) {
      // Navigate to results screen after search completes
      if (ref.read(flightSearchNotifierProvider).error == null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResultScreen(
              departure: _selectedDeparture!,
              arrival: _selectedArrival!,
              date: _selectedDate!,
            ),
          ),
        );
      }
    });
  }
}
