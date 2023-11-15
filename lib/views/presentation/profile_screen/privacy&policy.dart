import 'package:flutter/material.dart';
import 'package:propertify/constants/spaces%20&%20paddings/paddings.dart';
import 'package:propertify/constants/spaces%20&%20paddings/spaces.dart';
import 'package:propertify/constants/text_styles/text_styles.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

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
                  "Privacy & Policy",
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
                  "Privacy & Policy",
                  style: AppFonts.SecondaryColorText24,
                ),
                SizedBox(height: 16),
                Text(
                  "Welcome to Propertify App! This Privacy Policy governs how Propertify App collects, uses, and protects your personal information. By using Propertify App, you agree to the practices described in this policy.",
                ),
                SizedBox(height: 16),
                Text(
                  "Information We Collect",
                  style: AppFonts.SecondaryColorText18,
                ),
                SizedBox(height: 16),
                Text(
                  "Propertify App collects user information during login or registration, including mobile number, email, and name. This information is securely stored on our servers.",
                ),
                SizedBox(height: 16),
                Text(
                  "Third-Party Services",
                  style: AppFonts.SecondaryColorText18,
                ),
                SizedBox(height: 16),
                Text(
                  "Map Directions: In the property view screen, navigation to map directions uses a third-party app, Google Maps.",
                ),
                SizedBox(height: 16),
                Text(
                  "Call Dial Option",
                  style: AppFonts.SecondaryColorText18,
                ),
                SizedBox(height: 16),
                Text(
                  "For calling the agent in trip details, a call dial option is provided. This action redirects to the phone dialer of the mobile device.",
                ),
                SizedBox(height: 16),
                Text(
                  "Firebase OTP Verification",
                  style: AppFonts.SecondaryColorText18,
                ),
                SizedBox(height: 16),
                Text(
                  "We use Firebase OTP verification for sign-in and registration processes to enhance security.",
                ),
                SizedBox(height: 16),
                Text(
                  "Changes to This Policy",
                  style: AppFonts.SecondaryColorText18,
                ),
                SizedBox(height: 16),
                Text(
                  "We may update this Privacy Policy periodically to reflect changes in our practices. Please review this policy for any updates. By continuing to use Propertify App after changes, you accept the updated Privacy Policy.",
                ),
                SizedBox(height: 16),
                Text(
                  "Contact Us",
                  style: AppFonts.SecondaryColorText18,
                ),
                SizedBox(height: 16),
                Text(
                  "If you have any questions, concerns, or requests regarding this Privacy Policy, please contact us at [your contact email]. We are here to assist you with any privacy-related inquiries.",
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
