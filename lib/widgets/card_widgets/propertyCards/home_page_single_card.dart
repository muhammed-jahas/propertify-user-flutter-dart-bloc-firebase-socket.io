import 'package:flutter/material.dart';
import 'package:propertify/constants/colors/colors.dart';
import 'package:propertify/constants/icons/propertify_icons.dart';
import 'package:propertify/constants/spaces%20&%20paddings/paddings.dart';
import 'package:propertify/constants/spaces%20&%20paddings/spaces.dart';
import 'package:propertify/constants/text_styles/text_styles.dart';
import '../../../models/property_model.dart';
import '../../../views/presentation/properties_details_screen/property_details_screen.dart';

// ignore: must_be_immutable
class HomePageCardSingle extends StatelessWidget {
  double? cardWidth;
  double? cardHeight;
  PropertyModel? property;
  HomePageCardSingle({
    Key? key,
    this.cardWidth,
    this.cardHeight,
    this.property,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => PropertyDetailsScreen(
                  property: property!,
                )));
      },
      child: Container(
        width: cardWidth,
        padding: EdgeInsets.all(0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade200),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: property?.propertyCoverPicture?.path != null
                      ? Image.network(
                          '${property!.propertyCoverPicture!.path}',
                          height: cardHeight ?? 110,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        )
                      : Placeholder(), // Show a Placeholder widget or some other fallback
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.secondaryColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    padding: customPaddings.fullpadding6,
                    child: Text(
                      '₹ ${property?.propertyPrice ?? 'N/A'}',
                      style: AppFonts.WhiteColorText14,
                    ),
                  ),
                ),
              ],
            ),
            customSpaces.verticalspace10,
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      customSpaces.horizontalspace10,
                      Text(
                        property?.propertyName ?? '',
                        style: AppFonts.SecondaryColorText14,
                      ),
                    ],
                  ),
                  customSpaces.verticalspace5,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      customSpaces.horizontalspace10,
                      Text(
                        property?.propertyCategory ?? '',
                        style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 10,
                            fontWeight: FontWeight.w600),
                      ),
                      customSpaces.horizontalspace5,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            PropertifyIcons.location,
                            color: Colors.grey,
                            size: 12,
                          ),
                          customSpaces.horizontalspace5,
                          Text(
                            property?.propertyCity ?? '',
                            style: AppFonts.greyText12,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class borderBoxIconandText extends StatelessWidget {
  final IconData? boxIcon;
  final String? boxText;
  final ImageProvider?
      backgroundImage; // Add a parameter for the background image

  borderBoxIconandText({
    Key? key,
    this.boxIcon,
    this.boxText,
    this.backgroundImage, // Include the background image parameter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        // image: DecorationImage(
        //   image: backgroundImage ??
        //       AssetImage(
        //           'assets/images/propertify-123.jpg'), // Use provided image or a default image
        //   fit: BoxFit.cover, // You can adjust the fit as needed
        // ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 25),
        child: Column(
          children: [
            Icon(
              boxIcon,
              size: 25,
            ),
            SizedBox(height: 10), // Use SizedBox for spacing
            Text(
              boxText!,
              style: AppFonts.SecondaryColorText16,
            ),
          ],
        ),
      ),
    );
  }
}
