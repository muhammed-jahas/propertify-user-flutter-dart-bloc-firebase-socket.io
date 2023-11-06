part of 'property_bloc.dart';

abstract class PropertyEvent {}


class sendRequstEvent extends PropertyEvent {
  final CreateRequest request;

  sendRequstEvent({required this.request});
}

class ResetPropertyEvent extends PropertyEvent {}