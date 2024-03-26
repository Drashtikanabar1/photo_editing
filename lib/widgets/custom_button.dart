import 'package:camera_functions/styles/app_colors.dart';
import 'package:camera_functions/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {Key? key,
      this.icon = const Icon(Icons.arrow_forward, color: Colors.white),
      required this.buttonText,
      required this.borderColor,
      required this.onTap,
      this.margin = EdgeInsets.zero,
      required this.bgColor,
      required this.textColor,
      this.height = 50,
      this.width = double.infinity,
      this.textSize = 15,
      this.letterSpacing = 0,
      this.borderRadius = 8,
      this.isToShowIcon = false})
      : super(key: key);

  final String buttonText;
  final Color borderColor, bgColor, textColor;
  final Function onTap;
  final double height, borderRadius, textSize, width;
  final EdgeInsetsGeometry margin;
  final bool? isToShowIcon;
  final Icon? icon;
  final double? letterSpacing;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Semantics(
        label: 'on_tap',
        child: Container(
          width: width,
          height: height,
          alignment: Alignment.center,
          margin: margin,
          decoration: BoxDecoration(
            border: Border.all(
              color: borderColor,
              width: 1.5,
            ),
            color: bgColor,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: isToShowIcon == true
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      buttonText,
                      style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: textSize.sp,
                          fontWeight: FontWeight.w700,
                          color: textColor),
                    ),
                    SizedBox(width: 15.w),
                    icon!,
                  ],
                )
              : Text(
                  buttonText,
                  style: TextStyle(
                      letterSpacing: 3,
                      fontFamily: "Poppins",
                      fontSize: textSize.sp,
                      fontWeight: FontWeight.w800,
                      color: textColor),
                ),
        ),
      ),
    );
  }
}
