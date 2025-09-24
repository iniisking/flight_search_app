import 'package:flight_search_app/features/flight%20search/presentation/widgets/colors.dart';
import 'package:flight_search_app/features/flight%20search/presentation/widgets/text.dart';
import 'package:flight_search_app/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DropdownSelector extends StatefulWidget {
  final String hintText;
  final List<String> options;
  final String? value;
  final ValueChanged<String?> onChanged;
  final String? Function(String?)? validator;
  final bool isLoading;
  final bool isEmpty;

  const DropdownSelector({
    super.key,
    required this.hintText,
    required this.options,
    required this.value,
    required this.onChanged,
    this.validator,
    this.isLoading = false,
    this.isEmpty = false,
  });

  @override
  State<DropdownSelector> createState() => _DropdownSelectorState();
}

class _DropdownSelectorState extends State<DropdownSelector> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56.spMin, // Fixed height of 56px
      decoration: BoxDecoration(
        color: lightGrey2,
        borderRadius: BorderRadius.circular(12.spMin), // 12px border radius
      ),
      child: DropdownButtonFormField<String>(
        borderRadius: BorderRadius.circular(
          12.spMin,
        ), // 12px border radius for dropdown field
        initialValue: widget.value,
        onChanged: widget.isLoading ? null : widget.onChanged,
        validator: widget.validator,
        style: TextStyle(
          fontSize: 16.spMin,
          fontWeight: FontWeight.w400,
          overflow: TextOverflow.ellipsis,
          color: black,
        ),
        decoration: InputDecoration(
          hintText: widget.isLoading ? 'Loading...' : widget.hintText,
          hintStyle: TextStyle(
            color: black,
            fontSize: 16.spMin,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.spMin,
          ),
          filled: true,
          fillColor: lightGrey2,
          isDense: true,
          contentPadding: EdgeInsets.all(16.spMin),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.spMin), // 12px border radius
            borderSide: BorderSide.none, // No border
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.spMin), // 12px border radius
            borderSide: BorderSide.none, // No border
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.spMin), // 12px border radius
            borderSide: BorderSide.none, // No border
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.spMin), // 12px border radius
            borderSide: BorderSide.none, // No border
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.spMin), // 12px border radius
            borderSide: BorderSide.none, // No border
          ),
          suffixIcon: widget.isLoading
              ? Padding(
                  padding: EdgeInsets.all(16.spMin),
                  child: SizedBox(
                    width: 16.spMin,
                    height: 16.spMin,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: black,
                    ),
                  ),
                )
              : null,
        ),
        items: _buildDropdownItems(),
        icon: widget.isLoading
            ? null
            : Padding(
                padding: EdgeInsets.all(16.spMin),
                child: Assets.svg.dropdown.svg(),
              ),
        isExpanded: true,
        dropdownColor: lightGrey2, // Match dropdown background with field
      ),
    );
  }

  List<DropdownMenuItem<String>> _buildDropdownItems() {
    if (widget.isLoading) {
      return [
        DropdownMenuItem<String>(
          value: null,
          enabled: false,
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(16.spMin),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 20.spMin,
                    height: 20.spMin,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                  SizedBox(height: 8.spMin),
                  CustomTextWidget(
                    text: 'Loading...',
                    fontSize: 16.spMin,
                    color: black, // Match hint text color
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
            ),
          ),
        ),
      ];
    }

    if (widget.isEmpty) {
      return [
        DropdownMenuItem<String>(
          value: null,
          enabled: false,
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(16.spMin),
              child: CustomTextWidget(
                text: 'No options available',
                fontSize: 16.spMin,
                color: black, // Match hint text color
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ];
    }

    return widget.options.map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Padding(
          padding: EdgeInsets.all(16.spMin),
          child: CustomTextWidget(
            text: value,
            fontSize: 16.spMin,
            color: black, // Match hint text color
            fontWeight: FontWeight.w400,
          ),
        ),
      );
    }).toList();
  }
}

class FilterButton extends StatefulWidget {
  final ValueChanged<String> onFilterChanged;

  const FilterButton({super.key, required this.onFilterChanged});

  @override
  State<FilterButton> createState() => _FilterButtonState();
}

class _FilterButtonState extends State<FilterButton> {
  String _selectedFilter = 'One Way';

  final List<String> _filters = ['One Way', 'Round trip', 'Multi-City'];

  void _selectFilter(String filter) {
    setState(() {
      _selectedFilter = filter;
    });
    widget.onFilterChanged(filter);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.spMin),
      decoration: BoxDecoration(
        color: lightGrey3,
        borderRadius: BorderRadius.circular(20.spMin),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _filters.map((filter) {
          final isSelected = _selectedFilter == filter;

          return GestureDetector(
            onTap: () => _selectFilter(filter),
            child: Container(
              width: 121.spMin, // Fixed width of 121px
              padding: EdgeInsets.symmetric(vertical: 8.spMin),
              decoration: BoxDecoration(
                color: isSelected ? white : Colors.transparent,
                borderRadius: BorderRadius.circular(16.spMin),
              ),
              child: Center(
                // Center the text widget
                child: CustomTextWidget(
                  text: filter,
                  fontSize: 14.spMin,
                  color: isSelected ? black : tealAccent,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}


   //filter button
              // Container(
              //   padding: EdgeInsets.all(4.spMin),
              //   decoration: BoxDecoration(
              //     color: lightGrey3,
              //     borderRadius: BorderRadius.circular(20.spMin),
              //   ),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       //button 1
              //       Container(
              //         padding: EdgeInsets.symmetric(
              //           horizontal: 31.spMin,
              //           vertical: 5.spMin,
              //         ),
              //         decoration: BoxDecoration(
              //           color: white,
              //           borderRadius: BorderRadius.circular(16.spMin),
              //         ),
              //         child: Padding(
              //           padding: EdgeInsets.symmetric(
              //             vertical: 8.spMin,
              //             horizontal: 16.spMin,
              //           ),
              //           child: CustomTextWidget(
              //             text: 'One Way',
              //             fontSize: 14.spMin,
              //             color: black,
              //             fontWeight: FontWeight.w500,
              //           ),
              //         ),
              //       ),
              //       //button 2
              //       CustomTextWidget(
              //         text: 'Round trip',
              //         fontSize: 14.spMin,
              //         color: tealAccent,
              //         fontWeight: FontWeight.w500,
              //       ),

              //       //button 3
              //       CustomTextWidget(
              //         text: 'Multi-City',
              //         fontSize: 14.spMin,
              //         color: tealAccent,
              //         fontWeight: FontWeight.w500,
              //       ),
              //     ],
              //   ),
              // ),