part of 'login_bloc.dart';


abstract class LoginState {}

final class InitialState extends LoginState {}

class LoginLoadingState extends LoginState {}

final class LoginSuccessState extends LoginState {
  final String message;
  LoginSuccessState({required this.message});
}

final class LoginFailureState extends LoginState {
  final String message;
  LoginFailureState({required this.message});

}

final class ErrorState extends LoginState {
  final String message;
  ErrorState({required this.message});
}