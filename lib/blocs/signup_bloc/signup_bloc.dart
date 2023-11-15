import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:propertify/models/user_model.dart';
import 'package:propertify/repositories/signup_repo/signup_repo.dart';
import 'package:propertify/utils/utils.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {


  // Initializations
  final _auth = FirebaseAuth.instance ;
  String verificationId = '';
  String phoneNumber = "" ;
  UserModel? user;

  SignupBloc() : super(SignupInitial()) {
    on<SignupUserEvent>(signupUserEvent);
  }

  FutureOr<void> signupUserEvent(SignupUserEvent event,Emitter<SignupState> emit) async {

    final userData = {'usermobNo': '+91${event.user.usermobNo}'};

    final formattedNumber = '+91'+Utils.formatPhoneNumber(event.user.usermobNo!);
    
    emit(SignupLoadingState());
    final either = await SignupRepo().signupUserCheck(userData);

    await Future.delayed(Duration(seconds: 2));
    either.fold((error) => emit(SignupErrorState(message: error.message)),
    (response){
     if(response['status']=='success'){
        sendOtp(formattedNumber);
        emit(SignupOtpSentState(message: ''));
     } else {
        emit(SignupFailureState(message: response['message']));
     } 
    });
  }
  FutureOr<void> signupUserwithOtpEvent(SignupUserwithOtpEvent event,Emitter<SignupState> emit) async {

    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: 'otp',
      );

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      
      final firebaseId = userCredential.user?.uid;
      print(firebaseId);
    } catch (e) {
      
    }
    final userData = event.user.toJson();
    emit(SignupLoadingState());
    final either = await SignupRepo().signupUser(userData);
    either.fold((error){
      emit(SignupErrorState(message:error.message));
    },
    (response){
      if(response['status'] == 'success'){

      }
    });
  }


  FutureOr<void> checkingUserEvent(event, emit) => null;

  sendOtp(String formattedNumber) async {
    print('Sending Otp');
    await _auth.verifyPhoneNumber(
        phoneNumber: formattedNumber,
        timeout: Duration(seconds: 60),
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

}
