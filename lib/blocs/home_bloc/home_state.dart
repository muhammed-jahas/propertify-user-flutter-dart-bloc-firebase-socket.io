part of 'home_bloc.dart';


abstract class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoadingState extends HomeState {}

final class HomeLoadedSuccessState extends HomeState {
  final List<PropertyModel> properties;

  HomeLoadedSuccessState({required this.properties});

}

final class HomeLoadedFailedState extends HomeState {}

final class HomeErrorState extends HomeState {}
