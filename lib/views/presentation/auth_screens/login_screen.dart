import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:propertify/blocs/login_bloc/login_bloc.dart';
import 'package:propertify/resources/components/custom_toast.dart';
import 'package:propertify/views/presentation/auth_screens/otp_verification.dart';
import 'package:propertify/constants/colors/colors.dart';
import 'package:propertify/constants/spaces%20&%20paddings/paddings.dart';
import 'package:propertify/constants/spaces%20&%20paddings/spaces.dart';
import 'package:propertify/views/presentation/auth_screens/signup_screen.dart';
import 'package:propertify/widgets/buttons/custombuttons.dart';
import 'package:propertify/widgets/input_fileds/customInputFields.dart';
import 'package:propertify/widgets/text_models/customSpanTextModels.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //Initializations
  final phoneNumberController = TextEditingController();

  final loginKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
                customSpaces.verticalspace40,
                Center(
                  child: Image(
                    image: AssetImage('assets/images/welcome-image.png'),
                    fit: BoxFit.cover,
                    height: 300,
                  ),
                ),
                customSpaces.verticalspace20,
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: 50,
                  width: 50,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.arrow_back,
                      size: 24,
                    ),
                  ),
                ),
                customSpaces.verticalspace20,
                Text(
                  "Let's sign you in",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: AppColors.secondaryColor,
                  ),
                ),
                Text(
                  "Welcome Back, You've been missed!",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade400,
                  ),
                ),
                customSpaces.verticalspace20,
                MobileInputField(
                  controller: phoneNumberController,
                ),
                customSpaces.verticalspace20,
                BlocConsumer<LoginBloc, LoginState>(
                  listener: (context, state) {
                    if (state is LoginSuccessState) {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => OtpVerification(
                            loginBloc: context.read<LoginBloc>()),
                      ));
                      showCustomToast(context, 'Otp has Sent Successfully');
                    } else if (state is LoginFailureState) {
                      showCustomToast(context, state.message);
                    } else if (state is ErrorState) {
                      showCustomToast(context, state.message);
                    }
                  },
                  builder: (context, state) {
                    bool isLoading = state is LoginLoadingState ? true : false;
                    return LoadingButton(
                      isLoading: isLoading,
                      buttonText: 'Send OTP',
                      buttonFunction: () async {
                        await context.read<LoginBloc>().phoneNumberValidation(
                            context, phoneNumberController.text);
                      },
                    );
                  },
                ),
                customSpaces.verticalspace20,
                CustomSpanText(
                  firstText: 'Don’t have an account ?',
                  spanText: 'Sign Up',
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
}
