import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:propertify/models/request_recieving_model.dart';
import 'package:propertify/repositories/payment_repo/payment_repo.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentRequestsBloc extends Bloc<PaymentRequestsEvent, PaymentRequestsState> {

  String userId = '6545e400521e0dd883e084f7';

  PaymentRequestsBloc() : super(PaymentRequestsInitial()) {
    on<getAllPaymentRequestsEvent>(paymentRequestsEvent);
  }

  FutureOr<void> paymentRequestsEvent(event, emit) async {
    emit(PaymentRequestsLoadingState());
    await Future.delayed(Duration(seconds: 1));
    print(userId);
    final either = await PaymentRepo().getAllPaymentRequests(userId);

    either.fold((error) {}, (response) {
      if (response['status'] == 'success') {
        print('in checking status');
        final List rawData = response['paymentrequests'];
        final List<RequestRecievingModel> paymentRequests = rawData
            .map((json) => RequestRecievingModel.fromJson(json))
            .toList();
        emit(PaymentRequestsLoadedSuccessState(paymentRequests: paymentRequests));
      } else {
        print('Failed to Get Payment Requests');
        emit(PaymentRequestsLoadedFailedState());
      }
    });
  }
}
