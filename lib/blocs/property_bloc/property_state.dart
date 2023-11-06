part of 'property_bloc.dart';

abstract class PropertyState {}

final class PropertyInitial extends PropertyState {}

final class ProperyRequstSendState extends PropertyState {
  final String message;

  ProperyRequstSendState({required this.message});
}

final class RequestSendPopState extends PropertyState {

  
}

final class RequestErrorState extends PropertyState {
  final String message;

  RequestErrorState({required this.message});
}
