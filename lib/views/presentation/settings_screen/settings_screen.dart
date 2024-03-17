import 'package:flutter/material.dart';
import 'package:propertify/constants/colors/colors.dart';
import 'package:propertify/constants/icons/propertify_icons.dart';
import 'package:propertify/constants/spaces%20&%20paddings/paddings.dart';
import 'package:propertify/constants/spaces%20&%20paddings/spaces.dart';
import 'package:propertify/constants/text_styles/text_styles.dart';
import 'package:propertify/widgets/iconbox/customIconBox.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customSpaces.verticalspace20,
            Padding(
              padding: customPaddings.horizontalpadding20,
              child: Row(
                children: [
                  CustomIconBox(
                      boxheight: 40,
                      boxwidth: 40,
                      boxIcon: Icons.arrow_back,
                      radius: 8,
                      boxColor: Colors.grey.shade300,
                      iconSize: 20),
                  customSpaces.horizontalspace20,
                  Text(
                    "Settings",
                    style: AppFonts.SecondaryColorText20,
                  ),
                ],
              ),
            ),
            customSpaces.verticalspace20,
            Padding(
              padding: customPaddings.horizontalpadding20,
              child: ListTile(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SettingsScreen(),
                  ));
                },
                contentPadding: EdgeInsets.all(0),
                leading: Text(
                  'Dark Mode',
                  style: AppFonts.SecondaryColorText20,
                ),
                trailing: Icon(
                  PropertifyIcons.toggle,
                  color: AppColors.secondaryColor,
                ),
              ),
            ),
            Padding(
              padding: customPaddings.horizontalpadding20,
              child: ListTile(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SettingsScreen(),
                  ));
                },
                contentPadding: EdgeInsets.all(0),
                leading: Text(
                  'Clear App Data',
                  style: AppFonts.SecondaryColorText20,
                ),
                trailing: Icon(
                  PropertifyIcons.delete,
                  color: AppColors.secondaryColor,
                ),
              ),
            ),
            Padding(
              padding: customPaddings.horizontalpadding20,
              child: ListTile(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SettingsScreen(),
                  ));
                },
                contentPadding: EdgeInsets.all(0),
                leading: Text(
                  'Sign Out',
                  style: AppFonts.RedColorText20,
                ),
                trailing: Icon(
                  PropertifyIcons.logout,
                  color: AppColors.alertColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
