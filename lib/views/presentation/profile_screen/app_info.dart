import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:propertify/constants/spaces%20&%20paddings/paddings.dart';
import 'package:propertify/constants/spaces%20&%20paddings/spaces.dart';
import 'package:propertify/constants/text_styles/text_styles.dart';

class AppInfo extends StatelessWidget {
  const AppInfo({super.key});

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
                  "App Info",
                  style: AppFonts.SecondaryColorText28,
                ),
                customSpaces.verticalspace20,
                Divider(),
                customSpaces.verticalspace20,
                Text(
                  "About Propertify",
                  style: AppFonts.SecondaryColorText24,
                ),
                customSpaces.verticalspace20,
                Text(
                  "Welcome to Propertify, your go-to mobile application for effortless real estate property exploration and engagement. Dive into a world of diverse property listings sourced from various agents, offering you a seamless experience in finding your dream home or investment opportunity.",
                ),
                customSpaces.verticalspace20,
                Text(
                  "Features",
                  style: AppFonts.SecondaryColorText24,
                ),
                customSpaces.verticalspace20,
                Text(
                  "1. Comprehensive Property Listings",
                  style: AppFonts.SecondaryColorText16,
                ),
                customSpaces.verticalspace20,
                Text(
                  "Explore a vast array of properties listed by various agents, providing you with a diverse selection to suit your preferences and requirements.",
                ),
                customSpaces.verticalspace20,
                Text(
                  "2. Effortless Enquiries",
                  style: AppFonts.SecondaryColorText16,
                ),
                customSpaces.verticalspace20,
                Text(
                  "Connect with agents effortlessly by sending enquiry requests for each property that captures your interest. Experience a streamlined communication process to get all the information you need.",
                ),
                customSpaces.verticalspace20,
                Text(
                  "3. Instant Notifications",
                  style: AppFonts.SecondaryColorText16,
                ),
                customSpaces.verticalspace20,
                Text(
                  "Stay updated with agent responses through our intuitive notification screen. Receive timely information and updates regarding your property enquiries, ensuring you never miss a beat.",
                ),
                customSpaces.verticalspace20,
                Text(
                  "4. Secure Payments",
                  style: AppFonts.SecondaryColorText16,
                ),
                customSpaces.verticalspace20,
                Text(
                  "Seamlessly complete your property transactions using your preferred payment method. Propertify ensures a secure and hassle-free payment process for a smooth and convenient experience.",
                ),
                customSpaces.verticalspace20,
                Text(
                  "5. Intelligent Search Functionality",
                  style: AppFonts.SecondaryColorText16,
                ),
                customSpaces.verticalspace20,
                Text(
                  "Make use of our robust search functionality to refine your property search. Find the perfect match by customizing your search criteria, ensuring that you discover properties that align with your specific needs.",
                ),
                customSpaces.verticalspace20,
                Text(
                  "6. Categorized Views",
                  style: AppFonts.SecondaryColorText16,
                ),
                customSpaces.verticalspace20,
                Text(
                  "Navigate through the app effortlessly with categorized views. Whether you're interested in residential, commercial, or investment properties, our app provides organized and user-friendly views for a seamless browsing experience.",
                ),
                customSpaces.verticalspace20,
                Text(
                  "7. Property Location Services",
                  style: AppFonts.SecondaryColorText16,
                ),
                customSpaces.verticalspace20,
                Text(
                  "Easily locate the properties you are interested in using our integrated property location feature. Get a clear understanding of the surroundings and neighborhood, empowering you to make informed decisions.",
                ),
                customSpaces.verticalspace20,
                Text(
                  "Propertify is designed to redefine your real estate journey, offering a feature-rich platform that prioritizes user convenience and satisfaction. Download now and embark on a new era of property exploration!",
                  style: AppFonts.SecondaryColorText14,
                ),
                customSpaces.verticalspace20,
              ],
            ),
          ),
          Divider(),
          customSpaces.verticalspace20,
          Padding(
            padding: customPaddings.horizontalpadding20,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Version 1.0",
                  style: AppFonts.SecondaryColorText16,
                ),
                customSpaces.verticalspace20,
                Text(
                  "Made In India",
                  style: AppFonts.SecondaryColorText16,
                ),
                customSpaces.verticalspace10,
                Row(
                  children: [
                    Container(child: Flag(Flags.india)),
                    customSpaces.horizontalspace10,
                    Text(
                      "Propertify App is proudly made in India.",
                      style: AppFonts.SecondaryColorText16,
                    ),
                  ],
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
