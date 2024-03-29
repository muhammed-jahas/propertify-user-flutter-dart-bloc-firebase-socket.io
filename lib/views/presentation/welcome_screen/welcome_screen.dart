import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:propertify/views/presentation/auth_screens/login_screen.dart';
import 'package:propertify/constants/colors/colors.dart';
import 'package:propertify/constants/spaces%20&%20paddings/paddings.dart';
import 'package:propertify/constants/spaces%20&%20paddings/spaces.dart';
import 'package:propertify/views/presentation/auth_screens/signup_screen.dart';
import 'package:propertify/widgets/buttons/custombuttons.dart';
import 'package:propertify/widgets/text_models/customSpanTextModels.dart';
import 'package:permission_handler/permission_handler.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: customPaddings.horizontalpadding20,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            customSpaces.verticalspace40,
            customSpaces.verticalspace40,
            Center(
              child: Hero(
                tag: 'herobg',
                child: Image(
                  image: AssetImage('assets/images/welcome-image.png'),
                  fit: BoxFit.cover,
                  height: 300,
                ),
              ),
            ),
            customSpaces.verticalspace20,
            Hero(
              tag: 'splashlogo',
              child: Image(
                image: AssetImage(
                  'assets/images/logo/propertify-logo-full.png',
                ),
                fit: BoxFit.cover,
                height: 60,
              ),
            ),
            customSpaces.verticalspace20,
            Text(
              'The perfect choice\nfor your stay',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w800,
                color: AppColors.secondaryColor,
              ),
            ),
            customSpaces.verticalspace20,

            // Container(
            //   child: Row(
            //     children: [
            //       customSpaces.horizontalspace10,
            //       Expanded(
            //         child: Container(
            //           height: 1,
            //           color: Colors.grey.shade300,
            //         ),
            //       ),
            //       Padding(
            //         padding: EdgeInsets.symmetric(horizontal: 20),
            //         child: Text(
            //           'OR',
            //           style: TextStyle(
            //               fontSize: 14,
            //               fontWeight: FontWeight.w500,
            //               color: Colors.grey.shade500),
            //         ),
            //       ),
            //       Expanded(
            //         child: Container(
            //           height: 1,
            //           color: Colors.grey.shade300,
            //         ),
            //       ),
            //       customSpaces.horizontalspace10,
            //     ],
            //   ),
            // ),
            // customSpaces.verticalspace20,
            // Row(
            //   children: [
            //     Expanded(
            //       child: SocialButton(
            //           buttonText: 'Login with Google',
            //           buttonIcon: 'assets/icons/google-icon.svg'),
            //     ),
            //     customSpaces.horizontalspace10,
            //     Expanded(
            //       child: SocialButton(
            //           buttonText: 'Login with Facebook',
            //           buttonIcon: 'assets/icons/facebook-icon.svg'),
            //     ),
            //   ],
            // ),
            customSpaces.verticalspace20,
            Column(
              children: [
                Hero(
                  tag: 'button',
                  child: PrimaryButtonwithIcon(
                    buttonText: 'Login with Phone Number',
                    buttonIcon: Icons.phone,
                    buttonFunction: () {
                      _requestPermission(context);
                    },
                  ),
                ),
                customSpaces.verticalspace40,
                CustomSpanText(
                  firstText: 'Don’t have an account ?',
                  spanText: 'Sign Up',
                  spanFunction: () {
                    _requestPermissionforsignup(context);
                    ;
                  },
                ),
              ],
            ),
            customSpaces.verticalspace40,
          ],
        ),
      ),
    );
  }

  Future<void> _requestPermission(BuildContext context) async {
    // Request necessary permissions
    var status = await Permission.location.request();
    var storageStatus = await Permission.storage.request();

    // Check if the permissions are granted
    if (status == PermissionStatus.granted) {
      // Permissions are granted, navigate to the login screen
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => LoginScreen()));
    } else {
      // Permissions are not granted, you can show a message or handle it accordingly
      // For simplicity, a SnackBar is shown here
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text('Permissions not granted. Please enable them in settings.'),
        ),
      );
    }
  }

  Future<void> _requestPermissionforsignup(BuildContext context) async {
    // Request necessary permissions
    var status = await Permission.location.request();
    var storageStatus = await Permission.storage.request();

    // Check if the permissions are granted
    if (status == PermissionStatus.granted &&
        storageStatus == PermissionStatus.granted) {
      // Permissions are granted, navigate to the login screen
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => SignUpScreen()));
    } else {
      // Permissions are not granted, you can show a message or handle it accordingly
      // For simplicity, a SnackBar is shown here
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text('Permissions not granted. Please enable them in settings.'),
        ),
      );
    }
  }
}
