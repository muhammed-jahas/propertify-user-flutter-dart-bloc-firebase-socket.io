part of 'search_bloc.dart';

abstract class SearchEvent {}

class SearchInitialEvent extends SearchEvent {}

class GetAllPropertiesEvent extends SearchEvent {}

class GetSearchResultsEvent extends SearchEvent {}

class SearchInputChangedEvent extends SearchEvent {
  final String searchInput;

  SearchInputChangedEvent(this.searchInput);
}
