part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

//states to build UI

class HomeLoadingState extends HomeState {}

class HomeLoadedState extends HomeState {
  final int selectedSeat;

  HomeLoadedState({required this.selectedSeat});
}

class HomeErrorState extends HomeState {}

//states to take action
abstract class HomeActionState extends HomeState {}

class HomeShowSnackBarState extends HomeActionState {}
