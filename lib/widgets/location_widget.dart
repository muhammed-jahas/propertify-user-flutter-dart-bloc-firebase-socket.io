
import 'package:flutter/material.dart';
import 'package:propertify/constants/colors/colors.dart';
import 'package:propertify/constants/icons/propertify_icons.dart';
import 'package:propertify/constants/spaces%20&%20paddings/spaces.dart';
import 'package:propertify/constants/text_styles/text_styles.dart';

class locationWidget extends StatelessWidget {
  const locationWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'Location',
                    style: AppFonts.SecondaryColorText14,
                    
                  ),
                  customSpaces.horizontalspace5,
                  Icon(
                    Icons.keyboard_arrow_down_outlined,
                    color: AppColors.secondaryColor,
                    size: 16,
                  )
                ],
              ),
            ],
          ),
        ),
        customSpaces.verticalspace5,
        Container(
          // color: Colors.red,
          // height: 30,
          // width: 200,
          child: Column(
            children: [
              Row(
                children: [
                  Icon(
                    PropertifyIcons.location,
                    color: AppColors.secondaryColor,
                    size: 22,
                  ),
                  customSpaces.horizontalspace5,
                  Text(
                    'Search by location',
                    style: AppFonts.greyText14,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
