// ignore_for_file: deprecated_member_use_from_same_package, deprecated_member_use

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
      height: 56.spMin,
      decoration: BoxDecoration(
        color: lightGrey2,
        borderRadius: BorderRadius.circular(12.spMin),
      ),
      child: DropdownButtonFormField<String>(
        borderRadius: BorderRadius.circular(12.spMin),
        value: widget.value,
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
            color: lightGrey4,
            fontSize: 16.spMin,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.spMin,
          ),
          filled: true,
          fillColor: lightGrey2,
          isDense: true,
          contentPadding: EdgeInsets.all(16.spMin),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.spMin),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.spMin),
            borderSide: BorderSide(color: blueAccent, width: 1.spMin),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.spMin),
            borderSide: BorderSide.none,
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.spMin),
            borderSide: BorderSide(color: Colors.red, width: 1.spMin),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.spMin),
            borderSide: BorderSide(color: Colors.red, width: 1.spMin),
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
                child: Assets.svg.dropdown.svg(color: black),
              ),
        isExpanded: true,
        dropdownColor: white,
        iconEnabledColor: black,
        selectedItemBuilder: (BuildContext context) {
          return widget.options.map<Widget>((String item) {
            return Container(
              alignment: Alignment.centerLeft,
              child: CustomTextWidget(
                text: item,
                fontSize: 16.spMin,
                color: black,
                fontWeight: FontWeight.w400,
              ),
            );
          }).toList();
        },
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
                    color: black,
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
                color: lightGrey4,
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
            color: black,
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
              width: 121.spMin,
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
