import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:propertify/blocs/login_bloc/login_bloc.dart';
import 'package:propertify/views/presentation/navigation/navigation.dart';
import 'package:propertify/constants/colors/colors.dart';
import 'package:propertify/constants/spaces%20&%20paddings/paddings.dart';
import 'package:propertify/constants/spaces%20&%20paddings/spaces.dart';
import 'package:propertify/views/presentation/auth_screens/signup_screen.dart';
import 'package:propertify/widgets/buttons/custombuttons.dart';
import 'package:propertify/widgets/iconbox/customIconBox.dart';
import 'package:propertify/widgets/input_fileds/customInputFields.dart';
import 'package:propertify/widgets/text_models/customSpanTextModels.dart';

class OtpVerification extends StatefulWidget {
 final LoginBloc loginBloc;

  OtpVerification({Key? key, required this.loginBloc}) : super(key: key);

  @override
  State<OtpVerification> createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  final otpController = TextEditingController();

  final loginKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final verificationId = context.read<LoginBloc>().verificationId;
    final phoneNumber = context.read<LoginBloc>().phoneNumber;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: customPaddings.horizontalpadding20,
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customSpaces.verticalspace40,
                CustomIconBox(
                    boxheight: 50,
                    boxwidth: 50,
                    boxIcon: Icons.arrow_back,
                    radius: 8,
                    boxColor: Colors.grey.shade300,
                    iconSize: 24),
                customSpaces.verticalspace20,
                Text(
                  "Verification Code",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: AppColors.secondaryColor,
                  ),
                ),
                Text(
                  "We have sent the verification code to\n$phoneNumber",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade400,
                    height: 1.5,
                  ),
                ),
                customSpaces.verticalspace20,
                CustomInputField(
                  fieldIcon: Icons.abc,
                  controller: otpController,
                  hintText: 'Enter OTP',
                  keyboardType: TextInputType.number,
                ),
                customSpaces.verticalspace20,
                BlocConsumer<LoginBloc, LoginState>(
                  // bloc: loginBloc,
                  listener: (context, state) {},
                  builder: (context, state) {
                    return PrimaryButton(
                      buttonText: 'Verify',
                      buttonFunction: () {
                        widget.loginBloc.signInWithOTP(verificationId, otpController.text);
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NavigationItems(),
                            ),
                            (route) => false,
                          );
                      },
                    );
                  },
                ),
                customSpaces.verticalspace20,
                CustomSpanText(
                  firstText: "Didn’t receive any code ?",
                  spanText: 'Resend Code',
                  spanFunction: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => SignUpScreen(),
                      ),
                    );
                  },
                ),
                customSpaces.verticalspace40,
              ],
            ),
          ],
        ),
      ),
    );
  }

  //Sign in using OTP
  
}
