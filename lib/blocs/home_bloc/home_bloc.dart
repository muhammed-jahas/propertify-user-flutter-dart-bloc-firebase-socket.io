import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:propertify/repositories/property_repo/property_repo.dart';
import '../../models/property_model.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<getAllProperties>(homeGetAllPropertiesEvent);
    // on<getAllFavouriteProperties>(GetAllFavouriteProperties);
  }

  FutureOr<void> homeGetAllPropertiesEvent(event, emit) async {
    print('Start homeGetAllPropertiesEvent');
    emit(HomeLoadingState());
    await Future.delayed(Duration(seconds: 2));
    final either = await PropertyRepo().getAllProperties();
    print('Here');
    either.fold((error) => {}, (response) {
      if (response['status'] == 'success') {
        final List rawData = response['properties'];
        // final List<PropertyModel> properties =
        //     rawData.map((e) => PropertyModel.fromJson(e)).toList();
        final List<PropertyModel> properties = rawData
            .map((e) => PropertyModel.fromJson(e))
            .where(
                (property) => !property.isSold!) // Filter out sold properties
            .toList();
        print('Here');
        print('End homeGetAllPropertiesEvent');
        emit(HomeLoadedSuccessState(properties: properties));
      } else {
        print('Failed to get properties');
        emit(HomeLoadedFailedState());
      }
    });
  }
}
