import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:propertify/blocs/login_bloc/login_bloc.dart';
import 'package:propertify/resources/components/custom_toast.dart';
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
                  listener: (context, state) {
                    if (state is LoginFailureState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.message),
                          backgroundColor: Colors.red,
                        ),
                      );
                    } else if (state is LoginSuccessState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.message),
                          backgroundColor: Colors.green
                          
                          
                          ,
                        ),
                      );
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NavigationItems(),
                        ),
                        (route) => false,
                      );
                    } else if (state is ErrorState) {
                      showCustomToast(context, state.message, Colors.red);
                    }
                  },
                  builder: (context, state) {
                    if (state is LoginLoadingState) {
                      // Show loading indicator here if needed
                      return CircularProgressIndicator();
                    } else {
                      return PrimaryButton(
                        buttonText: 'Verify',
                        buttonFunction: () async {
                          await widget.loginBloc.signInWithOTP(
                              verificationId, otpController.text);
                          // Remove navigation logic from here
                        },
                      );
                    }
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
