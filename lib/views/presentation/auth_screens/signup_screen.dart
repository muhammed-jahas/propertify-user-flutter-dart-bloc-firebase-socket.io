import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:propertify/blocs/login_bloc/login_bloc.dart';
import 'package:propertify/constants/colors/colors.dart';
import 'package:propertify/constants/spaces%20&%20paddings/paddings.dart';
import 'package:propertify/constants/spaces%20&%20paddings/spaces.dart';
import 'package:propertify/resources/components/custom_toast.dart';
import 'package:propertify/views/presentation/auth_screens/login_screen.dart';
import 'package:propertify/views/presentation/auth_screens/otp_verification.dart';
import 'package:propertify/views/presentation/profile_screen/terms&conditions.dart';
import 'package:propertify/widgets/buttons/custombuttons.dart';
import 'package:propertify/widgets/input_fileds/customInputFields.dart';
import 'package:propertify/widgets/text_models/customSpanTextModels.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final phoneNumberController = TextEditingController();
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final userEmailController = TextEditingController();
  final GlobalKey<FormState> signupKey = GlobalKey<FormState>();

  bool agreementAccepted = false; // Tracks the state of the agreement checkbox

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: customPaddings.horizontalpadding20,
          child: Form(
            key: signupKey,
            child: ListView(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    customSpaces.verticalspace20,
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
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
                    ),
                    customSpaces.verticalspace20,
                    Text(
                      'Get Started!',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        color: AppColors.secondaryColor,
                      ),
                    ),
                    Text(
                      'Create an account to continue.',
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
                    CustomInputField(
                      fieldIcon: Icons.lock_outline,
                      hintText: 'Enter your prefered username',
                      controller: userNameController,
                      validator: (value) {
                        final error = _validateUserName(value!);
                        return error;
                      },
                    ),
                    customSpaces.verticalspace20,
                    CustomInputField(
                      fieldIcon: Icons.lock_outline,
                      hintText: 'Enter your password',
                      controller: passwordController,
                      validator: (value) {
                        final error = _validatePassword(value!);
                        return error;
                      },
                    ),
                    customSpaces.verticalspace20,
                    CustomInputField(
                      
                      fieldIcon: Icons.lock_outline,
                      hintText: 'Confirm password',
                      controller: confirmPasswordController,
                      validator: (value) {
                        final error = _validateConfirmPassword(
                            value!, passwordController.text);
                        return error;
                      },
                    ),
                    customSpaces.verticalspace20,
                    CustomInputField(
                      fieldIcon: Icons.lock_outline,
                      hintText: 'Enter your Email',
                      controller: userEmailController,
                      validator: (value) {
                        final error = _validateEmail(value!);
                        return error;
                      },
                    ),
                    customSpaces.verticalspace20,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Checkbox(
                          value: agreementAccepted,
                          onChanged: (value) {
                            setState(() {
                              agreementAccepted = value!;
                            });
                          },
                        ),
                        customSpaces.horizontalspace5,
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => TermsConditions(),
                            ));
                          },
                          child: CustomSpanTextVertical(
                            firstText:
                                'By creating an account, you agree to our',
                            spanText: 'Terms and Conditions',
                          ),
                        )
                      ],
                    ),
                    customSpaces.verticalspace20,
                    BlocConsumer<LoginBloc, LoginState>(
                      listener: (context, state) {
                        if (state is LoginSuccessState) {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => OtpVerification(
                              loginBloc: context.read<LoginBloc>(),
                            ),
                          ));

                          showCustomToast(context, 'Otp has Sent Successfully');
                        } else if (state is LoginFailureState) {
                          showCustomToast(
                              context, state.message, AppColors.alertColor);
                        } else if (state is ErrorState) {
                          showCustomToast(
                              context, state.message, AppColors.alertColor);
                        }
                      },
                      builder: (context, state) {
                        bool isLoading =
                            state is LoginLoadingState ? true : false;
                        return LoadingButton(
                          isLoading: isLoading,
                          buttonText: 'Submit',
                          buttonFunction: () async {
                            _validatePhoneNumber(
                                phoneNumberController.text, context);
                            if (signupKey.currentState!.validate()) {
                              final phoneNumber =
                                  '+91' + phoneNumberController.text;
                              final userName = userNameController.text;
                              final password = passwordController.text;
                              // ignore: unused_local_variable
                              final confirmPassword =
                                  confirmPasswordController.text;
                              final userEmail = userEmailController.text;

                              print('All fields are valid');

                              if (!agreementAccepted) {
                                showCustomToast(
                                    context,
                                    'Please Accept Our Terms and Conditions',
                                    Colors.red);
                                return;
                              }

                              await context.read<LoginBloc>().signupValidation(
                                    context: context,
                                    phoneNumber: phoneNumber,
                                    userName: userName,
                                    password: password,
                                    userEmail: userEmail,
                                  );
                            }
                          },
                        );
                      },
                    ),
                    customSpaces.verticalspace20,
                    CustomSpanText(
                      firstText: 'Already have an account ?',
                      spanText: 'Login',
                      spanFunction: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ));
                      },
                    ),
                    customSpaces.verticalspace40,
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _validatePhoneNumber(String phoneNumber, BuildContext context) {
    if (phoneNumber.trim().isEmpty || phoneNumber.isEmpty) {
      return showCustomToast(
          context, 'Please Enter Your Phone Number', AppColors.alertColor);
    } else if (phoneNumber.trim().length != 10) {
      return showCustomToast(
          context, 'Please Enter Correct Phone Number', AppColors.alertColor);
    }
  }

  _validateUserName(String value) {
    if (value.isEmpty || value.trim().isEmpty) {
      return 'Please enter your username';
    }
    return null;
  }

  _validatePassword(String value) {
    if (value.isEmpty || value.trim().isEmpty) {
      return 'Please enter your password';
    } else if (value.length < 8) {
      return 'Password should be atleast 8 characters';
    }
    return null;
  }

  _validateConfirmPassword(String value, String password) {
    if (value.isEmpty || value.trim().isEmpty) {
      return 'Please confirm your password';
    } else if (value.length < 8) {
      return 'Password should be atleast 8 characters';
    } else if (value != password) {
      return 'Passwords do not match';
    }
    return null;
  }

  _validateEmail(String value) {
    // Regular expression pattern for a valid email address
    final emailPattern = r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$';
    final regExp = RegExp(emailPattern);

    if (value.isEmpty || value.trim().isEmpty) {
      return 'Please enter your email';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter a valid email address';
    }

    return null;
  }
}
