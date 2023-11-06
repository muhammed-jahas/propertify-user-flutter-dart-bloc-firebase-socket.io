part of 'signup_bloc.dart';

abstract class SignupState {}

final class SignupInitial extends SignupState {}

class SignupLoadingState extends SignupState {} 

final class SignupSuccessState extends SignupState {
  final String message;
  SignupSuccessState({required this.message});
}

final class SignupFailureState extends SignupState {
  final String message;
  SignupFailureState({required this.message});
}

final class SignupOtpSentState extends SignupState {
  final String message;
  
  SignupOtpSentState({required this.message});
}

final class SignupErrorState extends SignupState {
  final String message;
  SignupErrorState({required this.message});
}
