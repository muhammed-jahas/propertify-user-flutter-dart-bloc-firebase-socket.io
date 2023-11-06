import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:propertify/models/property_model.dart';
import 'package:propertify/repositories/property_repo/property_repo.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  List<PropertyModel> allProperties = []; // Store all properties here

  SearchBloc() : super(SearchInitial()) {
    on<SearchInputChangedEvent>((event, emit) {
      print('Search input changed: ${event.searchInput}');
      emit(SearchLoadingState());
      final searchInput = event.searchInput;
      final filteredProperties = _filterProperties(searchInput);
      emit(SearchLoadedSuccessState(properties: filteredProperties));
    });

    on<SearchInitialEvent>(_fetchAllProperties);
    on<GetAllPropertiesEvent>(_fetchAllProperties);
  }

  List<PropertyModel> _filterProperties(String searchInput) {
    // Filter properties based on Property Name and Property City from 'allProperties'
    return allProperties.where((property) {
      final propertyName = property.propertyName.toLowerCase();
      final propertyCity = property.propertyCity.toLowerCase();
      final query = searchInput.toLowerCase();
      return propertyName.contains(query) || propertyCity.contains(query);
    }).toList();
  }

  FutureOr<void> searchForPropertiesEvent(event, emit) {
    emit(SearchInitial());
  }

  FutureOr<void> getAllPropertiesEvent(event, emit) async {
    emit(SearchLoadingState());
    final either = await PropertyRepo().getAllProperties();

    either.fold(
      (error) {
        print('Error: $error');
        emit(SearchLoadedFailedState());
      },
      (response) {
        if (response['status'] == 'success') {
          final List rawData = response['properties'];
          final List<PropertyModel> properties =
              rawData.map((json) => PropertyModel.fromJson(json)).toList();
          allProperties = properties; // Store properties in 'allProperties'
          print('Fetched ${properties.length} properties');
          emit(SearchLoadedSuccessState(properties: properties));
        } else {
          print('Failed to get Properties');
          emit(SearchLoadedFailedState());
        }
      },
    );
  }
  void _fetchAllProperties(event, emit) async {
    emit(SearchLoadingState());
    await Future.delayed(Duration(seconds: 1));
    final either = await PropertyRepo().getAllProperties();

    either.fold(
      (error) {
        print('Error: $error');
        emit(SearchLoadedFailedState());
      },
      (response) {
        if (response['status'] == 'success') {
          final List rawData = response['properties'];
          final List<PropertyModel> properties =
              rawData.map((json) => PropertyModel.fromJson(json)).toList();
          allProperties = properties;
          print('Fetched ${properties.length} properties');
          emit(SearchLoadedSuccessState(properties: properties));
        } else {
          print('Failed to get Properties');
          emit(SearchLoadedFailedState());
        }
      },
    );
  }

}
