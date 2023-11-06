part of 'payment_bloc.dart';

abstract class PaymentRequestsState {}

final class PaymentRequestsInitial extends PaymentRequestsState {}

final class PaymentRequestsLoadingState extends PaymentRequestsState {}

final class PaymentRequestsLoadedSuccessState extends PaymentRequestsState {
  final List<RequestRecievingModel> paymentRequests;

  PaymentRequestsLoadedSuccessState({required this.paymentRequests});
}

final class PaymentRequestsLoadedFailedState extends PaymentRequestsState {}

final class PaymentRequestsErrorState extends PaymentRequestsState {}
