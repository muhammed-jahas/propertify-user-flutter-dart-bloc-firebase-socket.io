import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:propertify/constants/colors/colors.dart';
import 'package:propertify/constants/icons/propertify_icons.dart';
import 'package:propertify/constants/spaces%20&%20paddings/paddings.dart';
import 'package:propertify/constants/spaces%20&%20paddings/spaces.dart';
import 'package:propertify/constants/text_styles/text_styles.dart';
import 'package:propertify/data/shared_preferences/shared_preferences.dart';
import 'package:propertify/views/presentation/profile_screen/app_info.dart';
import 'package:propertify/views/presentation/profile_screen/help_.dart';
import 'package:propertify/views/presentation/profile_screen/privacy&policy.dart';
import 'package:propertify/views/presentation/profile_screen/terms&conditions.dart';
import 'package:propertify/views/presentation/welcome_screen/welcome_screen.dart';

import '../../../blocs/login_bloc/login_bloc.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? userPhone;
  String? userEmail;
  String? userName;

  @override
  void initState() {
    super.initState();
    fetchuserData();
  }

  @override
  Widget build(BuildContext context) {
    fetchuserData();
    // ignore: unused_local_variable
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
              CircleAvatar(
                radius: 50,
                child: Text(
                  userName != null && userName!.isNotEmpty
                      ? userName![0].toUpperCase()
                      : 'N/A',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              customSpaces.verticalspace20,
              Text(
                userName ?? 'N\A',
                style: AppFonts.SecondaryColorText20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    userEmail ?? 'N\A',
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
          // Padding(
          //   padding: customPaddings.horizontalpadding20,
          //   child: ListTile(
          //     onTap: () {
          //       Navigator.of(context).push(MaterialPageRoute(
          //         builder: (context) => SettingsScreen(),
          //       ));
          //     },
          //     contentPadding: EdgeInsets.all(0),
          //     leading: Text(
          //       'Settings',
          //       style: AppFonts.SecondaryColorText20,
          //     ),
          //     trailing: Icon(
          //       PropertifyIcons.settings,
          //       color: AppColors.secondaryColor,
          //     ),
          //   ),
          // ),
          Padding(
            padding: customPaddings.horizontalpadding20,
            child: ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AppInfo(),
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

          Padding(
            padding: customPaddings.horizontalpadding20,
            child: ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => TermsConditions(),
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
                  builder: (context) => PrivacyPolicy(),
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
                  builder: (context) => HelpScreen(),
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
          // Padding(
          //   padding: customPaddings.horizontalpadding20,
          //   child: ListTile(
          //     onTap: () {
          //       Navigator.of(context).push(MaterialPageRoute(
          //         builder: (context) => SettingsScreen(),
          //       ));
          //     },
          //     contentPadding: EdgeInsets.all(0),
          //     leading: Text(
          //       'Clear App Data',
          //       style: AppFonts.SecondaryColorText20,
          //     ),
          //     trailing: Icon(
          //       PropertifyIcons.help,
          //       color: AppColors.secondaryColor,
          //     ),
          //   ),
          // ),
          Padding(
            padding: customPaddings.horizontalpadding20,
            child: ListTile(
              onTap: () async {
                await signOutUser();
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                  builder: (context) => WelcomeScreen(),
                ),
                (route) => false,
                );
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
    );
  }

  fetchuserData() async {
    final userPhonefetched = await SharedPref.instance.getUser();
    if (userPhonefetched != null) {
      setState(() {
        userPhone = userPhonefetched;
      });
    }

    final userEmailfetched = await SharedPref.instance.getUserEmail();
    if (userEmailfetched != null) {
      setState(() {
        userEmail = userEmailfetched;
      });
    }
    final userNamefetched = await SharedPref.instance.getUserName();
    if (userNamefetched != null) {
      setState(() {
        userName = userNamefetched;
      });
    }
  }

  signOutUser() async {
    await SharedPref.instance.sharedPref.remove(SharedPref.userPhone);
  }
}
