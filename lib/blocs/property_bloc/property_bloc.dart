import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';

import '../../models/request_sending_model.dart';
import '../../repositories/property_repo/property_repo.dart';

part 'property_event.dart';
part 'property_state.dart';

class PropertyBloc extends Bloc<PropertyEvent, PropertyState> {
  PropertyBloc() : super(PropertyInitial()) {
    on<PropertyEvent>((event, emit) {});
    on<sendRequstEvent>(propertysendRequstEvent);
  }

  FutureOr<void> propertysendRequstEvent(
      sendRequstEvent event, Emitter<PropertyState> emit) async {
    final either = await PropertyRepo().sendPropertyRequest(event.request);
    either.fold(
        (Error) => {},
        (response) => {
              if (response['status'] == 'success')
                {
                  print('Successfully Send Request'),
                  emit(ProperyRequstSendState(message: response['message']))
                }
              else
                {emit(RequestErrorState(message: response['message']))}
                
            });
    await Future.delayed(Duration(seconds: 2));
    emit(PropertyInitial());
    await Future.delayed(Duration(seconds: 1));
    emit(RequestSendPopState());
    await Future.delayed(Duration(seconds: 1));
    emit(PropertyInitial());
  }
}
