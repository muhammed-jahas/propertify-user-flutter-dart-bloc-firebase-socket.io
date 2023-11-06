import 'package:flutter/material.dart';
import 'package:propertify/constants/colors/colors.dart';
import 'package:propertify/constants/spaces%20&%20paddings/spaces.dart';

// ignore: must_be_immutable
class CustomSpanTextVertical extends StatelessWidget {
  String? firstText;
  String? spanText;
  VoidCallback? spanFunction;
  CustomSpanTextVertical(
      {super.key, this.firstText, this.spanText, this.spanFunction});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          firstText!,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.grey,
          ),
        ),
        customSpaces.horizontalspace10,
        InkWell(
          onTap: spanFunction,
          child: Text(
            spanText!,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class CustomSpanText extends StatelessWidget {
  String? firstText;
  String? spanText;
  VoidCallback? spanFunction;
  CustomSpanText({super.key, this.firstText, this.spanText, this.spanFunction});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          firstText!,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.grey,
          ),
        ),
        customSpaces.horizontalspace10,
        InkWell(
          onTap: spanFunction,
          child: Text(
            spanText!,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
