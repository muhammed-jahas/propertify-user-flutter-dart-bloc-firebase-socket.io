import 'package:flutter/material.dart';
import 'package:propertify/constants/spaces%20&%20paddings/paddings.dart';
import 'package:propertify/constants/spaces%20&%20paddings/spaces.dart';
import 'package:propertify/constants/text_styles/text_styles.dart';

class TermsConditions extends StatelessWidget {
  const TermsConditions({super.key});

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
                  "Terms & Conditions",
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
                  "Terms & Conditions",
                  style: AppFonts.SecondaryColorText24,
                ),
                SizedBox(height: 16),
                Text(
                  "Welcome to Propertify App! These Terms and Conditions govern your use of our Propertify App mobile application. By accessing or using Propertify App, you agree to be bound by these terms and conditions. If you do not agree with any part of these terms, please do not use Propertify App.",
                ),
                SizedBox(height: 16),
                Text(
                  "License and Propertify App Usage",
                  style: AppFonts.SecondaryColorText18,
                ),
                SizedBox(height: 16),
                Text(
                  "We grant you a non-exclusive, non-transferable, revocable license to use Propertify App for personal, non-commercial purposes. You may not sublicense, distribute, or modify Propertify App without our prior written consent.",
                ),
                SizedBox(height: 16),
                Text(
                  "User Conduct",
                  style: AppFonts.SecondaryColorText18,
                ),
                SizedBox(height: 16),
                Text(
                  "You agree not to use Propertify App for any unlawful or unauthorized purposes. You will comply with all applicable laws and regulations while using Propertify App.",
                ),
                SizedBox(height: 16),
                Text(
                  "Intellectual Property Rights",
                  style: AppFonts.SecondaryColorText18,
                ),
                SizedBox(height: 16),
                Text(
                  "All intellectual property rights in Propertify App, including but not limited to copyrights, trademarks, and trade secrets, are owned by us or our licensors. You may not copy, reproduce, or modify any part of Propertify App without our prior written consent.",
                ),
                SizedBox(height: 16),
                Text(
                  "Disclaimer of Warranties",
                  style: AppFonts.SecondaryColorText18,
                ),
                SizedBox(height: 16),
                Text(
                  "Propertify App is provided on an \"as is\" and \"as available\" basis. We make no warranties or representations of any kind, whether express or implied, regarding Propertify App's accuracy, reliability, or suitability for your purposes.",
                ),
                SizedBox(height: 16),
                Text(
                  "Limitation of Liability",
                  style: AppFonts.SecondaryColorText18,
                ),
                SizedBox(height: 16),
                Text(
                  "To the extent permitted by law, we shall not be liable for any indirect, incidental, special, or consequential damages arising out of or in connection with the use of Propertify App or these Terms and Conditions.",
                ),
                SizedBox(height: 16),
                Text(
                  "Indemnification",
                  style: AppFonts.SecondaryColorText18,
                ),
                SizedBox(height: 16),
                Text(
                  "You agree to indemnify and hold us harmless from any claims, damages, liabilities, or expenses arising out of your use of Propertify App or violation of these Terms and Conditions.",
                ),
                SizedBox(height: 16),
                Text(
                  "Governing Law and Jurisdiction",
                  style: AppFonts.SecondaryColorText18,
                ),
                SizedBox(height: 16),
                Text(
                  "These Terms and Conditions are governed by and construed in accordance with the laws of India. Any disputes arising out of or in connection with these terms shall be subject to the exclusive jurisdiction of the courts in India.",
                ),
                SizedBox(height: 16),
                Text(
                  "Changes to These Terms and Conditions",
                  style: AppFonts.SecondaryColorText18,
                ),
                SizedBox(height: 16),
                Text(
                  "We reserve the right to update or modify these Terms and Conditions at any time without prior notice. The revised version will be effective when it is posted in Propertify App.",
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
