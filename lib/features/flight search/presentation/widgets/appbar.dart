import 'package:flight_search_app/features/flight%20search/presentation/widgets/colors.dart';
import 'package:flight_search_app/features/flight%20search/presentation/widgets/text.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget icon;
  const CustomAppBar({super.key, required this.title, required this.icon});

  @override
  Size get preferredSize => Size.fromHeight(60.spMin);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarOpacity: 1,
      automaticallyImplyLeading: false,
      backgroundColor: lightGrey,
      elevation: 0,
      title: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.spMin),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },

              child: icon,
            ),
            CustomTextWidget(
              text: title,
              fontSize: 18.spMin,
              color: black,
              fontWeight: FontWeight.w700,
            ),
            SizedBox(width: 24.spMin),
          ],
        ),
      ),
    );
  }
}
