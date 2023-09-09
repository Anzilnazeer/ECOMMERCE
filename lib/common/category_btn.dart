import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newchat/colors.dart';

class CategoryButton extends StatelessWidget {
  final void Function()? onPress;
  final Color buttonClr;
  final String label;
  const CategoryButton(
      {super.key, this.onPress, required this.buttonClr, required this.label});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPress,
      child: Container(
        height: 45.h,
        width: 90.w,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              width: 2.w,
              color: buttonClr,
              style: BorderStyle.solid,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(9))),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
              color: brandColor,
            ),
          ),
        ),
      ),
    );
  }
}
