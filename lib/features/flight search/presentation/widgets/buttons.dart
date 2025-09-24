import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppButton extends StatelessWidget {
  final Color backGroundColor;
  final double height;
  final Widget text;
  final VoidCallback? onTap;
  const AppButton({
    super.key,
    required this.backGroundColor,
    this.height = 48,
    required this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: double.infinity,
        decoration: BoxDecoration(
          color: backGroundColor,
          borderRadius: BorderRadius.circular(24.spMin),
        ),
        child: Center(child: text),
      ),
    );
  }
}
