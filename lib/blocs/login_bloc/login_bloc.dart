import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:propertify/blocs/payment_bloc/payment_bloc.dart';
import 'package:propertify/repositories/login_repo/login_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:propertify/repositories/signup_repo/signup_repo.dart';
import 'package:propertify/resources/components/custom_toast.dart';
import 'package:propertify/utils/utils.dart';

import '../../data/shared_preferences/shared_preferences.dart';
import '../../models/user_model.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  //Initializations
  final _auth = FirebaseAuth.instance;
  //Firebase Verification Id
  String verificationId = "";
  String phoneNumber = "";
  UserModel? user;

  bool isUser = false;

  LoginBloc() : super(InitialState()) {
    on<LoginUserEvent>(loginUserEvent);
    on<SignUpUserEvent>(signupUserEvent);
  }

  FutureOr<void> checkingUserEvent(event, emit) => null;

  FutureOr<void> signupUserEvent(
      SignUpUserEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoadingState());
    final formattedNumber =
        '+' + Utils.formatPhoneNumber(event.user.usermobNo!);

    final either = await SignupRepo().signupUser(event.user.toJson());
    either.fold((error) => {emit(ErrorState(message: error.message))},
        (response) {
      if (response['status'] == 'success') {
        isUser = false;
        phoneNumber = formattedNumber;
        sendOtp(formattedNumber);
        emit(LoginSuccessState(message: response['message']));
      } else {
        emit(LoginFailureState(message: response['message']));
      }
    });
  }

  FutureOr<void> loginUserEvent(
      LoginUserEvent event, Emitter<LoginState> emit) async {
    final userData = {'usermobNo': '+91${event.userPhone}'};
    emit(LoginLoadingState());
    final either = await LoginRepo().loginUser(userData);
    await Future.delayed(Duration(seconds: 10));

    final formattedNumber = '+91' + Utils.formatPhoneNumber(event.userPhone);
    phoneNumber = formattedNumber;
    print('phone:$phoneNumber');
    either.fold((error) => emit(ErrorState(message: error.message)),
        (response) {
      if (response['status'] == 'success') {
        isUser = true;
        sendOtp(formattedNumber);

        emit(LoginSuccessState(message: response['message']));
      } else {
        emit(LoginFailureState(message: response['message']));
      }
    });
  }

  phoneNumberValidation(BuildContext context, String phoneNumber) {
    if (phoneNumber.trim().isEmpty || phoneNumber.isEmpty) {
      return showCustomToast(context, 'Please Enter Your Phone Number');
    } else if (phoneNumber.trim().length != 10) {
      return showCustomToast(context, 'Please Enter Correct Phone Number');
    } else {
      loginUser(context, phoneNumber);
    }
  }

  loginUser(BuildContext context, String PhoneNumber) {
    // loginBloc.add(LoginUserEvent(userPhone: phoneNumberController.text));
    final userPhone = PhoneNumber;
    context.read<LoginBloc>().add(LoginUserEvent(userPhone: userPhone));
  }

  sendOtp(String formattedNumber) async {
    print('Sending Otp');
    await _auth.verifyPhoneNumber(
        phoneNumber: formattedNumber,
        timeout: Duration(seconds: 10),
        verificationCompleted: (PhoneAuthCredential credential) async {
          UserCredential userCredential =
              await _auth.signInWithCredential(credential);
          if (kDebugMode) {
            print("User Signed in:${userCredential.user?.phoneNumber}");
          }
          ;
          // Get.toNamed('otp_verification', arguments: verificationId);
        },
        verificationFailed: (FirebaseAuthException e) {
          print("Verification failed: ${e.message}");
        },
        codeSent: (String verificationIdNew, int? resendToken) {
          verificationId = verificationIdNew;
          // Get.toNamed('otp_verification', arguments: verificationId);
        },
        codeAutoRetrievalTimeout: (String verificationIdNew) {
          verificationId = verificationIdNew;
        });
  }

  signInWithOTP(String verificationId, String otp) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      );

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      final firebaseId = userCredential.user?.uid;
      print(firebaseId);

      String? userPhone = userCredential.user?.phoneNumber.toString();
      print(userPhone);

      //User Login or Signup Check

      print("User signed in: ${userCredential.user?.phoneNumber}");
    } catch (e) {
      print("Error: $e");
    }
    isUser
        ? await loginfinal(verificationId, phoneNumber)
        : await signupFinal(verificationId, phoneNumber);
  }

  storeUserData(UserModel user, String FirebaseId) async {
    print('In STORE Data');
    await SharedPref.instance.sharedPref
        .setString(SharedPref.FirebaseId, FirebaseId);
    await SharedPref.instance.sharedPref.setString(SharedPref.userId, user.id!);
    await SharedPref.instance.sharedPref
        .setString(SharedPref.userName, user.username!);
    await SharedPref.instance.sharedPref
        .setString(SharedPref.userPhone, user.usermobNo!);
    await SharedPref.instance.sharedPref
        .setString(SharedPref.userEmail, user.useremail!);
  }

  loginfinal(String firebaseId, String userPhone) async {
    print('IN LOGIN FINAL');
    final userData = {"usermobNo": "$userPhone"};
    final either = await LoginRepo().loginUser(userData);
    either.fold((error) => {}, (response) {
      if (response['status'] == 'success') {
        user = UserModel.fromJson(response['user']);
        print(user!.toJson());
      }
    });
    await storeUserData(user!, firebaseId);
    print('DDDDDDDDDDDDDDD');
  }

  signupFinal(String firebaseId, String userPhone) async {
    final userData = {"usermobNo": "$userPhone"};
    final either = await LoginRepo().loginUser(userData);
    either.fold((error) => {}, (response) {
      if (response['status'] == 'success') {
        user = UserModel.fromJson(response['user']);
        print(user!.toJson());
        storeUserData(user!, firebaseId);
      }
    });
  }

  signupValidation({
    required BuildContext context,
    required String phoneNumber,
    required String userName,
    required String password,
    required String userEmail,
  }) async {
    final UserModel user = UserModel(
      username: userName,
      usermobNo: phoneNumber,
      userpassword: password,
      useremail: userEmail,
      isLogin: true,
    );
    context.read<LoginBloc>().add(SignUpUserEvent(user: user));
  }
}
