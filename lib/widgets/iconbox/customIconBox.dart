import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomIconBox extends StatelessWidget {
  double? boxheight;
  double? boxwidth;
  double? iconSize;
  IconData? boxIcon;
  double? radius;
  Color? boxColor;
  Color? IconColor;
  VoidCallback? iconFunction;
  CustomIconBox({
    super.key,
    this.boxheight,
    this.boxwidth,
    this.boxIcon,
    this.radius,
    this.boxColor,
    this.iconSize,
    this.IconColor,
    this.iconFunction,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: iconFunction,
      child: Container(
        decoration: BoxDecoration(
          color: boxColor,
          borderRadius: BorderRadius.circular(radius!),
        ),
        height: boxheight,
        width: boxwidth,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            boxIcon,
            size: iconSize,
            color: IconColor,
          ),
        ),
      ),
    );
  }
}
