import 'package:flutter/material.dart';
import 'package:propertify/constants/spaces%20&%20paddings/paddings.dart';
import 'package:propertify/constants/spaces%20&%20paddings/spaces.dart';
import 'package:propertify/constants/text_styles/text_styles.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: customPaddings.horizontalpadding20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customSpaces.verticalspace20,
                Text(
                  "Help",
                  style: AppFonts.SecondaryColorText28,
                ),
                customSpaces.verticalspace20,
                Divider(),
              ],
            ),
          ),
          customSpaces.verticalspace20,
          Padding(
            padding: customPaddings.horizontalpadding20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Help",
                  style: AppFonts.SecondaryColorText24,
                ),
                SizedBox(height: 16),
                Text(
                  "Welcome to Propertify App Help Center! If you have any questions or need assistance, please refer to the information below:",
                ),
                SizedBox(height: 16),
                Text(
                  "Contact Information",
                  style: AppFonts.SecondaryColorText18,
                ),
                SizedBox(height: 16),
                Text(
                  "Phone Number: +919656462348",
                  style: AppFonts.SecondaryColorText14,
                ),
                Text(
                  "Email: propertifyapp@gmail.com",
                  style: AppFonts.SecondaryColorText14,
                ),
                Text(
                  "Location: Kozhikode, Kerala, Pin: 673001",
                  style: AppFonts.SecondaryColorText14,
                ),
                SizedBox(height: 16),
                Text(
                  "For any queries or assistance, please feel free to reach out to us using the provided contact information.",
                ),
                customSpaces.verticalspace20,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
