import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:propertify/constants/colors/colors.dart';
import 'package:propertify/constants/icons/propertify_icons.dart';
import 'package:propertify/constants/spaces%20&%20paddings/paddings.dart';
import 'package:propertify/constants/spaces%20&%20paddings/spaces.dart';
import 'package:propertify/constants/text_styles/text_styles.dart';
import 'package:propertify/data/shared_preferences/shared_preferences.dart';
import 'package:propertify/views/presentation/settings_screen/settings_screen.dart';

import '../../../blocs/login_bloc/login_bloc.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? userPhone;

  @override
  void initState() {
    super.initState();
    fetchuserData();
  }

  @override
  Widget build(BuildContext context) {
    fetchuserData();
    final loginBloc = BlocProvider.of<LoginBloc>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Padding(
            padding: customPaddings.horizontalpadding20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customSpaces.verticalspace20,
                Text(
                  "Profile",
                  style: AppFonts.SecondaryColorText28,
                ),
              ],
            ),
          ),
          customSpaces.verticalspace20,
          Padding(
            padding: customPaddings.horizontalpadding20,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              CircleAvatar(radius: 50),
              customSpaces.verticalspace20,
              Text(
                userPhone ?? 'N\A',
                style: AppFonts.SecondaryColorText20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'davidjames@gmail.com',
                    style: AppFonts.greyText14,
                  ),
                  Text(
                    'Edit Profile',
                    style: AppFonts.PrimaryColorText14,
                  ),
                ],
              )
            ]),
          ),
          customSpaces.verticalspace20,
          Divider(),
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
                'Settings',
                style: AppFonts.SecondaryColorText20,
              ),
              trailing: Icon(
                PropertifyIcons.settings,
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
                'App Info',
                style: AppFonts.SecondaryColorText20,
              ),
              trailing: Icon(
                PropertifyIcons.info,
                color: AppColors.secondaryColor,
              ),
            ),
          ),
          Divider(),
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
                'Terms & Conditions',
                style: AppFonts.SecondaryColorText20,
              ),
              trailing: Icon(
                PropertifyIcons.conditions,
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
                'Privacy & Policy',
                style: AppFonts.SecondaryColorText20,
              ),
              trailing: Icon(
                PropertifyIcons.privacy,
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
                'Help',
                style: AppFonts.SecondaryColorText20,
              ),
              trailing: Icon(
                PropertifyIcons.help,
                color: AppColors.secondaryColor,
              ),
            ),
          ),
          Divider(),
        ],
      ),
    );
  }

  fetchuserData() async {
    final userPhonefetched = await SharedPref.instance.getUser();
    if (userPhonefetched != null) {
      setState(() {
        userPhone = userPhonefetched;
      });
    }
  }
}
