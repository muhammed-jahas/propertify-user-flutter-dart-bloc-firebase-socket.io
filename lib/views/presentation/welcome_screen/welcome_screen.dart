import 'package:flutter/material.dart';
import 'package:propertify/views/presentation/auth_screens/login_screen.dart';
import 'package:propertify/constants/colors/colors.dart';
import 'package:propertify/constants/spaces%20&%20paddings/paddings.dart';
import 'package:propertify/constants/spaces%20&%20paddings/spaces.dart';
import 'package:propertify/views/presentation/auth_screens/signup_screen.dart';
import 'package:propertify/widgets/buttons/custombuttons.dart';
import 'package:propertify/widgets/text_models/customSpanTextModels.dart';

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
              child: Image(
                image: AssetImage('assets/images/welcome-image.png'),
                fit: BoxFit.cover,
                height: 300,
              ),
            ),
            customSpaces.verticalspace20,
            Text(
              'The perfect choice for\nyour stay',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w800,
                color: AppColors.secondaryColor,
              ),
            ),
            customSpaces.verticalspace20,
            PrimaryButtonwithIcon(buttonText: 'Login with Phone Number',buttonIcon: Icons.phone,buttonFunction: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen(),));
            },),
            customSpaces.verticalspace20,
            Container(
              child: Row(
                children: [
                  customSpaces.horizontalspace10,
                  Expanded(
                    child: Container(
                      height: 1,
                      color: Colors.grey.shade300,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'OR',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.shade500),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 1,
                      color: Colors.grey.shade300,
                    ),
                  ),
                  customSpaces.horizontalspace10,
                ],
              ),
            ),
            customSpaces.verticalspace20,
            Row(
              children: [
                Expanded(
                  child: SocialButton(
                      buttonText: 'Login with Google',
                      buttonIcon: 'assets/icons/google-icon.svg'),
                ),
                customSpaces.horizontalspace10,
                Expanded(
                  child: SocialButton(
                      buttonText: 'Login with Facebook',
                      buttonIcon: 'assets/icons/facebook-icon.svg'),
                ),
              ],
            ),
            customSpaces.verticalspace20,
            CustomSpanText(
              firstText: 'Don’t have an account ?',
              spanText: 'Sign Up',
              spanFunction: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SignUpScreen(),
                  ),
                  
                );
              },
            ),
            customSpaces.verticalspace40,
          ],
        ),
      ),
    );
  }
}




