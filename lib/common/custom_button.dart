// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  final double height;
  final double width;
  final Gradient? gradient;
  final BorderRadiusGeometry? borderRadius;
  final Color? backgroundColor;
  final bool isLoading;

  final List<BoxShadow>? boxShadow;
  const CustomButton({
    Key? key,
    required this.text,
    this.onPressed,
    required this.height,
    required this.width,
    this.gradient,
    this.borderRadius,
    this.backgroundColor,
    this.isLoading = false,
    this.boxShadow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var loading = SizedBox(
        width: 50.w,
        height: 20.h,
        child: const SpinKitSpinningLines(
          color: Color.fromARGB(255, 255, 255, 255),
          size: 40,
        ));
    return SizedBox(
      height: height,
      width: width,
      child: DecoratedBox(
        decoration: BoxDecoration(
            color: backgroundColor,
            gradient: gradient,
            borderRadius: borderRadius,
            boxShadow: boxShadow),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            disabledForegroundColor: Colors.transparent.withOpacity(0.38),
            disabledBackgroundColor: Colors.transparent.withOpacity(0.12),
            shadowColor: Colors.transparent,
            //make color or elevated button transparent
          ),
          onPressed: onPressed,
          child: isLoading
              ? loading
              : Text(
                  text,
                  style: TextStyle(fontSize: 16.sp, color: Colors.white),
                ),
        ),
      ),
    );
  }
}
