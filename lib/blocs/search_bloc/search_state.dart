part of 'search_bloc.dart';

abstract class SearchState {}

final class SearchInitial extends SearchState {}

class SearchLoadingState extends SearchState {
  final bool isLoading;

  SearchLoadingState({this.isLoading = true});
}


final class SearchLoadedSuccessState extends SearchState {
  final List<PropertyModel> properties;

  SearchLoadedSuccessState({required this.properties});
}

final class SearchLoadedFailedState extends SearchState {}

final class SearchErroState extends SearchState {}
