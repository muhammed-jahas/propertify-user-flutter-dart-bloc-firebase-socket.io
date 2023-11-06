part of 'login_bloc.dart';

abstract class LoginEvent {}

class LoginUserEvent extends LoginEvent {
  final String userPhone;
  LoginUserEvent({required this.userPhone});
}

class SignUpUserEvent extends LoginEvent {
  final UserModel user;
  SignUpUserEvent({required this.user});
}


