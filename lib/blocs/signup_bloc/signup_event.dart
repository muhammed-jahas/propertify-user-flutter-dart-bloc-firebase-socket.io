part of 'signup_bloc.dart';

abstract class SignupEvent {}

class SignupUserEvent extends SignupEvent {
  UserModel user;
  SignupUserEvent({required this.user});
  
}

class SignupUserwithOtpEvent extends SignupEvent {
  UserModel user;
  SignupUserwithOtpEvent({required this.user});
  
}